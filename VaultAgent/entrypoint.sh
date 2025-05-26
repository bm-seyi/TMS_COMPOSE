#!/bin/sh

# Write the token from env var to a file
echo "$VAULT_TOKEN" > /vault/.vault-token

# Run Vault Agent with your config
vault agent -config=config.hcl