# ----------------------------------
# Pterodactyl Java 11 GraalVM Image
# ----------------------------------
FROM debian:10

LABEL maintainer="ccarney16@live.com"

ARG VERSION="21.0.0.2"


RUN apt-get update -y \
 && apt-get install -y curl ca-certificates openssl git tar sqlite fontconfig tzdata iproute2 \
 && useradd -d /home/container -m container
 
RUN mkdir -p /opt/jvm; \
    cd /opt/jvm; \
    curl -Lo graalvm.tgz https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${VERSION}/graalvm-ce-java11-linux-amd64-${VERSION}.tar.gz; \
    tar --strip-components=1 -xvzf graalvm.tgz; \
    rm -f graalvm.tgz

USER container
ENV  USER=container HOME=/home/container

# Configure Path for java
ENV PATH="/opt/jvm/bin:${PATH}"
ENV JAVA_HOME="/opt/jvm/"

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]