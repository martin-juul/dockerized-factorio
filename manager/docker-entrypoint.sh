#!/bin/sh

if [ ! -f /srv/fsm/cert/selfsigned-server.key ]; then
    echo "TLS certificate key missing. Generating.."
    # LibreSSL is currently using the openssl command, as it's a drop-in replacement.
    openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -subj '/CN=localhost' \
        -keyout /srv/fsm/cert/selfsigned-server.key \
        -out /srv/fsm/cert/selfsigned-server.crt
fi

if [ -f /tmp/fsm-conf.json ]; then
    mv /tmp/fsm-conf.json /srv/factorio-server-manager/conf.json
fi

chown factorio:factorio /srv/factorio-server-manager/conf.json

cd /srv/factorio-server-manager

nohup nginx &
./factorio-server-manager -dir '/srv/fsm/factorio-data'