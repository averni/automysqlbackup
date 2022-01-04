#!/bin/sh

set -e

echo "Date: `date`."


if [ -z ${RUN_ONCE} ] && [ "${CRON_SCHEDULE}" ]; then
    echo "Starting cron."
    echo "${CRON_SCHEDULE//\"""/} automysqlbackup automysqlbackup" > /etc/cron.d/automysqlbackup
    exec go-crond --allow-unprivileged --include=/etc/cron.d  #-s "0 ${CRON_SCHEDULE}" -- automysqlbackup
    # exec crond -l 8 -f
else
    exec automysqlbackup
fi