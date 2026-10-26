FROM --platform=$TARGETOS/$TARGETARCH traefik:v3

LABEL author="Cameron Carney" maintainer="ccarney16@live.com"
LABEL org.opencontainers.image.source="https://github.com/ccarney16/pterodactyl-images"

ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/sh", "/entrypoint.sh"]
