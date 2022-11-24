FROM        --platform=$TARGETOS/$TARGETARCH docker.io/amazoncorretto:19

LABEL       author="Cameron Carney" maintainer="ccarney16@live.com"

LABEL       org.opencontainers.image.source="https://github.com/ccarney16/pterodactyl-images"

RUN 		yum install -y git iproute lsof openssl tar \
 			&& useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoints/entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
