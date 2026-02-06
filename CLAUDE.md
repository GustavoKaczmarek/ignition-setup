# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an Ignition SCADA platform development environment using Docker Compose. Designed for **cross-machine development** (Mac, WSL, cloud) with all configuration data stored in the repository.

**Stack:**
- **Ignition Gateway**: Industrial automation platform by Inductive Automation
- **PostgreSQL**: Primary relational database
- **Microsoft SQL Server**: Secondary database for enterprise integrations
- **Mosquitto**: MQTT broker for IoT/IIoT messaging

**Timezone:** Asia/Singapore

## Commands

```bash
docker compose up -d          # Start all services
docker compose down           # Stop all services
docker compose logs -f        # View all logs
docker compose logs -f ignition  # View Ignition logs only
docker compose restart ignition  # Restart single service
```

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Docker Network                            │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐                                            │
│  │   Ignition  │◄──── http://localhost:8088 (Web/Designer) │
│  │   Gateway   │◄──── :8060 (Gateway Network)              │
│  └──────┬──────┘                                            │
│         │                                                    │
│    ┌────┴────┬────────────┐                                 │
│    ▼         ▼            ▼                                 │
│ ┌──────┐ ┌──────┐  ┌───────────┐                           │
│ │postgres│ │mssql │  │ mosquitto │◄── :1883 (MQTT)         │
│ │ :5432 │ │:1433 │  │   :9001   │◄── :9001 (WebSocket)     │
│ └──────┘ └──────┘  └───────────┘                           │
└─────────────────────────────────────────────────────────────┘
```

## Database Connection Strings (from Ignition)

| Database   | JDBC Connection String                              |
|------------|-----------------------------------------------------|
| PostgreSQL | `jdbc:postgresql://postgres:5432/ignition`          |
| MSSQL      | `jdbc:sqlserver://mssql:1433;databaseName=ignition` |

## Default Credentials

| Service    | Username | Password       |
|------------|----------|----------------|
| Ignition   | admin    | password       |
| PostgreSQL | ignition | ignition       |
| MSSQL      | sa       | Ignition123!   |
| Mosquitto  | -        | (anonymous)    |

## Installing Ignition Modules

Modules must be installed manually:

1. **Via Gateway Web UI:**
   - Navigate to Config → Modules → Install or Upgrade a Module
   - Upload the `.modl` file

2. **Via Gateway Backup:**
   - Restore a gateway backup that includes the desired modules

**Common modules:**
- Perspective (modern web visualization)
- Vision (classic Java client)
- SQL Bridge (transaction groups)
- Tag Historian
- Alarm Notification
- MQTT Engine/Transmission (Cirrus Link)

## Cross-Machine Development

All configuration and data is stored in the repository:
- `ignition/data/` - Gateway configuration, projects, tags
- `postgres/data/` - PostgreSQL database files
- `mssql/data/` - MSSQL database files
- `mosquitto/config/` - MQTT broker configuration

**Workflow:**
1. Commit changes after configuring Ignition (projects, tags, connections)
2. Pull on another machine (Mac/WSL/cloud)
3. Run `docker compose up -d`
4. Environment is restored with all settings

**Note:** Stop containers before switching machines to avoid data corruption.
