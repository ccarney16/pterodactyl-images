FROM        --platform=$TARGETOS/$TARGETARCH docker.io/amazoncorretto:17

LABEL       author="Cameron Carney" maintainer="ccarney16@live.com"

LABEL       org.opencontainers.image.source="https://github.com/ccarney16/pterodactyl-images"

RUN amazon-linux-extras install epel -y \
    && yum install -y gettext git iproute lsof moreutils openssl tar \
    && useradd -d /home/container -m container \
    && curl -Lo /usr/local/bin/ytt https://github.com/vmware-tanzu/carvel-ytt/releases/download/v0.49.0/ytt-linux-amd64 \
    && curl -Lo /usr/local/bin/vendir https://github.com/vmware-tanzu/carvel-vendir/releases/download/v0.40.1/vendir-linux-amd64 \
    && chmod +x /usr/local/bin/ytt /usr/local/bin/vendir


USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoints/deploy.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
