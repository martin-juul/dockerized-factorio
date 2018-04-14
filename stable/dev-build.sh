#!/usr/bin/env bash

clear

docker build -t martin-juul/dockerized-factorio:stable --force-rm --no-cache .
docker image prune --force