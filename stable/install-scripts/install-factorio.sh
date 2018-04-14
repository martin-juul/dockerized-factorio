#!/bin/sh

# Source: https://github.com/Bisa/factorio-init/blob/master/factorio
# Modified for using with dockerized-factorio

mkdir -p "/srv/dockerized-factorio/server"

ftarball=$1
ftarget="/srv/dockerized-factorio/server"
fbinary="${ftarget}/bin/x64/factorio"

echo "Installing ${ftarball} ..."
if ! tar -xJvf "${ftarball}" -C "${ftarget}" --strip-components 1; then
  echo "Install failed!"
  exit 1
fi

mkdir "${ftarget}/data/saves"
chmod 777 "${ftarget}/data"

echo "Applying file ownership ..."
if ! chown -R factorio:factorio ${ftarget}; then
    echo "Failed to apply ownership factorio:factorio for ${ftarget}"
    exit 1
fi
# Generate default config.ini by creating a save
echo "Creating save in ${ftarget}/saves"
#exec su-exec factorio:factorio "${fbinary} --create ${ftarget}/saves/my-save.zip"
#if [ $? -eq 0 ]; then
#    ls -l "${ftarget}/saves"
#    echo "Installation complete, edit data/server-settings.json and start the container."
#    exit 0
#else
#    echo "Failed to create save, review the output above to recover"
#    exit 1
#fi