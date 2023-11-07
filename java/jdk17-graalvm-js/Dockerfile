# Use the GraalVM base image
FROM ghcr.io/graalvm/graalvm-community:17

LABEL author="Cameron Carney" maintainer="ccarney@zyphi.co"
LABEL org.opencontainers.image.source="https://github.com/ccarney16/pterodactyl-images"
LABEL org.opencontainers.image.licenses="MIT"

# Install required packages
RUN microdnf update \
    && microdnf install -y curl ca-certificates openssl git tar sqlite fontconfig tzdata iproute gcc gcc-c++ freetype libstdc++ lsof \
    && microdnf clean all

# Install GraalVM JavaScript language component
RUN gu install js

# Add the user
RUN adduser --home-dir /home/container container

# Set environment variables
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Switch to the 'container' user
USER container
# Set user-related environment variables
ENV USER=container HOME=/home/container
# Set the working directory
WORKDIR /home/container

# Copy your entrypoint script into the container
COPY ./../entrypoints/entrypoint.sh /entrypoint.sh

# Set the command to run the entrypoint script
CMD ["/bin/bash", "/entrypoint.sh"]