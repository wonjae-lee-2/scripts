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
    INSTALL_FOLDER=~/gcloud-cli-$GCLOUD_VERSION
    CLUSTER_NAME=autopilot-cluster-1
    CLUSTER_REGION=us-central1
    PROJECT_ID=glossy-essence-352111
    SERVICE_ACCOUNT=service-account@glossy-essence-352111.iam.gserviceaccount.com

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
    $INSTALL_FOLDER/install.sh

    # Authenticate with a service account.
    $INSTALL_FOLDER/bin/gcloud auth activate-service-account $SERVICE_ACCOUNT --key-file=$HOME/gcloud-key.json --project=$PROJECT_ID

    # Install kubectl through the gcloud CLI.
    $INSTALL_FOLDER/bin/gcloud components install kubectl

    # Configure kubectl command line access
    $INSTALL_FOLDER/bin/gcloud container clusters get-credentials $CLUSTER_NAME --region $CLUSTER_REGION --project $PROJECT_ID

    # Create a service account for connecting R to Spark through Sparklyr.
    $INSTALL_FOLDER/bin/kubectl create serviceaccount spark

    # Grant the edit to the spark service account.
    $INSTALL_FOLDER/bin/kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=default:spark
fi
