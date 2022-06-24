#!/bin/bash

if [ -z ${SQLITE_VERSION} ] || [ -z ${SQLITE_RELEASE_YEAR} ]
then
    echo
    echo "Check the latest version of SQLite. https://www.sqlite.org/"
    read -p "Which version of SQLite would you like to install? " SQLITE_VERSION
    read -p "Which year was this version released?" SQLITE_RELEASE_YEAR
fi

# Set environment variables. SQLITE_VERSION and SQLITE_RELEASE_YEAR are either exported from `install.sh` or read from user input.
SQLITE_VERSION_MAJOR=$(echo ${SQLITE_VERSION} | cut -d "." -f 1)
SQLITE_VERSION_MINOR=$(echo ${SQLITE_VERSION} | cut -d "." -f 2)
if [ ${#SQLITE_VERSION_MINOR} = 1 ]
then
    SQLITE_VERSION_MINOR=0${SQLITE_VERSION_MINOR}
fi
SQLITE_VERSION_PATCH=$(echo ${SQLITE_VERSION} | cut -d "." -f 3)
if [ ${#SQLITE_VERSION_PATCH} = 1 ]
then
    SQLITE_VERSION_PATCH=0${SQLITE_VERSION_PATCH}
fi
SQLITE_VERSION_FILENAME=${SQLITE_VERSION_MAJOR}${SQLITE_VERSION_MINOR}${SQLITE_VERSION_PATCH}
DOWNLOAD_FOLDER=~/downloads
INSTALL_FOLDER=/opt/sqlite/${SQLITE_VERSION}

# Clean up the directories and previous downloads of the same version.
sudo rm -r ${INSTALL_FOLDER}
sudo rm ${DOWNLOAD_FOLDER}/sqlite-tools-linux-x86-${SQLITE_VERSION_FILENAME}00.zip

# Install build dependencies.
sudo apt update
sudo apt install -y unzip

# Download SQLite from the official website.
cd ${DOWNLOAD_FOLDER}
wget https://www.sqlite.org/${SQLITE_RELEASE_YEAR}/sqlite-tools-linux-x86-${SQLITE_VERSION_FILENAME}00.zip

# Unzip the archive file.
sudo mkdir -p ${INSTALL_FOLDER}
sudo unzip -j sqlite-tools-linux-x86-${SQLITE_VERSION_FILENAME}00.zip -d ${INSTALL_FOLDER}

# Create a symlink to SQLite.
sudo ln -fs ${INSTALL_FOLDER}/sqlite${SQLITE_VERSION_MAJOR} /usr/local/bin/sqlite
