{{/*
Expand the name of the chart.
*/}}
{{- define "clearml.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "clearml.fullname" -}}
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
{{- define "clearml.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "clearml.labels" -}}
helm.sh/chart: {{ include "clearml.chart" . }}
{{ include "clearml.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "clearml.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clearml.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Reference Name (apiserver)
*/}}
{{- define "apiserver.referenceName" -}}
{{- include "clearml.name" . }}-apiserver
{{- end }}

{{/*
Selector labels (apiserver)
*/}}
{{- define "apiserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clearml.name" . }}
app.kubernetes.io/instance: {{ include "apiserver.referenceName" . }}
{{- end }}

{{/*
Reference Name (fileserver)
*/}}
{{- define "fileserver.referenceName" -}}
{{- include "clearml.name" . }}-fileserver
{{- end }}

{{/*
Selector labels (fileserver)
*/}}
{{- define "fileserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clearml.name" . }}
app.kubernetes.io/instance: {{ include "fileserver.referenceName" . }}
{{- end }}

{{/*
Reference Name (webserver)
*/}}
{{- define "webserver.referenceName" -}}
{{- include "clearml.name" . }}-webserver
{{- end }}

{{/*
Selector labels (webserver)
*/}}
{{- define "webserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clearml.name" . }}
app.kubernetes.io/instance: {{ include "webserver.referenceName" . }}
{{- end }}

{{/*
Reference Name (apps)
*/}}
{{- define "clearmlApplications.referenceName" -}}
{{- include "clearml.name" . }}-apps
{{- end }}

{{/*
Selector labels (apps)
*/}}
{{- define "clearmlApplications.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clearml.name" . }}
app.kubernetes.io/instance: {{ include "clearmlApplications.referenceName" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "clearml.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "clearml.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
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
Create readiness probe auth token
*/}}
{{- define "readinessProbeAuth" }}
{{- printf "%s:%s" .Values.clearml.readinessprobeKey .Values.clearml.readinessprobeSecret | b64enc }}
{{- end }}

{{/*
Elasticsearch Service name
*/}}
{{- define "elasticsearch.servicename" -}}
{{- if .Values.elasticsearch.enabled }}
{{- .Values.elasticsearch.clusterName }}-master
{{- else }}
{{- .Values.externalServices.elasticsearchHost }}
{{- end }}
{{- end }}

{{/*
Elasticsearch Service port
*/}}
{{- define "elasticsearch.serviceport" -}}
{{- if .Values.elasticsearch.enabled }}
{{- .Values.elasticsearch.httpPort }}
{{- else }}
{{- .Values.externalServices.elasticsearchPort }}
{{- end }}
{{- end }}

{{/*
MongoDB Comnnection string
*/}}
{{- define "mongodb.connectionstring" -}}
{{- if eq .Values.mongodb.architecture "standalone" }}
{{- printf "%s%s%s" "mongodb://" .Release.Name "-mongodb:27017" }}
{{- else }}
{{- $connectionString := "mongodb://" }}
{{- range $i,$e := until (.Values.mongodb.replicaCount | int) }}
{{- $connectionString = printf "%s%s%s%s%s%s%s%s%s" $connectionString $.Release.Name "-mongodb-" ( $i | toString ) "." $.Release.Name "-mongodb-headless." $.Release.Namespace ".svc.cluster.local," }}
{{- end }}
{{- printf "%s" ( trimSuffix "," $connectionString ) }}
{{- end }}
{{- end }}

{{/*
Redis Service name
*/}}
{{- define "redis.servicename" -}}
{{- if .Values.redis.enabled }}
{{- tpl .Values.redis.master.name . }}
{{- else }}
{{- .Values.externalServices.redisHost }}
{{- end }}
{{- end }}

{{/*
Redis Service port
*/}}
{{- define "redis.serviceport" -}}
{{- if .Values.redis.enabled }}
{{- .Values.redis.master.port }}
{{- else }}
{{- .Values.externalServices.redisPort }}
{{- end }}
{{- end }}

{{/*
clientConfiguration string compose
*/}}
{{- define "clearml.clientConfiguration" -}}
{{- $clientConfiguration := "" }}
{{- if and (.Values.clearml.clientConfigurationApiUrl) .Values.clearml.clientConfigurationFilesUrl }}
{{- $clientConfiguration = printf "%s%s%s%s%s" "{\"apiServer\":\"" .Values.clearml.clientConfigurationApiUrl "\",\"filesServer\":\"" .Values.clearml.clientConfigurationFilesUrl "\"}" }}
{{- else if .Values.clearml.clientConfigurationApiUrl }}
{{- $clientConfiguration = printf "%s%s%s" "{\"apiServer\":\"" .Values.clearml.clientConfigurationApiUrl "\"}" }}
{{- else if .Values.clearml.clientConfigurationFilesUrl }}
{{- $clientConfiguration = printf "%s%s%s" "{\"filesServer\":\"" .Values.clearml.clientConfigurationFilesUrl "\"}" }}
{{- end }}
{{- $clientConfiguration }}
{{- end }}
