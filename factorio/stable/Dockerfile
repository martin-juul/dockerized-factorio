FROM alpine:3.7

LABEL 'maintainers-github-profiles'='martin-juul, sicet7'
LABEL 'git-repo'='https://github.com/martin-juul/dockerized-factorio'

ARG factorio_release='stable'
ENV factorio_repo='https://www.factorio.com/get-download/RELEASE/headless/linux64'
ENV FA_RCON_PASS='h&kyd7txmedJBXSuU5hS'
ENV FA_RCON_PORT='27015'

# adding the user and group which will run the server
RUN set -xe \
    && addgroup -g 1000 -S factorio \
    && adduser -u 1000 -S factorio -G factorio \
    && mkdir /srv/dockerized-factorio \
    && chown -R factorio:factorio /srv/dockerized-factorio

# container dependencies
RUN set -xe \
    && apk --update add --no-cache sed tar grep coreutils su-exec curl xz

# glibc, required by the factorio server
RUN set -xe \
    && apk --update add --no-cache --virtual fetch-deps ca-certificates wget \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub \
        'https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub' \
    && wget 'https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/glibc-2.27-r0.apk' \
    && apk add 'glibc-2.27-r0.apk' \
    && apk del fetch-deps
# getting the factorio server
ADD install-scripts/install-factorio.sh /tmp/install-factorio.sh
RUN set -xe \
    # the final link to the factorio server
    && export factorio_current_repo=$(echo ${factorio_repo} | sed "s#RELEASE#${factorio_release}#g") \
    && cd /tmp \
    && { curl -O -J -L  ${factorio_current_repo}; cd -; } \
    && factorio_archive=$(echo "/tmp/"*.tar.xz) \
    && echo ${factorio_archive} > /tmp/factorio_dl_link.txt

COPY configs/server-settings.json /tmp/server-settings.json

VOLUME /srv/dockerized-factorio

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]
# Factorio Server Port
EXPOSE 34190-34200/udp