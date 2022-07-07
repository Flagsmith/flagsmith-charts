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
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "flagsmith.postgresql.fullname" -}}
{{- if .Values.postgresql.fullnameOverride -}}
{{- .Values.postgresql.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.postgresql.nameOverride -}}
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
{{- if .Values.postgresql.enabled -}}
{{- template "flagsmith.postgresql.fullname" . -}}
{{- else -}}
{{- .Values.postgresql.postgresqlHost | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres secret
*/}}
{{- define "flagsmith.postgresql.secret" -}}
{{- if .Values.postgresql.enabled -}}
{{- template "flagsmith.postgresql.fullname" . -}}
{{- else -}}
{{- template "flagsmith.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres secretKey
*/}}
{{- define "flagsmith.postgresql.secretKey" -}}
{{- if .Values.postgresql.enabled -}}
"postgresql-password"
{{- else -}}
{{- default "postgresql-password" .Values.postgresql.existingSecretKey | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres port
*/}}
{{- define "flagsmith.postgresql.port" -}}
{{- if .Values.postgresql.enabled -}}
    "5432"
{{- else -}}
{{- default "5432" .Values.postgresql.postgresqlPort | quote -}}
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
{{- printf "%s-%s" .Release.Name .Values.postgresql.nameOverride -}}.{{ .Release.Namespace }}.svc.cluster.local
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
{{- if and .Values._destructiveTests.enabled .Values._destructiveTests.testToken }}
- name: E2E_TEST_TOKEN_PROD
  value: {{ .Values._destructiveTests.testToken | quote }}
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
{{- else if .Values.postgresql.enabled -}}
{{- printf "%s://%s:%s@%s:%s/%s" "postgres" (required "Must specify a postgres username" .Values.postgresql.postgresqlUsername) (required "Must specify a postgres password" .Values.postgresql.postgresqlPassword) (include "flagsmith.postgres.hostname" . ) "5432" (required "Must specify a postgres database name" .Values.postgresql.postgresqlDatabase) -}}
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
Curl Test container
*/}}
{{- define "flagsmith.tests.curlContainer" -}}
name: {{ .name }}
image: curlimages/curl
command: ['curl']
args:
  - --fail
  - --max-time
  - {{ .maxTime | squote }}
  - --silent
{{- if not .printResponseBody }}
  - --output
  - /dev/null
{{- end }}
  - --write-out
  - 'URL: %{url_effective}\nHTTP status code: %{http_code}\nBytes downloaded: %{size_download}\nTime taken: %{time_total}s\n'
  - {{ .url | squote }}
{{- end }}
