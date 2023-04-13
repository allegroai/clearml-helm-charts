{{/*
Expand the name of the chart.
*/}}
{{- define "clearmlAgent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "clearmlAgent.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
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
Common labels (agentk8sglue)
*/}}
{{- define "agentk8sglue.labels" -}}
helm.sh/chart: {{ include "clearmlAgent.chart" . }}
{{ include "agentk8sglue.selectorLabels" . }}
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
app.kubernetes.io/name: {{ include "clearmlAgent.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels (agentk8sglue)
*/}}
{{- define "agentk8sglue.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clearmlAgent.fullname" . }}
app.kubernetes.io/instance: {{ include "clearmlAgent.fullname" . }}
{{- end }}

{{/*
Registry name
*/}}
{{- define "registryNamePrefix" -}}
  {{- $registryName := "" -}}
  {{- if .globalValues }}
    {{- if .globalValues.imageRegistry }}
      {{- $registryName = printf "%s/" .globalValues.imageRegistry -}}
    {{- end -}}
  {{- end -}}
  {{- if .imageRegistryValue }}
    {{- $registryName = printf "%s/" .imageRegistryValue -}}
  {{- end -}}
{{- printf "%s" $registryName }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "clearmlAgent.serviceAccountName" -}}
{{- if .Values.agentk8sglue.serviceExistingAccountName }}
{{- .Values.agentk8sglue.serviceExistingAccountName }}
{{- else }}
{{- include "clearmlAgent.fullname" . }}-sa
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
