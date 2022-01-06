# Docker Automysqlbackup Image

Alpine image for creating and managing MySQL backups. 

Runs an up to date version of the good old AutoMySQLBackup script slightly customized to play better with plain docker environments.

It uses the latest mysql-client package available (mariadb 10.x) assuming any mysql backward compatibility issue to be managed by mysqldump options (see --compatibile).

## Build args

- UID (default 1001)
- GID (default 1001)
- TIMEZONE (default Europe/Rome)
- GOCROND_VERSION (default 20.7.0)
## Environment variables

- CONFIG_FILE
- BACKUP_DIR
- DUMP_PORT
- DB_HOST
- DB_USER
- DB_USER_FILE
- DB_PASS
- DB_PASS_FILE
- DB_NAMES
- CREATE_DATABASE
- DUMP_LATEST
- DUMP_LATEST_CLEAN_FILENAMES
- SINGLE_TRANSACTION
- ROTATION_DAILY
- ROTATION_WEEKLY
- ROTATION_MONTHLY
- DRY_RUN
- RUN_ONCE

## Example

Docker compose:
```
version: "3.8"
services:

  automysqlbackup:
    image: averni/automysqlbackup:latest
    restart: unless-stopped
    volumes:
      - /host/backup/path:/backup:rw
      - /host/config/mysql_root_password:/run/secrets/mysql_root_password:ro
    environment:
      - CRON_SCHEDULE="10 03 * * *"
      - ROTATION_DAILY=6
      - ROTATION_WEEKLY=30
      - ROTATION_MONTHLY=120
      - DB_HOST=mysql
      - DB_USER=root
      - DB_PASS_FILE=/run/secrets/mysql_root_password
      - DB_NAMES=test
      - CREATE_DATABASE=no
      - FULL_SCHEMA=no
      # - RUN_ONCE=true
    networks:
      - database-net
```


## TODO
Container discovery through labels

