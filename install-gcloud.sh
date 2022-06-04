#!/bin/bash

GPG_KEY_PATH=/usr/share/keyrings/gcloud.gpg
CLUSTER_NAME=autopilot-cluster-1
CLUSTER_REGION=us-central1
PROJECT_ID=glossy-essence-352111

# Install dependencies.
sudo apt update
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    gnupg

# Download the repository key.
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee $GPG_KEY_PATH

# Create the repository configuration.
echo "deb [signed-by=$GPG_KEY_PATH] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/gcloud.list > /dev/null

# Install the gcloud CLI from the repository.
sudo apt update
sudo apt install -y google-cloud-cli

# Initialize the gcloud CLI
gcloud init --console-only

# Install kubectl through the gcloud CLI.
gcloud components install kubectl

# Configure kubectl command line access
gcloud container clusters get-credentials $CLUSTER_NAME --region $CLUSTER_REGION --project $PROJECT_ID
