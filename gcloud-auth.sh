#!/bin/bash

# Set environment variables.
GCLOUD_SERVICE_ACCOUNT=account-1@project-lee-1.iam.gserviceaccount.com
KEY_FILE=~/keys/key-gcloud.json
PROJECT_ID=project-lee-1
CLUSTER_NAME=autopilot-cluster-1
CLUSTER_REGION=us-central1

if [ -z ${NAMESPACE} ]
then
    # Set additional environment variables based on the cluster role and namespace.
    NAMESPACE=default
    CLUSTER_ROLE=cluster-admin
    SERVICE_ACCOUNT=${NAMESPACE}-${CLUSTER_ROLE}
    BINDING_NAME=${SERVICE_ACCOUNT}-binding

    # Authenticate with a service account.
    gcloud auth activate-service-account ${GCLOUD_SERVICE_ACCOUNT} --key-file=${KEY_FILE} --project=${PROJECT_ID}

    # Configure kubectl command line access
    gcloud container clusters get-credentials ${CLUSTER_NAME} --region ${CLUSTER_REGION} --project ${PROJECT_ID}    

    # Create a service account for Sparklyr and K8sClusterManagers.
    kubectl create serviceaccount ${SERVICE_ACCOUNT}

    # Grant the admin role to the service account.
    kubectl create clusterrolebinding ${BINDING_NAME} --clusterrole=${CLUSTER_ROLE} --serviceaccount=${NAMESPACE}:${SERVICE_ACCOUNT}

    for NAMESPACE in dask spark julia trino
    do
        # Set additional environment variables based on the cluster role and namespace.
        CLUSTER_ROLE=admin
        SERVICE_ACCOUNT=${NAMESPACE}-${CLUSTER_ROLE}
        BINDING_NAME=${SERVICE_ACCOUNT}-binding

        # Create a namespace for Dask, Sparklyr and Julia(K8sClusterManagers).
        kubectl create namespace ${NAMESPACE}

        # Create a service account for Sparklyr and Julia(K8sClusterManagers).
        kubectl create serviceaccount ${SERVICE_ACCOUNT} -n ${NAMESPACE}

        # Grant the admin role to the service account.
        kubectl create clusterrolebinding ${BINDING_NAME} --clusterrole=${CLUSTER_ROLE} --serviceaccount=${NAMESPACE}:${SERVICE_ACCOUNT}
    done
else
    # Authenticate with a service account.
    gcloud auth activate-service-account ${GCLOUD_SERVICE_ACCOUNT} --key-file=${KEY_FILE} --project=${PROJECT_ID}

    # Configure kubectl command line access
    gcloud container clusters get-credentials ${CLUSTER_NAME} --region ${CLUSTER_REGION} --project ${PROJECT_ID}    

    # Set the namespace of the current context.
    kubectl config set-context --current --namespace=${NAMESPACE}
fi
