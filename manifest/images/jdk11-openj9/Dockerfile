# ----------------------------------
# Pterodactyl Java 11 OpenJ9 Image
# ----------------------------------
FROM        adoptopenjdk/openjdk11-openj9:debian-slim

LABEL       maintainer="ccarney16@live.com"

RUN apt-get update -y \
 && apt-get install -y curl ca-certificates openssl git tar sqlite fontconfig tzdata iproute2 \
 && useradd -d /home/container -m container
 
USER container
ENV  USER=container HOME=/home/container

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]