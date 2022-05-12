#!/bin/bash

# Check the latest version of PostgreSQL. https://www.postgresql.org/

if [ -z $1 ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else  
    # Set environment variables.
    PGSQL_VERSION=$1
    DOWNLOAD_FOLDER=~/downloads
    BUILD_FOLDER=$DOWNLOAD_FOLDER/pgsql-$PGSQL_VERSION
    INSTALL_FOLDER=/opt/pgsql-$PGSQL_VERSION
    DATA_FOLDER=/home/postgres/data
    PASSWORD=$(cat password)

    # Clean up directories
    sudo rm -r $BUILD_FOLDER
    sudo rm -r $INSTALL_FOLDER
    sudo rm -r $DATA_FOLDER

    # Download the PostgreSQL source file.
    cd $DOWNLOAD_FOLDER
    wget https://ftp.postgresql.org/pub/source/v$PGSQL_VERSION/postgresql-$PGSQL_VERSION.tar.gz

    # Extract the source file.
    mkdir $BUILD_FOLDER
    tar -x -f postgresql-$PGSQL_VERSION.tar.gz -C $BUILD_FOLDER --strip-components=1

    # Install PostgreSQL from source.
    cd $BUILD_FOLDER
    ./configure --prefix=$INSTALL_FOLDER
    make -s
    sudo make install

    # Create a symlink to PostgreSQL.
    sudo ln -fs $INSTALL_FOLDER/bin/psql /usr/local/bin/psql
    sudo ln -fs $INSTALL_FOLDER/bin/psql /usr/local/bin/psql-$PGSQL_VERSION

    # Create the postgres group and user with a home directory.
    sudo useradd -m -U postgres

    # Set a password for the postgres user.
    echo postgres:$PASSWORD | sudo chpasswd

    # Add the PostgreSQL directory to $PATH.
    sudo sed -i "/\/opt\/pgsql-/d" /home/postgres/.profile
    echo PATH="$INSTALL_FOLDER/bin:\$PATH" | sudo tee -a /home/postgres/.profile

    # Create a data directory.
    sudo mkdir $DATA_FOLDER
    sudo chown postgres $DATA_FOLDER

    # Initialize a database cluster.
    sudo -u postgres $INSTALL_FOLDER/bin/initdb -D $DATA_FOLDER

    # Update connection settings.

    # Start the PostgreSQL server.
    sudo -u postgres $INSTALL_FOLDER/bin/pg_ctl -D $DATA_FOLDER -l /home/postgres/logfile start

    # Create a password for the postgres role.
    sudo -u postgres psql -c "ALTER USER postgres PASSWORD '$PASSWORD';"
    
    # Create a postgresql role for the default user.
    sudo -u postgres psql -c "CREATE ROLE ubuntu LOGIN CREATEDB CREATEROLE PASSWORD '$PASSWORD';"

    # Create a database for the default user.
    $INSTALL_FOLDER/bin/createdb ubuntu

    # Stop the PostgreSQL server
    sudo -u postgres $INSTALL_FOLDER/bin/pg_ctl -D $DATA_FOLDER stop
fi
