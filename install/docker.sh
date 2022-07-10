#!/bin/bash

# Check the latest version of Docker. https://www.docker.com/

# Set environment variables.
GPG_KEY_PATH=/usr/share/keyrings/docker.gpg

# Uninstall old versions.
sudo apt remove \
    docker \
    docker-engine \
    docker.io \
    containerd runc

# Install dependencies.
sudo apt update
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Download the repository key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o $GPG_KEY_PATH

# Create the repository configuration.
echo "deb [arch=$(dpkg --print-architecture) signed-by=$GPG_KEY_PATH] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker from the repository.
sudo apt-get update
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin

# create the docker group and add the default user.
sudo groupadd docker
sudo usermod -aG docker $USER

# Ask if the user is installing Docker on WSL.
echo
read -p "Are you installing Docker on WSL? (y/n) " FLAG_WSL

if [ ${FLAG_WSL} = "y" ]
then
    # A bug fix. Ensure dockerd uses an older version of iptables. https://github.com/microsoft/WSL/issues/6655
    sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
    sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

    # Ensure docker is running at log in if it is not yet at log in.
    cat <<- EOF >> ~/.profile

    # Ensure docker is running at log in if it is not yet at log in.
    if [ "\$(service docker status)" = " * Docker is not running" ]
    then
        sudo service docker start
    fi
	EOF
fi
