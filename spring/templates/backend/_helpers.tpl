{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "spring.name" -}}
{{- default .Chart.Name .Values.backend.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*Image pull secrets are essentially a combination of registry, username, and password. You may need them in an application you are deploying, but to create them requires running base64 a couple of times
*/}}
{{- define "imagePullSecret" }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.backend.imageCredentials.registry (printf "%s:%s" .Values.backend.imageCredentials.username .Values.backend.imageCredentials.password | b64enc) | b64enc }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "spring.serviceAccountName" -}}
{{- if .Values.backend.serviceAccount.create -}}
    {{ default (include "spring.fullname" .) .Values.backend.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.backend.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "spring.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
