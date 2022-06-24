#!/bin/bash

echo "Check the latest version of Spark. https://spark.apache.org/"
echo
read -p "Which version of Spark would you like to install? " INPUT1
read -p "Which version of R did you install? " INPUT2
if [ -z $INPUT1 ] && [ -z $INPUT2 ]
then
    echo "Please enter version numbers as the first and second argument."
    exit 1
else
    # Set environment variables.
    SPARK_VERSION=$INPUT1
    JAVA_VERSION=11
    R_VERSION=$INPUT2
    R_VERSION_SHORT=$(echo $R_VERSION | cut -d "." -f -2)
    DOWNLOAD_FOLDER=~/downloads
    INSTALL_FOLDER=/opt/spark/$SPARK_VERSION
    SPARKLYR_FOLDER=~/venv/r/$R_VERSION/renv/library/R-$R_VERSION_SHORT/x86_64-pc-linux-gnu/sparklyr/java
    ARTIFACT_REGISTRY=us-central1-docker.pkg.dev/project-lee-1/docker

    # Clean up directories and previous downloads of the same version.
    sudo rm -r $INSTALL_FOLDER
    sudo rm $DOWNLOAD_FOLDER/spark-$SPARK_VERSION-bin-hadoop3.tgz

    # Install Java 11 runtime environment.
    sudo apt update
    sudo apt install -y openjdk-$JAVA_VERSION-jre

    # Download the Spark binary.
    cd $DOWNLOAD_FOLDER
    wget https://dlcdn.apache.org/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop3.tgz

    # Extract the binary file.
    sudo mkdir -p $INSTALL_FOLDER
    sudo tar -x -f spark-$SPARK_VERSION-bin-hadoop3.tgz -C $INSTALL_FOLDER --strip-components=1

    # Copy sparklyr jar files for building docker images.
    sudo mkdir $INSTALL_FOLDER/sparklyr
    sudo cp $SPARKLYR_FOLDER/* $INSTALL_FOLDER/sparklyr

    # Update the dockerfile to include sparklyr jar files.
    sudo sed -i '/^COPY jars \/opt\/spark\/jars/a COPY sparklyr \/opt\/sparklyr' $INSTALL_FOLDER/kubernetes/dockerfiles/spark/Dockerfile

    # Build a docker image for the kubernetes cluster.
    $INSTALL_FOLDER/bin/docker-image-tool.sh -r $ARTIFACT_REGISTRY -t $SPARK_VERSION build

    # Push the docker image to the repository.
    $INSTALL_FOLDER/bin/docker-image-tool.sh -r $ARTIFACT_REGISTRY -t $SPARK_VERSION push
fi