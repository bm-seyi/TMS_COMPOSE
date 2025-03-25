#!/bin/sh

# Start Vault in development mode
vault server -dev -dev-root-token-id=$VAULT_DEV_ROOT_TOKEN_ID -dev-listen-address=0.0.0.0:8200 &

# Wait for Vault to be fully initialized
echo "Waiting for Vault to initialize..."
sleep 5

# Enable PKI secrets engine
echo "Enabling PKI secrets engine..."
vault secrets enable pki

# Configure the Root Certificate for PKI
echo "Configuring root certificate..."
vault write pki/root/generate/internal \
    common_name="localhost" \
    ttl=87600h

# Configure the URLs for the PKI engine
echo "Configuring URLs for PKI engine..."
vault write pki/config/urls \
    issuing_certificates="http://localhost:8200/v1/pki/ca" \
    crl_distribution_points="http://localhost:8200/v1/pki/crl" \
    ocsp_servers="http://localhost:8200/v1/pki/ocsp"

# Create a role for issuing certificates
echo "Creating PKI role..."
vault write pki/roles/my-role \
    allowed_domains="localhost" \
    allow_subdomains=true \
    max_ttl="72h"

# Keep the container running to prevent it from exiting
wait