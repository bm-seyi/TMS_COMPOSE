## 0.0.1
First development version

## 0.0.2
### Added
- Added Redis authentication parameters (`--requirepass` and `--masterauth`) to `docker-compose.yml` for `redis` and `redis-session-cache` services.

## 0.1.0
### Added
- Mounted `redis.conf` volume to both `redis-data-protection` and `redis-session-cache` services.
- Explicitly defined `name` and `external: true` for `tms_network` and `mssql_data` volumes.
- Added a new `redis.conf` configuration file with:
  - Networking settings (`bind 0.0.0.0`, `protected-mode yes`, `port 6379`).
  - Performance optimizations (`maxmemory 2gb`, `appendfsync everysec`, save intervals).
  - Resource management (`maxclients 10000`, `timeout 300`, `tcp-keepalive 60`).
  - Logging and monitoring settings (`loglevel notice`, `slowlog-log-slower-than 10000`).
  - High availability configurations (`replica-read-only yes`).
  - Security enhancements (`rename-command FLUSHALL disabled-xyz`, `rename-command SHUTDOWN disabled-def`).
  - Thread management (`io-threads-do-reads yes`, `io-threads 4`).
  - Miscellaneous settings (`hz 50`, `activerehashing yes`).

### Fixed/Updated
- Updated Redis image from `tms-redis:latest` to `redis:8.0-M03` for `redis-data-protection` and `redis-session-cache`.


## 0.1.1
### Added
- Added `entrypoint.sh` script for initializing Vault in development mode and configuring the PKI secrets engine with root certificates and URLs.
- Added Vault entrypoint configuration in the `docker-compose.yml` file to specify the newly added `entrypoint.sh` file.
- Updated Vault service in `docker-compose.yml` to use the image `hashicorp/vault:latest` instead of the previous `tms-vault:latest`.
- Added environment variable `VAULT_ADDR` to the Vault service configuration in `docker-compose.yml`.

### Fixed/Updated
- Updated the Redis services' Docker image from `tms-redis:latest` to the official `redis` image in both `README.MD` and `docker-compose.yml`.


## 0.1.2
### Added
- Introduced `compose-build-test.yml` workflow to validate that `docker-compose.yml` builds and runs without errors.

### Fixed/Updated
- Removed `external: true` from the `tms_network` definition in `docker-compose.yml`; the network is now fully managed by Docker Compose.


## 0.1.3
### Fixed/Updated
- Added step in the GitHub Actions workflow to install Docker Compose (`v2.34.0`), including a version verification step.

## 0.1.4
### Fixed/Updated
- Updated the Docker Compose installation URL in the GitHub Actions workflow to download the `x86_64` version instead of the `aarch64` version.

## 0.1.5
### Fixed/Updated
- Updated the `entrypoint` for the `vault` service in `docker-compose.yml` to ensure the `entrypoint.sh` script is executable before being executed. The new `entrypoint` command adds a `chmod +x` to the script before running it.

## 0.1.6
### Fixed/Updated
- Modified the GitHub Actions workflow to use a `timeout` approach for checking the health of the SQL Server container, replacing the old loop with a health check using Docker’s built-in `docker inspect` command.
- Added a `healthcheck` to the `SqlServer` service in `docker-compose.yml` to monitor the health of the SQL Server container by running a SQL query and retrying if necessary.

### Removed
- Removed the old SQL Server readiness check in the GitHub Actions workflow that manually checked the container’s availability using `sqlcmd`.

## 0.1.7
### Fixed/Updated
- Updated the SQL Server health check logic in the GitHub Actions workflow to use a retry mechanism with a maximum of 30 retries, ensuring better handling of container startup time. The workflow now reports the current health status and exits with an error if the container does not become healthy within the retry limit.


## 0.1.8
### Fixed/Updated
- Relocated the SQL Server health check logic within the GitHub Actions workflow to a later stage, improving the logical flow and grouping it with other test-related steps.
- Updated the `SqlServer` service's `healthcheck` command in `docker-compose.yml` to verify readiness by checking for a specific message in the SQL Server error log, instead of using `sqlcmd`. This improves reliability in detecting when the database is fully ready for client connections.

### Removed
- Removed the earlier placement of the SQL Server health check script from the GitHub Actions workflow to avoid duplication and improve structure.


## 0.1.9
### Added
- Added Keycloak service to docker-compose.yml with:
  - Keycloak container configuration
  - Network and volume configurations for Keycloak
  - Health check for Keycloak service
- Added step in GitHub workflow to create `tms_network` if it doesn't exist

