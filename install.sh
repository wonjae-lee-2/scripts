#!/bin/bash

# Get user input for software versions.
echo
echo "Check the latest version of gcloud CLI. https://cloud.google.com/sdk/docs/install-sdk/"
read -p "Which version of gcloud CLI would you like to install? " GCLOUD_VERSION
echo
echo "Check the latest version of Python. https://www.python.org/"
read -p "Which version of Python would you like to install? " PYTHON_VERSION
echo
echo "Check the latest version of R. https://www.r-project.org/ https://docs.rstudio.com/resources/install-r/"
read -p "Which version of R would you like to install? " R_VERSION
echo
echo "Check the latest version of Julia. https://julialang.org/"
read -p "Which version of Julia would you like to install? " JULIA_VERSION
echo
echo "Check the latest version of .NET. https://dotnet.microsoft.com/en-us/"
read -p "Which version of .NET would you like to install? " DOTNET_VERSION
echo
echo "Check the latest version of Spark. https://spark.apache.org/ https://spark.apache.org/docs/latest/"
read -p "Which version of Spark would you like to install? " SPARK_VERSION
read -p "Which version of Java compatible with Spark would you like to install? " JAVA_VERSION

# Export software versions for sub-processes.
export GCLOUD_VERSION
export PYTHON_VERSION
export R_VERSION
export JULIA_VERSION
export DOTNET_VERSION
export SPARK_VERSION
export JAVA_VERSION

# Call sub-processes.
bash install/docker.sh
bash install/gcloud.sh
bash install/python.sh
bash install/r.sh
bash install/julia.sh
bash install/rust.sh
bash install/dotnet.sh
bash install/azure.sh
bash packages.sh
bash install/spark.sh
bash install/helm.sh
