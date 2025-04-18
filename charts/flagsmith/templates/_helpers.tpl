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
{{- printf "%s-%s" .Release.Name "postgresql" | trunc 63 | trimSuffix "-" -}}
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
Replicas
*/}}
{{- define "flagsmith.replicaCount" -}}
{{- if not (kindIs "invalid" .) -}}
replicas: {{ . }}
{{- end }}
{{- end }}


{{- define "flagsmith.api.secretKeySecretName" -}}
{{- if .Values.api.secretKeyFromExistingSecret.enabled -}}
{{- .Values.api.secretKeyFromExistingSecret.name -}}
{{- else }}
{{- printf "%s-django-secret-key" (include "flagsmith.fullname" .) -}}
{{- end }}
{{- end }}

{{- define "flagsmith.api.secretKeySecretRef" -}}
name: {{ include "flagsmith.api.secretKeySecretName" . }}
key: {{ default "django-secret-key" .Values.api.secretKeyFromExistingSecret.key }}
{{- end }}

{{- define "flagsmith.sse.authenticationTokenSecretName" -}}
{{- if .Values.sse.authenticationTokenFromExistingSecret.enabled -}}
{{- .Values.sse.authenticationTokenFromExistingSecret.name -}}
{{- else }}
{{- printf "%s-sse-authentication-token" (include "flagsmith.fullname" .) -}}
{{- end }}
{{- end }}

{{- define "flagsmith.sse.authenticationTokenSecretRef" -}}
name: {{ include "flagsmith.sse.authenticationTokenSecretName" . }}
key: {{ default "sse-authentication-token" .Values.sse.authenticationTokenFromExistingSecret.key }}
{{- end }}
