#!/bin/sh
# Creates the experimentation Kafka topics. Safe to run again.
set -eu

die() {
  echo "$*" >&2
  exit 1
}

# A JAAS quoted value, escaped once more for a Java .properties file.
jaas_quote() {
  printf '"%s"' "$(printf '%s' "$1" | sed 's/[\\"]/\\&/g')" | sed 's/\\/\\\\/g'
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
  for topic in $KAFKA_TOPICS; do
    /opt/kafka/bin/kafka-topics.sh --bootstrap-server "$KAFKA_BOOTSTRAP_SERVERS" \
      --command-config "$config" --create --if-not-exists --topic "$topic" \
      --partitions "$KAFKA_TOPIC_PARTITIONS" --replication-factor "$KAFKA_TOPIC_REPLICATION_FACTOR"
  done
}

if [ "${INIT_SH_LIB:-}" != 1 ]; then
  init_kafka
fi
