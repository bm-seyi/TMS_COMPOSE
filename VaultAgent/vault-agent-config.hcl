auto_auth {
  method {
    type = "token_file"
    config = {
      token_file_path = "/vault/.vault-token"
    }
  }
}

template {
  source      = "/etc/templates/cert.tpl"
  destination = "/etc/keycloak-certs/tls.crt"
}

template {
  source      = "/etc/templates/key.tpl"
  destination = "/etc/keycloak-certs/tls.key"
}

exit_after_auth = false