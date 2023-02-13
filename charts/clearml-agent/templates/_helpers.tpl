{{/*
Expand the name of the chart.
*/}}
{{- define "clearmlAgent.name" -}}
{{- .Release.Name | trunc 59 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "clearmlAgent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 59 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "clearmlAgent.labels" -}}
helm.sh/chart: {{ include "clearmlAgent.chart" . }}
{{ include "clearmlAgent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if $.Values.agentk8sglue.labels }}
{{ toYaml $.Values.agentk8sglue.labels }}
{{- end }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "clearmlAgent.annotations" -}}
{{- if $.Values.agentk8sglue.annotations }}
{{ toYaml $.Values.agentk8sglue.annotations }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "clearmlAgent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clearmlAgent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels (agentk8sglue)
*/}}
{{- define "agentk8sglue.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clearmlAgent.name" . }}
app.kubernetes.io/instance: {{ include "clearmlAgent.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "clearmlAgent.serviceAccountName" -}}
{{- if .Values.agentk8sglue.serviceExistingAccountName }}
{{- .Values.agentk8sglue.serviceExistingAccountName }}
{{- else }}
{{- include "clearmlAgent.name" . }}-sa
{{- end }}
{{- end }}

{{/*
Create secret to access docker registry
*/}}
{{- define "imagePullSecret" }}
{{- with .Values.imageCredentials }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"email\":\"%s\",\"auth\":\"%s\"}}}" .registry .username .password .email (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}


{{/*
Create a string composed by queue names
*/}}
{{- define "agentk8sglue.queues" -}}
{{- $list := list }}
{{- range $key, $value := .Values.enterpriseFeatures.queues }}
{{- $list = append $list (printf "%s" $key) }}
{{- end }}
{{- join " " $list }}
{{- end }}
