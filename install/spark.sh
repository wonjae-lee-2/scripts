#!/bin/bash

if [ -z ${R_VERSION} ] || [ -z ${SPARK_VERSION} ] || [ -z ${JAVA_VERSION} ]
then
    echo
    echo "Check the latest version of Spark. https://spark.apache.org/"
    read -p "Which version of Spark would you like to install? " SPARK_VERSION
    echo
    echo "Check the latest version of R. https://www.r-project.org/"
    read -p "Which version of R did you install? " R_VERSION
    echo
    echo "Check the version of Java compatible with Spark. https://spark.apache.org/docs/latest/"
    read -p "Which version of Java would you like to install? " JAVA_VERSION
fi

# Set environment variables. R_VERSION, SPARK_VERSION and JAVA_VERSION are either exported from `install.sh` or read from user input.
R_VERSION_SHORT=$(echo ${R_VERSION} | cut -d "." -f -2)
DOWNLOAD_FOLDER=~/downloads
INSTALL_FOLDER=/opt/spark/${SPARK_VERSION}
SPARKLYR_FOLDER=~/venv/r/${R_VERSION}/renv/library/R-${R_VERSION_SHORT}/x86_64-pc-linux-gnu/sparklyr/java

# Clean up directories and previous downloads of the same version.
sudo rm -r ${INSTALL_FOLDER}
sudo rm ${DOWNLOAD_FOLDER}/spark-${SPARK_VERSION}-bin-hadoop3.tgz

# Install Java 11 runtime environment.
sudo apt update
sudo apt install -y openjdk-${JAVA_VERSION}-jre

# Download the Spark binary.
cd ${DOWNLOAD_FOLDER}
wget https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz

# Extract the binary file.
sudo mkdir -p ${INSTALL_FOLDER}
sudo tar -x -f spark-${SPARK_VERSION}-bin-hadoop3.tgz -C ${INSTALL_FOLDER} --strip-components=1

# Copy sparklyr jar files for building docker images.
sudo mkdir ${INSTALL_FOLDER}/sparklyr
sudo cp ${SPARKLYR_FOLDER}/* ${INSTALL_FOLDER}/sparklyr

# Update the dockerfile to include sparklyr jar files.
sudo sed -i '/^COPY jars \/opt\/spark\/jars/a COPY sparklyr \/opt\/sparklyr' ${INSTALL_FOLDER}/kubernetes/dockerfiles/spark/Dockerfile
