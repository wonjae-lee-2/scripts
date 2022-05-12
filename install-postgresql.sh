#!/bin/bash

# Check the latest version of Rust. https://www.postgresql.org/

if [ -z $1 ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else  
    # Set environment variables.
    POSTGRESQL_VERSION=$1
    PASSWORD=$(cat password)

    # Import the repository key.
    sudo apt install curl ca-certificates gnupg
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg >/dev/null

    # Create the package list file.
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

    # Update the package list.
    sudo apt update

    # Install PostgreSQL.
    sudo apt install -y postgresql-$POSTGRESQL_VERSION

    # Set a password for the user postgres.
    echo postgres:$PASSWORD | sudo chpasswd

    # Create a new postgresql user for the default user.
    sudo -u postgres psql -c "CREATE ROLE ubuntu LOGIN CREATEDB CREATEROLE PASSWORD '$PASSWORD'"

    # Create a database for the default user.
    createdb ubuntu

    # Stop the PostgreSQL server
    sudo systemctl stop postgresql

    # Prevent the PostgreSQL server from starting automatically at startup.
    sudo systemctl disable postgresql
fi
