#!/bin/bash

echo "Check the latest version of gcloud CLI. https://cloud.google.com/sdk/docs/install-sdk"
echo
read -p "Which version of gcloud CLI would you like to install? " INPUT
if [ -z $INPUT ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else
    # Set environment variables.
    GCLOUD_VERSION=$INPUT
    DOWNLOAD_FOLDER=~/downloads
    INSTALL_FOLDER=~/gcloud

    # Clean up the directory of the same version.
    sudo rm -r $INSTALL_FOLDER
    sudo rm -r ~/.config/gcloud

    # Download the gcloud binary.
    cd $DOWNLOAD_FOLDER
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-$GCLOUD_VERSION-linux-x86_64.tar.gz

    # Extract the binary file.
    mkdir $INSTALL_FOLDER
    tar -x -f google-cloud-cli-$GCLOUD_VERSION-linux-x86_64.tar.gz -C $INSTALL_FOLDER --strip-components=1

    # Install gcloud CLI.
    $INSTALL_FOLDER/install.sh --quiet --command-completion True --path-update True

    # Create a symlink to gcloud.
    sudo ln -fs $INSTALL_FOLDER/bin/gcloud /usr/local/bin/gcloud

    # Install kubectl through the gcloud CLI.
    gcloud components install kubectl --quiet

    # Create a symlink to kubectl.
    sudo ln -fs $INSTALL_FOLDER/bin/kubectl /usr/local/bin/kubectl
fi