### Fixed/Updated
- Changed Redis images from `redis:8.0-M03` to `redis:alpine3.21` for both redis-data-protection and redis-session-cache services
- Made `tms_network` external in docker-compose.yml


## 0.1.10
### Added
- Added volume creation steps in GitHub workflow for:
  - `keycloak_themes` volume
  - `keycloak_data` volume


## 0.1.11
### Added
- Added `/certs` directory to `.gitignore`
- Added comprehensive Keycloak configuration including:
  - TLS/SSL certificate support
  - Database connection pooling settings
  - Logging and metrics configuration
  - Realm import functionality via `maui_realm.json`
  - Health check and metrics features
  - Various security and performance-related environment variables

### Fixed/Updated
- Updated Keycloak service configuration to:
  - Remove HTTP port (8080) exposure
  - Enhance HTTPS configuration with certificate paths
  - Add schema name for database connection
  - Modify hostname settings
  - Update volume mounts for certificates and realm import
  - Change startup command to include realm import
  - Add numerous performance and security-related settings

### Removed
- Removed direct volume mounts for `keycloak_themes` and `keycloak_data`
- Removed HTTP port (8080) exposure

## 0.1.12
### Added
- Introduced `vault-agent-keycloak` service for dynamic TLS certificate retrieval via Vault Agent.
- Added `keycloak-certs` Docker volume for storing Keycloak certificates.
- Included new VaultAgent configuration files and entrypoint for certificate templating and retrieval.

### Fixed / Updated
- Updated `HashiCorp-Vault` service:
  - Changed `entrypoint.sh` path and logic.
  - Replaced `VAULT_DEV_ROOT_TOKEN_ID` with `VAULT_TOKEN` for consistency.
- Renamed Redis service to `redis-signalr` and simplified configuration.
- Updated volume and mount paths for Keycloak and Vault services.
- Adjusted service dependencies to align with new Vault agent and certificate handling.

### Removed
- Removed Redis services:
  - `redis-session-cache`
  - `redis-data-protection`
- Deleted legacy Vault `entrypoint.sh` used for dev-mode PKI setup.
- Removed `maui_realm.json` from the root directory; now referenced from a new location.
- Deleted `redis.conf` configuration file.
- Removed obsolete Docker volumes:
  - `keycloak_themes`
  - `keycloak_data`


## 0.1.13
### Fixed / Updated
- Updated GitHub Actions workflow to reflect Redis service changes:
  - Removed `tms-redis-data-protection` and `tms-redis-session-cache` connection tests.
  - Replaced with a single `tms-redis-signalr` connection test to match consolidated Redis setup.


## 0.2.0
### Added
- Added NGINX service to handle HTTPS termination and reverse proxy for Keycloak
- Added NGINX configuration and certificates volume mount

### Fixed/Updated
- Updated Keycloak configuration to use HTTP instead of HTTPS (now handled by NGINX)
- Updated Keycloak port mapping (now only exposes 8080 internally)
- Updated network configuration to use bridge driver
- Updated .gitignore to include *.pem files
- Updated Keycloak healthcheck to use HTTP endpoint
- Updated Keycloak proxy and hostname strict settings for HTTP operation

### Removed
- Removed Vault Agent service and all related files (cert-templates, entrypoint.sh, config)
- Removed Keycloak certificate volume and related configurations
- Removed Keycloak HTTPS-specific environment variables
- Removed Keycloak dependency on Vault Agent


## 0.2.1
### Added
- Added SSL/TLS configuration for Keycloak with certificate files
- Added new client attributes in `maui_realm.json` including:
  - PKCE code challenge method
  - Token lifespan settings
  - Backchannel logout settings
  - Various security protocol configurations

### Fixed/Updated
- Updated Keycloak configuration in `docker-compose.yml`:
  - Changed exposed port from 8080 to 8443
  - Enabled strict HTTPS and hostname settings
  - Disabled HTTP and enabled HTTPS with proper certificate paths
  - Updated proxy and security settings
- Updated client configuration in `maui_realm.json` with:
  - Additional URL fields (rootUrl, adminUrl, baseUrl)
  - Comprehensive security attributes
  - Updated logout redirect URI

### Removed
- Removed NGINX reverse proxy configuration (nginx.conf and related service)
- Removed NGINX service from docker-compose.yml


## 0.2.2
### Added
- Added Keycloak health check to GitHub workflow to verify readiness before proceeding
- Added HTTPS health check for Keycloak on port 8443 with retry logic

### Fixed/Updated
- Updated Keycloak image source from Docker Hub (`keycloak/keycloak`) to Quay.io (`quay.io/keycloak/keycloak`)

### Removed
- Removed redundant HTTP health check configuration for Keycloak from docker-compose.yml