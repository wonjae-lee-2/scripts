#!/bin/bash

# Get user input for software versions.
echo
echo "Check the latest version of gcloud CLI. https://cloud.google.com/sdk/docs/install-sdk/"
read -p "Which version of gcloud CLI would you like to install? " GCLOUD_VERSION
echo
echo "Check the latest version of Python. https://www.python.org/"
read -p "Which version of Python would you like to install? " PYTHON_VERSION
echo
echo "Check the latest version of R. https://www.r-project.org/"
read -p "Which version of R would you like to install? " R_VERSION
echo
echo "Check the latest version of Julia. https://julialang.org/"
read -p "Which version of Julia would you like to install? " JULIA_VERSION
echo
echo "Check the latest version of RStudio. https://www.rstudio.com/ or https://dailies.rstudio.com/"
read -p "Which version of RStudio would you like to install? " RSTUDIO_VERSION
echo
echo "Check the latest version of Spark. https://spark.apache.org/ https://spark.apache.org/docs/latest/"
read -p "Which version of Spark would you like to install? " SPARK_VERSION
read -p "Which version of Java compatible with Spark would you like to install? " JAVA_VERSION
echo
echo "Check the latest version of PostgreSQL. https://www.postgresql.org/"
read -p "Which version of PostgreSQL would you like to install? " PSQL_VERSION
read -p "What password would you like to use for PostgreSQL? " PSQL_PASSWORD
echo
echo "Check the latest version of SQLite. https://www.sqlite.org/"
read -p "Which version of SQLite would you like to install? " SQLITE_VERSION
read -p "Which year was this version released? " SQLITE_RELEASE_YEAR

# Export software versions for sub-processes.
export GCLOUD_VERSION
export PYTHON_VERSION
export R_VERSION
export RSTUDIO_VERSION
export SPARK_VERSION
export JAVA_VERSION
export PSQL_VERSION
export PSQL_PASSWORD
export SQLITE_VERSION
export SQLITE_RELEASE_YEAR

# Call sub-processes.
./install/aws.sh
./install/gcloud.sh
./install/docker.sh
./install/python.sh
./install/r.sh
./install/julia.sh
./install/rust.sh
./packages.sh
./install/rstudio.sh
./install/spark.sh
./install/devspace.sh
./install/psql.sh
./install/sqlite.sh
./install/rclone.sh
