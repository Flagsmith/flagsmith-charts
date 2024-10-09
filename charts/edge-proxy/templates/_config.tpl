{{/*
Retrieve configMap name from the name of the chart or the ConfigMap the user
specified.
*/}}
{{- define "edge-proxy.config-map.name" -}}
{{- if .Values.edgeProxy.configMap.name -}}
{{- .Values.edgeProxy.configMap.name }}
{{- else -}}
{{- include "edge-proxy.fullname" . }}
{{- end }}
{{- end }}

{{/*
The name of the config file is the default or the key the user specified in the
ConfigMap.
*/}}
{{- define "edge-proxy.config-map.key" -}}
{{- if .Values.edgeProxy.configMap.key -}}
{{- .Values.edgeProxy.configMap.key }}
{{- else -}}
config.json
{{- end }}
{{- end }}
