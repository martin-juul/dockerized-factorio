#!/bin/sh

set -e

run_factorio_server() {
    cd '/srv/dockerized-factorio/server/bin/x64'
    exec su-exec factorio:factorio ./factorio --start-server ../../saves/my-save.zip --server-settings ../../server-settings.json
}

if [ -f /tmp/install-factorio.sh ]; then
    chmod +x /tmp/install-factorio.sh
    /tmp/install-factorio.sh ${factorio_archive}
    rm /tmp/install-factorio.sh
    mv /tmp/server-settings.json /srv/dockerized-factorio/server/server-settings.json
    exec su-exec factorio:factorio /srv/dockerized-factorio/server/bin/x64/factorio --create /srv/dockerized-factorio/server/saves/my-save.zip
fi

run_factorio_server