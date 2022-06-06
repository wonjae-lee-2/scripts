#!/bin/bash

# Check the latest version of gcloud CLI. https://cloud.google.com/sdk/docs/install-sdk

read -p "Which version of gcloud CLI would you like to install? " INPUT
if [ -z $INPUT ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else
    # Set environment variables.
    GCLOUD_VERSION=$INPUT
    DOWNLOAD_FOLDER=~/downloads
    INSTALL_FOLDER=/opt/google-cloud-sdk
    CLUSTER_NAME=autopilot-cluster-1
    CLUSTER_REGION=us-central1
    PROJECT_ID=glossy-essence-352111

    # Clean up the directory of the same version.
    sudo rm -r $INSTALL_FOLDER
    sudo rm -r ~/.config/gcloud

    # Download the gcloud binary.
    cd $DOWNLOAD_FOLDER
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-$GCLOUD_VERSION-linux-x86_64.tar.gz

    # Extract the binary file.
    sudo mkdir $INSTALL_FOLDER
    sudo chown ubuntu:ubuntu $INSTALL_FOLDER
    tar -x -f google-cloud-cli-$GCLOUD_VERSION-linux-x86_64.tar.gz -C $INSTALL_FOLDER --strip-components=1

    # Install gcloud CLI.
    cd $INSTALL_FOLDER
    ./install.sh

    # Restart .bashrc
    . ~/.bashrc

    # Initialize the gcloud CLI
    gcloud init --no-browser

    # Install kubectl through the gcloud CLI.
    gcloud components install kubectl

    # Configure kubectl command line access
    gcloud container clusters get-credentials $CLUSTER_NAME --region $CLUSTER_REGION --project $PROJECT_ID
fi
