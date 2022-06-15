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
    INSTALL_FOLDER=~/gcloud-$GCLOUD_VERSION
    CLUSTER_NAME=cluster-1
    CLUSTER_ZONE=us-central1-c
    PROJECT_ID=project-lee-1
    SERVICE_ACCOUNT=account-1@project-lee-1.iam.gserviceaccount.com
    KEY_FILE=~/keys/key-gcloud.json

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

    # Authenticate with a service account.
    gcloud auth activate-service-account $SERVICE_ACCOUNT --key-file=$KEY_FILE --project=$PROJECT_ID

    # Install kubectl through the gcloud CLI.
    gcloud components install kubectl --quiet

    # Create a symlink to kubectl.
    sudo ln -fs $INSTALL_FOLDER/bin/kubectl /usr/local/bin/kubectl

    # Configure kubectl command line access
    gcloud container clusters get-credentials $CLUSTER_NAME --zone $CLUSTER_ZONE --project $PROJECT_ID

    # Create a namespace for Sparklyr and K8sClusterManagers.
    kubectl create namespace lee

    # Set the namespace of the current context.
    kubectl config set-context --current --namespace=lee

    # Create a service account for Sparklyr and K8sClusterManagers.
    kubectl create serviceaccount admin

    # Grant the admin role to the service account.
    kubectl create clusterrolebinding lee-admin --clusterrole=admin --serviceaccount=lee:admin

    # Set up authentication to Docker repositories.
    gcloud auth configure-docker us-central1-docker.pkg.dev
fi
