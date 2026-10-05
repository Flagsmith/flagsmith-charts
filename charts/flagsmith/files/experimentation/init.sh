#!/bin/sh
# Creates the experimentation Kafka topic and ClickHouse schema.
# Usage: init.sh kafka|clickhouse. Every step is safe to run again.
set -eu

die() {
  echo "$*" >&2
  exit 1
}

# A ClickHouse SQL string literal.
sql_quote() {
  printf "'%s'" "$(printf '%s' "$1" | sed 's/[\\'"'"']/\\&/g')"
}

# A JAAS quoted value, escaped once more for a Java .properties file.
jaas_quote() {
  printf '"%s"' "$(printf '%s' "$1" | sed 's/[\\"]/\\&/g')" | sed 's/\\/\\\\/g'
}

# Turns the clickhouse-driver DSN the API uses into clickhouse-client arguments.
parse_clickhouse_url() {
  CH_SECURE=
  CH_INSECURE=
  case $1 in
  clickhouses://*)
    CH_SECURE=--secure
    rest=${1#clickhouses://}
    ;;
  clickhouse://*) rest=${1#clickhouse://} ;;
  *) die "experimentation.clickhouse.url must start with clickhouse:// or clickhouses://" ;;
  esac
  query=
  case $rest in *\?*)
    query=${rest#*\?}
    rest=${rest%%\?*}
    ;;
  esac
  query=$(printf '%s' "$query" | tr 'A-Z' 'a-z')
  case "&$query" in
  *\&secure=true* | *\&secure=1*) CH_SECURE=--secure ;;
  esac
  # The API accepts self-signed certificates with verify=False, so the job does too.
  case "&$query" in
  *\&verify=false* | *\&verify=0*) CH_INSECURE=--accept-invalid-certificate ;;
  esac
  authority=${rest%%/*}
  CH_DATABASE=${rest#"$authority"}
  CH_DATABASE=${CH_DATABASE#/}
  [ -n "$CH_DATABASE" ] || die "experimentation.clickhouse.url needs a database, e.g. clickhouses://user:password@host:9440/flagsmith_exp"
  CH_SERVER=clickhouse://$authority
}

init_kafka() {
  config=/tmp/client.properties
  : >"$config"
  if [ "$KAFKA_AUTH" = scram ]; then
    {
      echo 'security.protocol=SASL_SSL'
      echo 'sasl.mechanism=SCRAM-SHA-512'
      echo "sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username=$(jaas_quote "$KAFKA_USERNAME") password=$(jaas_quote "$KAFKA_PASSWORD");"
    } >"$config"
  fi
  /opt/kafka/bin/kafka-topics.sh --bootstrap-server "$KAFKA_BOOTSTRAP_SERVERS" \
    --command-config "$config" --create --if-not-exists --topic "$KAFKA_TOPIC" \
    --partitions "$KAFKA_TOPIC_PARTITIONS" --replication-factor "$KAFKA_TOPIC_REPLICATION_FACTOR"
}

init_clickhouse() {
  parse_clickhouse_url "$CLICKHOUSE_URL"
  settings="kafka_broker_list = $(sql_quote "$KAFKA_BOOTSTRAP_SERVERS"),
        kafka_topic_list = $(sql_quote "$KAFKA_TOPIC"),
        kafka_group_name = 'clickhouse-events',
        kafka_format = 'JSONAsString',
        kafka_handle_error_mode = 'stream'"
  if [ "$KAFKA_AUTH" = scram ]; then
    settings="$settings,
        kafka_security_protocol = 'sasl_ssl',
        kafka_sasl_mechanism = 'SCRAM-SHA-512',
        kafka_sasl_username = $(sql_quote "$KAFKA_USERNAME"),
        kafka_sasl_password = $(sql_quote "$KAFKA_PASSWORD")"
  fi
  clickhouse-client "$CH_SERVER" $CH_SECURE $CH_INSECURE --query "CREATE DATABASE IF NOT EXISTS \"$CH_DATABASE\""
  clickhouse-client "$CH_SERVER/$CH_DATABASE" $CH_SECURE $CH_INSECURE --multiquery <<SQL
-- Same DDL as docs/docs/experimentation/connect-a-warehouse.md in Flagsmith/flagsmith.
CREATE TABLE IF NOT EXISTS events
(
    environment_key      LowCardinality(String),
    event                LowCardinality(String),
    feature_name         LowCardinality(String),
    timestamp            DateTime64(3),
    collected_at         DateTime64(3),
    identifier           String,
    value                String                          CODEC(ZSTD(3)),
    traits               String                          CODEC(ZSTD(3)),
    metadata             String                          CODEC(ZSTD(3)),
    sdk_language         LowCardinality(String),
    sdk_version          LowCardinality(String),

    INDEX idx_identity identifier TYPE bloom_filter GRANULARITY 4,

    CONSTRAINT environment_key_not_empty CHECK environment_key != '',
    CONSTRAINT event_not_empty           CHECK event != '',
    CONSTRAINT timestamp_sane            CHECK timestamp > toDateTime64('2020-01-01 00:00:00', 3)
)
ENGINE = MergeTree
PARTITION BY toYYYYMMDD(timestamp)
ORDER BY (environment_key, event, feature_name, timestamp, identifier);

CREATE TABLE IF NOT EXISTS events_queue (raw String)
ENGINE = Kafka
SETTINGS $settings;

-- Rows that fail to parse, or would break a constraint on events, are skipped
-- so that one bad message cannot stop the consumer.
CREATE MATERIALIZED VIEW IF NOT EXISTS events_mv TO events AS
SELECT
    JSONExtractString(raw, 'environment_key') AS environment_key,
    JSONExtractString(raw, 'event') AS event,
    JSONExtractString(raw, 'feature_name') AS feature_name,
    fromUnixTimestamp64Milli(JSONExtractInt(raw, 'timestamp')) AS timestamp,
    fromUnixTimestamp64Milli(JSONExtractInt(raw, 'collected_at')) AS collected_at,
    JSONExtractString(raw, 'identifier') AS identifier,
    multiIf(
        JSONType(raw, 'value') = 'String', JSONExtractString(raw, 'value'),
        JSONType(raw, 'value') = 'Null', '',
        JSONExtractRaw(raw, 'value')
    ) AS value,
    JSONExtractString(raw, 'traits') AS traits,
    JSONExtractString(raw, 'metadata') AS metadata,
    JSONExtractString(raw, 'sdk_language') AS sdk_language,
    JSONExtractString(raw, 'sdk_version') AS sdk_version
FROM events_queue
WHERE length(_error) = 0
    AND environment_key != ''
    AND event != ''
    AND timestamp > toDateTime64('2020-01-01 00:00:00', 3);
SQL
}

if [ "${INIT_SH_LIB:-}" != 1 ]; then
  case ${1:-} in
  kafka) init_kafka ;;
  clickhouse) init_clickhouse ;;
  *) die "usage: init.sh kafka|clickhouse" ;;
  esac
fi
