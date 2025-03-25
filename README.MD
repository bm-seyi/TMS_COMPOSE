# TMS COMPOSE

## Overview
This project sets up a development environment using Docker Compose, including Redis instances for data protection and session caching, HashiCorp Vault for secrets management, and Microsoft SQL Server for database operations.

## Services

### 1. Redis Data Protection (`redis-data-protection`)
- **Image:** `redis`
- **Container Name:** `tms-redis-data-protection`
- **Port:** `6379:6379`
- **Restart Policy:** `no`
- **Configuration:**
  - Max memory policy: `noeviction`
  - Append-only file enabled

### 2. Redis Session Cache (`redis-session-cache`)
- **Image:** `redis`
- **Container Name:** `tms-redis-session-cache`
- **Port:** `6380:6379`
- **Restart Policy:** `no`
- **Configuration:**
  - Max memory policy: `allkeys-lru`
  - Append-only file disabled

### 3. HashiCorp Vault (`HashiCorp-Vault`)
- **Image:** `hashicorp/vault:latest`
- **Container Name:** `tms-vault`
- **Port:** `8200:8200`
- **Restart Policy:** `no`
- **Capabilities:** `IPC_LOCK`
- **Environment Variables:**
  - `VAULT_DEV_ROOT_TOKEN_ID`: Set via environment variables

### 4. SQL Server (`SqlServer`)
- **Image:** `mcr.microsoft.com/mssql/server:2022-latest`
- **Container Name:** `DevServer`
- **Hostname:** `DevServer`
- **Port:** `1433:1433`
- **Restart Policy:** `unless-stopped`
- **Network:** `tms_network`
- **Environment Variables:**
  - `MSSQL_PWD`: Set via environment variables
  - `ACCEPT_EULA`: `Y`
  - `TZ`: `Europe/London`
- **Volumes:**
  - `mssql_data:/var/opt/mssql`

## Networks
- `tms_network`: A dedicated Docker network for service communication.

## Volumes
- `mssql_data`: External volume for SQL Server data persistence.

## Usage

### Prerequisites
- Install [Docker](https://docs.docker.com/get-docker/)
- Install [Docker Compose](https://docs.docker.com/compose/install/)
- Ensure required environment variables (`VAULT_DEV_ROOT_TOKEN_ID`, `MSSQL_PWD`) are set

### Running the Services
To start the services, run:
```sh
docker-compose up -d
```

To stop the services, run:
```sh
docker-compose down
```

### Checking Logs
To check logs for a specific container, use:
```sh
docker logs <container_name>
```
For example:
```sh
docker logs tms-redis-data-protection
```

### Accessing the SQL Server
You can connect to the SQL Server using tools like SSMS or `sqlcmd`:
```sh
sqlcmd -S localhost,1433 -U sa -P "your_password"
```

## Notes
- Ensure that `mssql_data` volume exists before running the SQL Server container.
- Vault requires authentication; ensure the root token is securely stored.
- Redis session cache is configured to use an LRU eviction policy to optimize memory usage.

## Troubleshooting
- If you encounter permission issues with volumes, try:
```sh
sudo chown -R $(whoami):$(whoami) <volume_path>
```
- Check running containers with:
```sh
docker ps
```
- Restart a specific service:
```sh
docker-compose restart <service_name>
```

## License
This work is licensed under a [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License](./LICENSE).
