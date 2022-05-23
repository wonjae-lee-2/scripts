#!/bin/bash

# Check the latest version of R. https://www.r-project.org/

read -p "Which version of R would you like to install? " INPUT
if [ -z $INPUT ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else
    # Set environment variables.
    R_VERSION=$INPUT
    R_VERSION_SHORT=$(echo $R_VERSION | cut -d "." -f 1)
    DOWNLOAD_FOLDER=~/downloads
    BUILD_FOLDER=~/downloads/r-$R_VERSION
    INSTALL_FOLDER=/opt/r-$R_VERSION
    SCRIPT_FOLDER=~/github/scripts

    # Clean up the directories of the same version.
    sudo rm -r $BUILD_FOLDER
    sudo rm -r $INSTALL_FOLDER

    # Install build dependencies. Add build-essential and gfortran. https://cloud.r-project.org/doc/manuals/r-release/R-admin.html#Useful-libraries-and-programs
    sudo apt update
    sudo apt install -y \
        libbz2-dev \
        libcairo2-dev \
        fontconfig \
        libfreetype-dev \
        libfribidi-dev \
        libglib2.0-dev \
        libharfbuzz-dev \
        libx11-dev \
        libxext-dev \
        libxt-dev \
        libcurl4-openssl-dev \
        libicu-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libtirpc-dev \
        libcrypt-dev \
        libncurses-dev \
        libpango1.0-dev \
        libpkgconf-dev \
        libpcre2-dev \
        libreadline-dev \
        tcl-dev \
        tk-dev \
        liblzma-dev \
        zlib1g-dev \
        libblas-dev \
        liblapack-dev \
        build-essential \
        gfortran

    # Download R from CRAN.
    cd $DOWNLOAD_FOLDER
    wget https://cloud.r-project.org/src/base/R-$R_VERSION_SHORT/R-$R_VERSION.tar.gz

    # Extract the source file.
    mkdir $BUILD_FOLDER
    tar -x -f R-$R_VERSION.tar.gz -C $BUILD_FOLDER --strip-components=1

    # Install R from source. https://github.com/rocker-org/rocker-versioned2
    cd $BUILD_FOLDER
    ./configure \
        --prefix=$INSTALL_FOLDER \
        --enable-R-shlib \
        --enable-memory-profiling \
        --with-blas \
        --with-lapack \
        --with-tcltk
    make -j -s
    sudo make install

    # Create a symlink to R.
    sudo ln -fs $INSTALL_FOLDER/bin/R /usr/local/bin/R
    sudo ln -fs $INSTALL_FOLDER/bin/Rscript /usr/local/bin/Rscript
    sudo ln -fs $INSTALL_FOLDER/bin/R /usr/local/bin/R-$R_VERSION
    sudo ln -fs $INSTALL_FOLDER/bin/Rscript /usr/local/bin/Rscript-$R_VERSION

    # Install package dependencies.
    sudo apt install -y \
        libcurl4-openssl-dev \
        libxml2-dev \
        libpq-dev \
        libssl-dev \
        libmariadb-dev

    # Install packages.
    cd $SCRIPT_FOLDER
    Rscript ./docker-r/requirements.r
fi
