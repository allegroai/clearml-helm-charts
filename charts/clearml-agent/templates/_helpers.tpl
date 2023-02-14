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

{{/*
Create a task container template
*/}}
{{- define "taskContainer.containerTemplate" -}}
{{- if .main.Values.imageCredentials.enabled }}
imagePullSecrets:
  - name: {{ .main.Values.imageCredentials.existingSecret | default (printf "%s-ark" (include "clearmlAgent.name" .main )) }}
{{- end }}
schedulerName: {{ .value.templateOverrides.schedulerName | default (.main.Values.agentk8sglue.basePodTemplate.schedulerName) }}
restartPolicy: Never
securityContext:
  {{- .value.templateOverrides.securityContext | default .main.Values.agentk8sglue.basePodTemplate.securityContext | toYaml | nindent 2 }}
hostAliases:
  {{- .value.templateOverrides.hostAliases | default .main.Values.agentk8sglue.basePodTemplate.hostAliases | toYaml | nindent 2 }}
volumes:
  {{ $computedvolumes := (.value.templateOverrides.volumes | default .main.Values.agentk8sglue.basePodTemplate.volumes) }}
  {{- if $computedvolumes }}{{- $computedvolumes | toYaml | nindent 2 }}{{- end }}
  {{- if .value.templateOverrides.fileMounts }}
  - name: filemounts
    secret:
      secretName: {{ include "clearmlAgent.name" .main }}-{{ .key }}-fm
  {{- else if .main.Values.agentk8sglue.basePodTemplate.fileMounts }}
  - name: filemounts
    secret:
      secretName: {{ include "clearmlAgent.name" .main }}-fm
  {{- end }}
{{- if not .main.Values.enterpriseFeatures.serviceAccountClusterAccess }}
serviceAccountName: {{ include "clearmlAgent.serviceAccountName" .main }}
{{- end }}
initContainers:
  {{- .value.templateOverrides.initContainers | default .main.Values.agentk8sglue.basePodTemplate.initContainers | toYaml | nindent 2 }}
containers:
- resources:
    {{- .value.templateOverrides.resources | default .main.Values.agentk8sglue.basePodTemplate.resources | toYaml | nindent 4 }}
  ports:
    - containerPort: 10022
  volumeMounts:
    {{ $computedvolumemounts := (.value.templateOverrides.volumeMounts | default .main.Values.agentk8sglue.basePodTemplate.volumeMounts) }}
    {{- if $computedvolumemounts }}{{- $computedvolumemounts | toYaml | nindent 4 }}{{- end }}
    {{- if .value.templateOverrides.fileMounts }}
    {{- range .value.templateOverrides.fileMounts }}
    - name: filemounts
      mountPath: "{{ .folderPath }}/{{ .name }}"
      subPath: "{{ .name }}"
      readOnly: true
    {{- end }}
    {{- else if .main.Values.agentk8sglue.basePodTemplate.fileMounts }}
    {{- range .main.Values.agentk8sglue.basePodTemplate.fileMounts }}
    - name: filemounts
      mountPath: "{{ .folderPath }}/{{ .name }}"
      subPath: "{{ .name }}"
      readOnly: true
    {{- end }}
    {{- end }}
  env:
    - name: CLEARML_API_HOST
      value: {{ .main.Values.agentk8sglue.apiServerUrlReference }}
    - name: CLEARML_WEB_HOST
      value: {{ .main.Values.agentk8sglue.webServerUrlReference }}
    - name: CLEARML_FILES_HOST
      value: {{ .main.Values.agentk8sglue.fileServerUrlReference }}
    {{- if not .main.Values.enterpriseFeatures.useOwnerToken }}
    - name: CLEARML_API_ACCESS_KEY
      valueFrom:
        secretKeyRef:
          name: {{ .main.Values.clearml.existingAgentk8sglueSecret | default (printf "%s-ac" (include "clearmlAgent.name" .main )) }}
          key: agentk8sglue_key
    - name: CLEARML_API_SECRET_KEY
      valueFrom:
        secretKeyRef:
          name: {{ .main.Values.clearml.existingAgentk8sglueSecret | default (printf "%s-ac" (include "clearmlAgent.name" .main )) }}
          key: agentk8sglue_secret
    {{- end }}
    - name: PYTHONUNBUFFERED
      value: "x"
    {{- if not .main.Values.agentk8sglue.clearmlcheckCertificate }}
    - name: CLEARML_API_HOST_VERIFY_CERT
      value: "false"
    {{- end }}
    {{ $computedenvs := (.value.templateOverrides.env| default .main.Values.agentk8sglue.basePodTemplate.env) }}
    {{- if $computedenvs }}{{- $computedenvs | toYaml | nindent 4 }}{{- end }}
nodeSelector:
  {{ .value.templateOverrides.nodeSelector | default .main.Values.agentk8sglue.basePodTemplate.nodeSelector | toYaml | nindent 2 }}
tolerations:
  {{ .value.templateOverrides.tolerations | default .main.Values.agentk8sglue.basePodTemplate.tolerations | toYaml | nindent 2 }}
affinity:
  {{ .value.templateOverrides.affinity | default .main.Values.agentk8sglue.basePodTemplate.affinity | toYaml | nindent 2 }}
{{- end }}

{{/*
Create a task container template
*/}}
{{- define "taskContainer.podTemplate" -}}
{{- range $key, $value := $.Values.enterpriseFeatures.queues }}
{{ $key }}:
  apiVersion: v1
  kind: Pod
  metadata:
    namespace: {{ $.Release.Namespace }}
    labels:
      {{ $value.templateOverrides.labels | default $.Values.agentk8sglue.basePodTemplate.labels | toYaml }}
    annotations:
      {{ $value.templateOverrides.annotations | default $.Values.agentk8sglue.basePodTemplate.annotations | toYaml }}
  spec:
    {{- $data := dict "main" $ "key" $key "value" $value -}}
    {{- include "taskContainer.containerTemplate" $data | nindent 4}}
{{- end }}
{{- end }}

{{/*
Create a task container template
*/}}
{{- define "taskContainer.jobTemplate" -}}
{{- range $key, $value := $.Values.enterpriseFeatures.queues }}
{{ $key }}:
  apiVersion: v1
  kind: Job
  metadata:
    namespace: {{ $.Release.Namespace }}
    labels:
      {{ $value.templateOverrides.labels | default $.Values.agentk8sglue.basePodTemplate.labels | toYaml }}
    annotations:
      {{ $value.templateOverrides.annotations | default $.Values.agentk8sglue.basePodTemplate.annotations | toYaml }}
  spec:
    template:
      spec:
        {{- $data := dict "main" $ "key" $key "value" $value -}}
        {{- include "taskContainer.containerTemplate" $data | nindent 8 }}
        restartPolicy: Never
    backoffLimit: 0
{{- end }}
{{- end }}
