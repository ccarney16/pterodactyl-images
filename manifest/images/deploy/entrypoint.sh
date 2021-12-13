#!/bin/bash

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

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $NF;exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# Read environment.txt for variables in /home/container
if [ -f environment.txt ]; then
    source environment.txt
fi

# Drops into a basic shell
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mPress any key and Enter to drop into deployment mode, resuming startup in 5 seconds...\n"

read -n 1 -t 5

if [ $? == 0 ]; then
    printf "\n"
    printf "## DEPLOYMENT MODE ##\n"
    printf "\n"
    printf "Welcome to Deployment Mode, this feature provides a basic command line access to a server.\n"
    printf "Under this feature, you can modify the contents of the server using commands.\n"
    printf "To resume startup, just type \"exit\"\n"
    printf "\n"

    # Removes PS1 prompt
    export PS1=""
    /bin/sh
fi

# Execute Deployment System
if [ "$SERVER_AUTODEPLOY" == "true" ] || [ -f .deploy ]; then
    printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mDeployment Initialized...\n"

    if [ -f "vendir.yml" ]; then
        /usr/local/bin/vendir sync
    else
        printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mMissing vendir.yml. Skipping...\n"
    fi

    if [ -f "$SERVER_DIR/file_patch.txt" ]; then
        echo "Patching Files in /home/container/$SERVER_DIR..."
        cd /home/container/$SERVER_DIR

        file_patch_list="$(cat file_patch.txt)"
        for f in $file_patch_list; do
            envsubst < $f.tmpl | sponge $f
            echo "File Templated: $f"
        done

        cd ../
    fi

    printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mDeployment done.\n"
fi

if [ ! -d "$SERVER_DIR" ]; then
    printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mError! Missing server directory variable! Exiting...\n"
    exit 1
fi

# Run through scripts
if [ -d scripts ]; then
    printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mExecuting post deployment scripts...\n"
    sleep 1

    # Always assuming scripts arent properly permissioned before executing
    chmod +x scripts/*.sh

    for script in scripts/*.sh; do
        sh $script
    done
fi

# Remove .deploy file as it is no longer needed
rm -rf .deploy

# Go into Server Directory
cd /home/container/$SERVER_DIR

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
