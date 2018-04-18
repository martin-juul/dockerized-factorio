FROM alpine:3.7

LABEL 'maintainers-github-profiles'='martin-juul, sicet7'
LABEL 'git-repo'='https://github.com/martin-juul/dockerized-factorio'

ENV FSM_version='0.7.1'
ENV FSM_admin_password='testpass1234'

VOLUME /srv/fsm/cert
VOLUME /srv/fsm/factorio-data

RUN set -xe \
    && addgroup -g 1000 -S factorio \
    && adduser -u 1000 -S factorio -G factorio

# glibc, required by the factorio server manager?
RUN set -xe \
    && apk --update add --no-cache --virtual fetch-deps ca-certificates wget \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub \
        'https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub' \
    && wget 'https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/glibc-2.27-r0.apk' \
    && apk add 'glibc-2.27-r0.apk' \
    && apk del fetch-deps

RUN set -xe \
    && apk --update add --no-cache unzip curl libressl nginx su-exec \
    && curl -s -L -S -k https://github.com/mroote/factorio-server-manager/releases/download/$FSM_version/factorio-server-manager-linux.zip --cacert /opt/github.pem -o /tmp/factorio-server-manager-linux_$FSM_version.zip \
    && mkdir -pv /srv/fsm \
    && unzip /tmp/factorio-server-manager-linux_$FSM_version.zip -d /srv/ \
    && rm /tmp/factorio-server-manager-linux_$FSM_version.zip \
    && mkdir -p /run/nginx \
    && chown nginx:root /var/lib/nginx \
    && chmod 755 /srv \
    && chown -R factorio:factorio '/srv/fsm' \
    && chown factorio:factorio '/srv/fsm/factorio-data' \
    && chmod +x '/srv/factorio-server-manager/factorio-server-manager' \
    && rm /srv/factorio-server-manager/conf.json
    #&& echo "Generating a strong Diffie-Hellman group" \
    #&& rm -f /etc/nginx/dhparam.pem \
    #&& openssl dhparam -out /etc/nginx/dhparam.pem 4096

COPY fsm-conf.json /tmp/fsm-conf.json

COPY 'nginx.conf' '/etc/nginx/nginx.conf'
COPY 'security.inc' '/etc/nginx/security.inc'

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 80/tcp 443/tcp