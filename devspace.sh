#!/bin/bash

# Check the latest version of devspace. https://devspace.sh/

# Set environment variable.
DOWNLOAD_FOLDER=~/downloads/

# Remove previous downloads of the same version.
sudo rm $DOWNLOAD_FOLDER/devspace

# Download the devspace file.
cd $DOWNLOAD_FOLDER
curl -s -L "https://github.com/loft-sh/devspace/releases/latest" | sed -nE 's!.*"([^"]*devspace-linux-amd64)".*!https://github.com\1!p' | xargs -n 1 curl -L -o devspace && chmod +x devspace;

# Copy the devspace file.
sudo install devspace /usr/local/bin;

# Show the installed version.
devspace --version
