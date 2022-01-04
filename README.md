# Docker Automysqlbackup Image

Alpine image for creating and managing MySQL backups. 

Runs an up to date version of the good old AutoMySQLBackup script slightly customized to play better with plain docker environments.

It uses the latest mysql-client package available (mariadb 10.x) assuming any mysql backward compatibility issue to be managed by mysqldump options (see --compatibile).

## TODO
Container discovery through labels

