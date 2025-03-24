#
# Copyright (c) 2021 Matthew Penner
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

FROM        --platform=$TARGETOS/$TARGETARCH docker.io/library/eclipse-temurin:21

LABEL       author="Cameron Carney" maintainer="ccarney16@live.com"

LABEL       org.opencontainers.image.source="https://github.com/pterodactyl/yolks"

RUN 		apt-get update -y \
 			&& apt-get install -y moreutils gettext-base lsof curl ca-certificates openssl git tar sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6 \
 			&& useradd -d /home/container -m container \
            && curl -Lo /usr/local/bin/ytt https://github.com/vmware-tanzu/carvel-ytt/releases/download/v0.49.0/ytt-linux-amd64 \
            && curl -Lo /usr/local/bin/vendir https://github.com/vmware-tanzu/carvel-vendir/releases/download/v0.40.1/vendir-linux-amd64 \
            && chmod +x /usr/local/bin/ytt /usr/local/bin/vendir

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoints/deploy.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
