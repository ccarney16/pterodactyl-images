#!/bin/sh

TZ=${TZ:-UTC}
export TZ

cd /home/container || exit 1

PARSED=$(echo "${STARTUP:-traefik}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# Load environment variables from traefik.env if it exists
if [ -f "traefik.env" ]; then
    export $(cat traefik.env | xargs)
fi

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"
exec env ${PARSED}
