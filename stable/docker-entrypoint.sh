#!/bin/sh

run_factorio_server() {
    cd '/srv/dockerized-factorio/server/bin/x64'
    exec su-exec factorio:factorio ./factorio --start-server ../../data/saves/dockerized-factorio-world.zip --server-settings ../../server-settings.json
}

if [ -f /tmp/install-factorio.sh ]; then
    chmod +x /tmp/install-factorio.sh
    /tmp/install-factorio.sh
    rm /tmp/install-factorio.sh
    mv /tmp/server-settings.json /srv/dockerized-factorio/server/server-settings.json
    (exec su-exec factorio:factorio /srv/dockerized-factorio/server/bin/x64/factorio --create /srv/dockerized-factorio/server/data/saves/dockerized-factorio-world.zip)
    echo "Finished installing the server!"
fi

run_factorio_server