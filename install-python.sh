#!/bin/bash

# Check the latest version of Python. https://www.python.org/

if [ -z $1 ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else
    # Set environment variables.
    PYTHON_VERSION=$1
    PYTHON_VERSION_SHORT=$(echo $PYTHON_VERSION | cut -d "." -f -2)
    DOWNLOAD_FOLDER=~/downloads
    BUILD_FOLDER=~/downloads/python-$PYTHON_VERSION
    INSTALL_FOLDER=/opt/python-$PYTHON_VERSION
    VENV_FOLDER=~/venv/python-$PYTHON_VERSION
    SCRIPT_FOLDER=~/github/scripts

    # Clean up directories.
    sudo rm -r $BUILD_FOLDER
    sudo rm -r $INSTALL_FOLDER
    sudo rm -r $VENV_FOLDER

    # Install build dependencies. https://devguide.python.org/setup/#install-dependencies
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
    wget -O python-$PYTHON_VERSION.tgz https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tgz
    
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
    sudo ln -fs $INSTALL_FOLDER/bin/python$PYTHON_VERSION_SHORT /usr/local/bin/python-$PYTHON_VERSION

    # Create a virtual envirment.
    python-$PYTHON_VERSION -m venv $VENV_FOLDER

    # Install packages in the virutal environment.
    cd $SCRIPT_FOLDER
    . $VENV_FOLDER/bin/activate
    pip install -U -r ./docker-python/requirements.txt
    deactivate
fi
