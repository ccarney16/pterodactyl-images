ARG JDK_TAG=8-slim

FROM        openjdk:${JDK_TAG}

LABEL       author="ccarney16" maintainer="ccarney16@live.com"

LABEL       org.opencontainers.image.source="https://github.com/ccarney16/pterodactyl-images"

RUN 		apt-get update -y \
 			&& apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig tzdata iproute2 libstdc++6 gettext moreutils \
 			&& useradd -d /home/container -m container \
            && curl -Lo /usr/local/bin/ytt https://github.com/vmware-tanzu/carvel-ytt/releases/download/v0.37.0/ytt-linux-amd64 \
            && curl -Lo /usr/local/bin/vendir https://github.com/vmware-tanzu/carvel-vendir/releases/download/v0.23.0/vendir-linux-amd64 \
            && chmod +x /usr/local/bin/ytt /usr/local/bin/vendir

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]