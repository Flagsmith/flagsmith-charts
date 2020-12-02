{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "bullettrain.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bullettrain.fullname" -}}
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
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "bullettrain.postgresql.fullname" -}}
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
{{- define "bullettrain.postgresql.host" -}}
{{- if .Values.postgresql.enabled -}}
{{- template "bullettrain.postgresql.fullname" . -}}
{{- else -}}
{{- .Values.postgresql.postgresqlHost | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres secret
*/}}
{{- define "bullettrain.postgresql.secret" -}}
{{- if .Values.postgresql.enabled -}}
{{- template "bullettrain.postgresql.fullname" . -}}
{{- else -}}
{{- template "bullettrain.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres secretKey
*/}}
{{- define "bullettrain.postgresql.secretKey" -}}
{{- if .Values.postgresql.enabled -}}
"postgresql-password"
{{- else -}}
{{- default "postgresql-password" .Values.postgresql.existingSecretKey | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres port
*/}}
{{- define "bullettrain.postgresql.port" -}}
{{- if .Values.postgresql.enabled -}}
    "5432"
{{- else -}}
{{- default "5432" .Values.postgresql.postgresqlPort | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set redis host
*/}}
{{- define "bullettrain.redis.host" -}}
{{- if .Values.redis.enabled -}}
{{- template "bullettrain.redis.fullname" . -}}-master
{{- else -}}
{{- .Values.redis.host | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set redis secret
*/}}
{{- define "bullettrain.redis.secret" -}}
{{- if .Values.redis.enabled -}}
{{- template "bullettrain.redis.fullname" . -}}
{{- else -}}
{{- template "bullettrain.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Set redis secretKey
*/}}
{{- define "bullettrain.redis.secretKey" -}}
{{- if .Values.redis.enabled -}}
"redis-password"
{{- else -}}
{{- default "redis-password" .Values.redis.existingSecretKey | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set redis port
*/}}
{{- define "bullettrain.redis.port" -}}
{{- if .Values.redis.enabled -}}
    "6379"
{{- else -}}
{{- default "6379" .Values.redis.port | quote -}}
{{- end -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "influxdb.name" -}}
{{- default .Chart.Name .Values.influxdb.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "influxdb.fullname" -}}
{{- if .Values.influxdb.fullnameOverride -}}
{{- .Values.influxdb.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.influxdb.nameOverride -}}
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
{{- define "influxdb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "influxdb.labels" -}}
app.kubernetes.io/name: {{ include "influxdb.name" . }}
helm.sh/chart: {{ include "influxdb.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "influxdb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "influxdb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}