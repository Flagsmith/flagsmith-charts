{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "flagsmith.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "flagsmith.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "flagsmith.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "flagsmith.labels" -}}
helm.sh/chart: {{ include "flagsmith.chart" . }}
{{- with .Values.common.labels }}
{{ . | toYaml }}
{{- end }}
{{ include "flagsmith.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "flagsmith.selectorLabels" -}}
app.kubernetes.io/name: {{ include "flagsmith.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Common annotations
*/}}
{{- define "flagsmith.annotations" -}}
{{- if and (hasKey . "customAnnotations") (hasKey . "commonValues") -}}
{{- with .commonValues.annotations }}
{{ . | toYaml }}
{{- end }}
{{- with .customAnnotations }}
{{ . | toYaml }}
{{- end }}
{{- else -}}
{{- with .annotations }}
{{ . | toYaml }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "flagsmith.postgresql.fullname" -}}
{{- if .Values.devPostgresql.fullnameOverride -}}
{{- .Values.devPostgresql.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.devPostgresql.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "bulletrain-postgresql" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres host
*/}}
{{- define "flagsmith.postgresql.host" -}}
{{- if .Values.devPostgresql.enabled -}}
{{- template "flagsmith.postgresql.fullname" . -}}
{{- else -}}
{{- .Values.devPostgresql.postgresqlHost | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres secret
*/}}
{{- define "flagsmith.postgresql.secret" -}}
{{- if .Values.devPostgresql.enabled -}}
{{- template "flagsmith.postgresql.fullname" . -}}
{{- else -}}
{{- template "flagsmith.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres secretKey
*/}}
{{- define "flagsmith.postgresql.secretKey" -}}
{{- if .Values.devPostgresql.enabled -}}
"postgresql-password"
{{- else -}}
{{- default "postgresql-password" .Values.devPostgresql.existingSecretKey | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres port
*/}}
{{- define "flagsmith.postgresql.port" -}}
{{- if .Values.devPostgresql.enabled -}}
    "5432"
{{- else -}}
{{- default "5432" .Values.devPostgresql.postgresqlPort | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set redis host
*/}}
{{- define "flagsmith.redis.host" -}}
{{- if .Values.redis.enabled -}}
{{- template "flagsmith.redis.fullname" . -}}-master
{{- else -}}
{{- .Values.redis.host | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set redis secret
*/}}
{{- define "flagsmith.redis.secret" -}}
{{- if .Values.redis.enabled -}}
{{- template "flagsmith.redis.fullname" . -}}
{{- else -}}
{{- template "flagsmith.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Set redis secretKey
*/}}
{{- define "flagsmith.redis.secretKey" -}}
{{- if .Values.redis.enabled -}}
"redis-password"
{{- else -}}
{{- default "redis-password" .Values.redis.existingSecretKey | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set redis port
*/}}
{{- define "flagsmith.redis.port" -}}
{{- if .Values.redis.enabled -}}
    "6379"
{{- else -}}
{{- default "6379" .Values.redis.port | quote -}}
{{- end -}}
{{- end -}}

{{/*
Postgres hostname
*/}}
{{- define "flagsmith.postgres.hostname" -}}
{{- printf "%s-%s" .Release.Name .Values.devPostgresql.nameOverride -}}.{{ .Release.Namespace }}.svc.cluster.local
{{- end -}}

{{/*
PgBouncer hostname
*/}}
{{- define "flagsmith.pgbouncer.hostname" -}}
{{- printf "%s-%s" .Release.Name "pgbouncer" -}}.{{ .Release.Namespace }}.svc.cluster.local
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "flagsmith.influxdb.name" -}}
{{- default "influxdb2" .Values.influxdb2.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "flagsmith.influxdb.fullname" -}}
{{- if .Values.influxdb2.fullnameOverride -}}
{{- .Values.influxdb2.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "influxdb2" .Values.influxdb2.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Influxdb hostname
*/}}
{{- define "flagsmith.influxdb.hostname" -}}
{{ template "flagsmith.influxdb.fullname" . }}.{{ .Release.Namespace }}.svc.cluster.local
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "flagsmith.graphite.fullname" -}}
{{- if .Values.graphite.fullnameOverride -}}
{{- .Values.graphite.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.graphite.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "flagsmith-graphite" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Frontend environment
*/}}
{{- define "flagsmith.frontend.environment" -}}
- name: ASSET_URL
  value: '/'
{{- if .Values.frontend.apiProxy.enabled }}
- name: PROXY_API_URL
  value: http://{{ include "flagsmith.fullname" . }}-api.{{ .Release.Namespace }}:{{ .Values.service.api.port }}
