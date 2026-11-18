#!/bin/bash

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# CVE-2026-114938: the AVX-512 Base64 decode intrinsic in HotSpot writes out of bounds.
# JDK_JAVA_OPTIONS is read only by the JDK 9+ java launcher, so JDK 8 (unaffected, and which
# refuses to start with this option) ignores it. Appended so an egg's own options are kept.
# Remove once every image ships a fixed JDK.
export JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS:+${JDK_JAVA_OPTIONS} }-XX:-UseBASE64Intrinsics"

# Print Java version
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mjava -version\n"
java -version

# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# Display the command we're running in the output, and then execute it with the env
# from the container itself.
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"
# shellcheck disable=SC2086
exec env ${PARSED}