#!/bin/bash

# Set environment variables.
GCLOUD_SERVICE_ACCOUNT=account-1@project-lee-1.iam.gserviceaccount.com
KEY_FILE=~/keys/key-gcloud.json
PROJECT_ID=project-lee-1
CLUSTER_NAME=cluster-1
CLUSTER_ZONE=us-central1-c
NAMESPACE=cluster
K8S_SERVICE_ACCOUNT=admin
CLUSTER_ROLE_BINDING_NAME=cluster-admin-binding

# Authenticate with a service account.
gcloud auth activate-service-account ${GCLOUD_SERVICE_ACCOUNT} --key-file=${KEY_FILE} --project=${PROJECT_ID}

# Configure kubectl command line access
gcloud container clusters get-credentials ${CLUSTER_NAME} --zone ${CLUSTER_ZONE} --project ${PROJECT_ID}

# Create a namespace for Sparklyr and K8sClusterManagers.
kubectl create namespace ${NAMESPACE}

# Set the namespace of the current context.
kubectl config set-context --current --namespace=${NAMESPACE}

# Create a service account for Sparklyr and K8sClusterManagers.
kubectl create serviceaccount ${K8S_SERVICE_ACCOUNT}

# Grant the admin role to the service account.
kubectl create clusterrolebinding ${CLUSTER_ROLE_BINDING_NAME} --clusterrole=${K8S_SERVICE_ACCOUNT} --serviceaccount=${NAMESPACE}:${K8S_SERVICE_ACCOUNT}
