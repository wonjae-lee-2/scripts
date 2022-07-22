#!/bin/bash

# Check the latest version of .NET. https://dotnet.microsoft.com/en-us/

if [ -z ${DOTNET_VERSION} ]
then
    echo
    echo "Check the latest version of .NET. https://dotnet.microsoft.com/en-us/"
    read -p "Which version of .NET would you like to install? " DOTNET_VERSION
fi

# Set environment variables. DOTNET_VERSION is either exported from `install.sh` or read from user input.
DOWNLOAD_FOLDER=~/downloads

# Add the Microsoft package repository.
cd ${DOWNLOAD_FOLDER}
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

# Install .NET SDK.
sudo apt update
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y dotnet-sdk-${DOTNET_VERSION}
