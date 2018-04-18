# Dockerized Factorio

Spin up a Factorio game server in a few minutes!

This edition comes with [Factorio Server Manager](https://github.com/mroote/factorio-server-manager), a web administration panel for Factorio Server.

## Usage

__docker-compose__

`docker-compose -f docker-compose-stable.yml up`

## Roadmap

* Mount factorio-data over SSHFS (when server and manager is in different DC's)
    * User+Group for connection
    * Wait for connection before starting server
    * ed25519 cert
    * Figure out how to avoid file version clashing

## Special thanks

Creators of the Factorio Server Manager. Our image for fsm is also heavily inspired from theirs. Though we chose to separate the game server from the web ui. OpenSSL has also been replaced with LibreSSL.

[mroote/factorio-server-manager](https://github.com/mroote/factorio-server-manager)