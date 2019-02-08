{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "elasticsearch.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 53 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 53 chars (63 - len("-discovery")) because some Kubernetes name fields are limited to 63 (by the DNS naming spec).
*/}}
{{- define "elasticsearch.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 53 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "elasticsearch.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for Curactor cron job.
Could use .Capabilities.KubeVersion.Minor in future.
*/}}
{{- define "curator.cronJob.apiVersion" -}}
"batch/v1beta1"
{{- end -}}

{{/*
Init image name.
*/}}
{{- define "init.image" -}}
{{ .Values.images.init.repository }}:{{ .Values.images.init.tag }}
{{- end -}}

{{/*
Elasticsearch image name.
*/}}
{{- define "elasticsearch.image" -}}
{{ .Values.images.es.repository }}:{{ .Values.images.es.tag }}
{{- end -}}

{{/*
Curator image name.
*/}}
{{- define "curator.image" -}}
{{ .Values.images.curator.repository }}:{{ .Values.images.curator.tag }}
{{- end -}}

{{/*
Exporter image name.
*/}}
{{- define "exporter.image" -}}
{{ .Values.images.exporter.repository }}:{{ .Values.images.exporter.tag }}
{{- end -}}

{{/*
Elasticsearch NGINX variable definitions
*/}}

{{- define "nginx-es.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "nginx-es.fullname" -}}
{{- if .Values.nginx.fullnameOverride -}}
{{- .Values.nginx.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "nginx-es.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{ define "nginx-es.image" -}}
{{ .Values.images.nginx.repository }}:{{ .Values.images.nginx.tag }}
{{- end }}

{{ define "nginx-es.ingress.class" -}}
{{- if .Values.nginx.ingressClass -}}
{{- .Values.nginx.ingressClass -}}
{{- else }}
{{- template "nginx-es.fullname" . -}}
{{- end -}}
{{- end -}}
