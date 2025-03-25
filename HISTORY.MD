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
