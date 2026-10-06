{{- define "flagsmith.experimentation.secretName" -}}
{{- printf "%s-experimentation" (include "flagsmith.fullname" .) -}}
{{- end -}}

{{- define "flagsmith.experimentation.clickhouseUrlSecretRef" -}}
{{- with .Values.experimentation.clickhouse.urlFromExistingSecret -}}
{{- if .enabled -}}
name: {{ required "experimentation.clickhouse.urlFromExistingSecret.name is required" .name }}
key: {{ required "experimentation.clickhouse.urlFromExistingSecret.key is required" .key }}
{{- else -}}
name: {{ include "flagsmith.experimentation.secretName" $ }}
key: CLICKHOUSE_URL
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "flagsmith.experimentation.adminClickhouseUrlSecretRef" -}}
{{- with .Values.jobs.experimentationInit.clickhouseUrl.fromExistingSecret -}}
{{- if .enabled -}}
name: {{ required "jobs.experimentationInit.clickhouseUrl.fromExistingSecret.name is required" .name }}
key: {{ required "jobs.experimentationInit.clickhouseUrl.fromExistingSecret.key is required" .key }}
{{- else -}}
{{- include "flagsmith.experimentation.clickhouseUrlSecretRef" $ -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "flagsmith.experimentation.kafkaPasswordSecretRef" -}}
{{- with .Values.experimentation.kafka.passwordFromExistingSecret -}}
{{- if .enabled -}}
name: {{ required "experimentation.kafka.passwordFromExistingSecret.name is required" .name }}
key: {{ required "experimentation.kafka.passwordFromExistingSecret.key is required" .key }}
{{- else -}}
name: {{ include "flagsmith.experimentation.secretName" $ }}
key: KAFKA_PASSWORD
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
DATABASE_URL secretKeyRef body for a component: its own user if configured, else the API's.
Usage: (dict "root" . "existingSecret" <component>.databaseUrlFromExistingSecret)
*/}}
{{- define "flagsmith.experimentation.databaseUrlSecretRef" -}}
{{- with .existingSecret -}}
{{- if .enabled -}}
name: {{ required "databaseUrlFromExistingSecret.name is required" .name }}
key: {{ required "databaseUrlFromExistingSecret.key is required" .key }}
{{- else -}}
{{- include "flagsmith.api.databaseUrlSecretRef" $.root -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Kafka env for a container.
Usage: (dict "root" . "username" <string> "passwordRef" <secretKeyRef body>)
*/}}
{{- define "flagsmith.experimentation.kafkaEnv" -}}
{{- $kafka := .root.Values.experimentation.kafka -}}
- name: KAFKA_BOOTSTRAP_SERVERS
  value: {{ $kafka.bootstrapServers | quote }}
- name: KAFKA_TOPIC
  value: {{ $kafka.topic | quote }}
- name: KAFKA_AUTH
  value: {{ $kafka.auth | quote }}
{{- if eq $kafka.auth "scram" }}
- name: KAFKA_USERNAME
  value: {{ .username | quote }}
- name: KAFKA_PASSWORD
  valueFrom:
    secretKeyRef:
      {{- .passwordRef | nindent 6 }}
{{- end }}
{{- end -}}

{{- define "flagsmith.experimentation.validate" -}}
{{- $e := .Values.experimentation -}}
{{- if not (or $e.clickhouse.url $e.clickhouse.urlFromExistingSecret.enabled) -}}
{{- fail "experimentation.clickhouse.url or experimentation.clickhouse.urlFromExistingSecret is required" -}}
{{- end -}}
{{- if not $e.kafka.bootstrapServers -}}
{{- fail "experimentation.kafka.bootstrapServers is required" -}}
{{- end -}}
{{- if not (has $e.kafka.auth (list "scram" "none")) -}}
{{- fail "experimentation.kafka.auth must be scram or none" -}}
{{- end -}}
{{- if eq $e.kafka.auth "scram" -}}
{{- if not $e.kafka.username -}}
{{- fail "experimentation.kafka.username is required when experimentation.kafka.auth is scram" -}}
{{- end -}}
{{- if not (or $e.kafka.password $e.kafka.passwordFromExistingSecret.enabled) -}}
{{- fail "experimentation.kafka.password or experimentation.kafka.passwordFromExistingSecret is required when experimentation.kafka.auth is scram" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "flagsmith.experimentation.apiEnv" -}}
{{- if .Values.experimentation.enabled }}
- name: EXPERIMENTATION_CLICKHOUSE_URL
  valueFrom:
    secretKeyRef:
      {{- include "flagsmith.experimentation.clickhouseUrlSecretRef" . | nindent 6 }}
{{- end }}
{{- end -}}

{{- define "flagsmith.experimentation.externalTopic" -}}
external_warehouse_events
{{- end -}}

{{- define "flagsmith.experimentation.retryTopic" -}}
external_warehouse_events_retry
{{- end -}}

{{/*
Space-separated topics the init job creates.
*/}}
{{- define "flagsmith.experimentation.topics" -}}
{{- .Values.experimentation.kafka.topic -}}
{{- if .Values.experimentation.warehouseDelivery.enabled -}}
{{- printf " %s %s" (include "flagsmith.experimentation.externalTopic" .) (include "flagsmith.experimentation.retryTopic" .) -}}
{{- end -}}
{{- end -}}
