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