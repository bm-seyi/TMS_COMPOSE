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
## Added
- Added `entrypoint.sh` script for initializing Vault in development mode and configuring the PKI secrets engine with root certificates and URLs.
- Added Vault entrypoint configuration in the `docker-compose.yml` file to specify the newly added `entrypoint.sh` file.
- Updated Vault service in `docker-compose.yml` to use the image `hashicorp/vault:latest` instead of the previous `tms-vault:latest`.
- Added environment variable `VAULT_ADDR` to the Vault service configuration in `docker-compose.yml`.

## Fixed/Updated
- Updated the Redis services' Docker image from `tms-redis:latest` to the official `redis` image in both `README.MD` and `docker-compose.yml`.


## 0.1.2
## Added
- Introduced `compose-build-test.yml` workflow to validate that `docker-compose.yml` builds and runs without errors.

## Fixed/Updated
- Removed `external: true` from the `tms_network` definition in `docker-compose.yml`; the network is now fully managed by Docker Compose.