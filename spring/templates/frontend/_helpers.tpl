{{/*Image pull secrets are essentially a combination of registry, username, and password. You may need them in an application you are deploying, but to create them requires running base64 a couple of times
*/}}
{{- define "imagePullSecret" }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.frontend.imageCredentials.registry (printf "%s:%s" .Values.frontend.imageCredentials.username .Values.frontend.imageCredentials.password | b64enc) | b64enc }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "spring.serviceAccountName" -}}
{{- if .Values.frontend.serviceAccount.create -}}
    {{ default (include "spring.fullname" .) .Values.frontend.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.frontend.serviceAccount.name }}
{{- end -}}
{{- end -}}