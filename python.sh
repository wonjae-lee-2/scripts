#!/bin/bash

echo "Check the latest version of Python. https://www.python.org/"
echo
read -p "Which version of Python would you like to install? " INPUT
if [ -z $INPUT ]
then
    echo "Please enter a version number."
    exit 1
else
    # Set environment variables.
    PYTHON_VERSION=$INPUT
    PYTHON_VERSION_SHORT=$(echo $PYTHON_VERSION | cut -d "." -f -2)
    DOWNLOAD_FOLDER=~/downloads
    BUILD_FOLDER=~/downloads/python/$PYTHON_VERSION
    INSTALL_FOLDER=/opt/python/$PYTHON_VERSION
    VENV_FOLDER=~/venv/python/$PYTHON_VERSION

    # Clean up the directories of the same version.
    sudo rm -r $BUILD_FOLDER
    sudo rm -r $INSTALL_FOLDER
    sudo rm -r $VENV_FOLDER

    # Install build dependencies. https://devguide.python.org/setup/#install-dependencies
    sudo apt update
    sudo apt install -y \
        build-essential \
        gdb \
        lcov \
        pkg-config \
        libbz2-dev \
        libffi-dev \
        libgdbm-dev \
        libgdbm-compat-dev \
        liblzma-dev \
        libncurses-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        lzma \
        lzma-dev \
        tk-dev \
        uuid-dev \
        zlib1g-dev

    # Download Python from the official website.
    cd $DOWNLOAD_FOLDER
    wget -O python-$PYTHON_VERSION.tgz https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
    
    # Extract the source file.
    mkdir $BUILD_FOLDER
    tar -x -f python-$PYTHON_VERSION.tgz -C $BUILD_FOLDER --strip-components=1

    # Install Python from source. https://github.com/docker-library/python
    cd $BUILD_FOLDER
    ./configure \
        --prefix=$INSTALL_FOLDER \
        --enable-shared \
        --enable-optimizations \
        --with-lto \
        LDFLAGS=-Wl,-rpath,$INSTALL_FOLDER/lib
    make -j -s
    sudo make install

    # Create a symlink to Python.
    sudo ln -fs $INSTALL_FOLDER/bin/python$PYTHON_VERSION_SHORT /usr/local/bin/python$PYTHON_VERSION

    # Create a virtual envirment.
    python$PYTHON_VERSION -m venv $VENV_FOLDER
fi