- name: FLAGSMITH_PROXY_API_URL
  value: http://{{ include "flagsmith.fullname" . }}-api.{{ .Release.Namespace }}:{{ .Values.service.api.port }}
{{- end }}
{{- range $envName, $envValue := .Values.frontend.extraEnv }}
- name: {{ $envName }}
  value: {{ $envValue | quote }}
{{- end }}
{{- range $envName, $secretKeyRef := .Values.frontend.extraEnvFromSecret }}
- name: {{ $envName }}
  valueFrom:
    secretKeyRef:
      name: {{ $secretKeyRef.secretName }}
      key: {{ $secretKeyRef.secretKey }}
{{- end }}
{{- end }}

{{/*
Database URL
*/}}
{{- define "flagsmith.api.realDatabaseUrl" -}}
{{- if .Values.databaseExternal.enabled -}}
{{- with .Values.databaseExternal -}}
{{- if not .urlFromExistingSecret.enabled -}}
{{- if .url -}}
{{- .url -}}
{{- else -}}
{{- printf "%s://%s:%s@%s:%v/%s" (required "Must specify a database type" .type) (required "Must specify a database username" .username) (required "Must specify a database password" .password) (required "Must specify a database host" .host) (required "Must specify a database port" .port) (required "Must specify a database name" .database) -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- else if .Values.devPostgresql.enabled -}}
{{- printf "%s://%s:%s@%s:%s/%s" "postgres" (.Values.devPostgresql.auth.username | default "postgres") (.Values.devPostgresql.auth.password | default .Values.devPostgresql.auth.postgresPassword | required "Must specify a postgres password") (include "flagsmith.postgres.hostname" . ) "5432" (required "Must specify a postgres database name" .Values.devPostgresql.auth.database) -}}
{{- end -}}
{{- end -}}

{{/*
PgBouncer URL
*/}}
{{- define "flagsmith.api.pgBouncerDatabaseUrl" -}}
{{- $url := (include "flagsmith.api.realDatabaseUrl" .) -}}
{{- $urlParts := (urlParse $url) -}}
{{- $merged := merge (dict "host" (include "flagsmith.pgbouncer.hostname" . | trim)) $urlParts -}}
{{ urlJoin $merged }}
{{- end }}

{{/*
Database URL for application
*/}}
{{- define "flagsmith.api.databaseUrl" -}}
{{- if .Values.pgbouncer.enabled }}
{{ include "flagsmith.api.pgBouncerDatabaseUrl" . }}
{{- else }}
{{ include "flagsmith.api.realDatabaseUrl" . }}
{{- end }}
{{- end }}

{{/*
Replicas
*/}}
{{- define "flagsmith.replicaCount" -}}
{{- if not (kindIs "invalid" .) -}}
replicas: {{ . }}
{{- end }}
{{- end }}


{{/*
Real-time flag updates (SSE)
*/}}
{{- define "flagsmith.sse.authenticationToken" -}}
{{- randAlphaNum 50 -}}
{{- end }}

{{/*
Determine database URL for direct URL format or component parts
*/}}
{{- define "flagsmith.api.formatDatabaseUrl" -}}
{{- if .url -}}
  {{- .url -}}
{{- else -}}
  {{- $type := .type | default "postgres" -}}
  {{- $port := .port | default "5432" -}}
  {{- $password := .password | default "" -}}
  {{- $username := required "Must specify a database username" .username -}}
  {{- $host := required "Must specify a database host" .host -}}
  {{- $database := required "Must specify a database name" .database -}}

  {{- if $password -}}
    {{- printf "%s://%s:%s@%s:%v/%s" $type $username $password $host $port $database -}}
  {{- else -}}
    {{- printf "%s://%s@%s:%v/%s" $type $username $host $port $database -}}
  {{- end -}}
{{- end -}}
{{- end -}}
