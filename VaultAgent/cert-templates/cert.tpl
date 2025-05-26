{{ with secret "pki/issue/keycloak" "common_name=localhost" "ttl=24h" }}
{{ .Data.certificate }}
{{ end }}