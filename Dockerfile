


# Package
FROM alpine:3.9

LABEL org.label-schema.name="automysqlbackup" \
  org.label-schema.description="automysqlbackup non root container" \
  org.label-schema.schema-version="1.0"

ARG UID=1001
ARG GID=1001
ARG TIMEZONE=Europe/Rome
ARG GOCROND_VERSION=20.7.0

ENV CONFIG_FILE=/etc/automysqlbackup/automysqlbackup.conf
ENV BACKUP_DIR=/backup
ENV ROTATION_DAILY=1
ENV ROTATION_WEEKLY=1
ENV ROTATION_MONTHLY=1
ENV DUMP_PORT=3306
ENV DB_HOST=
ENV DB_USER=
ENV DB_USER_FILE=
ENV DB_PASS=
ENV DB_PASS_FILE=
ENV DB_NAMES=
ENV CREATE_DATABASE=
ENV DUMP_LATEST=
ENV DUMP_LATEST_CLEAN_FILENAMES=
ENV SINGLE_TRANSACTION=yes
ENV DRY_RUN=
ENV RUN_ONCE=

RUN apk add --no-cache mysql-client gzip tzdata bash \
    && addgroup -S -gid --gid $GID automysqlbackup \
    && adduser --uid $UID -S automysqlbackup automysqlbackup \
    && wget -O /usr/local/bin/go-crond https://github.com/webdevops/go-crond/releases/download/$GOCROND_VERSION/go-crond-64-linux \
    && chmod +x /usr/local/bin/go-crond

COPY start.sh /usr/local/bin
COPY automysqlbackup /usr/local/bin
COPY automysqlbackup_default.conf /etc/automysqlbackup/automysqlbackup.conf

RUN chmod +x /usr/local/bin/automysqlbackup /usr/local/bin/start.sh \
    && mkdir -p /etc/default /backup /etc/cron.d \
    && chmod o+w /etc/cron.d \
    && chmod -R a+rwx /backup \
    && chown ${UID}:${GID} /backup \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo ${TIMEZONE} > /etc/timezone

VOLUME /backup

WORKDIR /backup

USER automysqlbackup

CMD ["start.sh"]

