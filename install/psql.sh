#!/bin/bash

if [ -z ${PSQL_VERSION} ]
then
    echo
    echo "Check the latest version of PostgreSQL. https://www.postgresql.org/"
    read -p "Which version of PostgreSQL would you like to install? " PSQL_VERSION
fi

##############################################################
# Uncomment below to install from the third-party repository #
##############################################################

# Set environment variables. PSQL_VERSION is either exported from `install.sh` or read from user input.
PSQL_VERSION_SHORT=$(echo ${PSQL_VERSION} | cut -d "." -f 1)
GPG_KEY_PATH=/usr/share/keyrings/postgresql.gpg
CONF_FOLDER=/etc/postgresql/${PSQL_VERSION_SHORT}/main
PASSWORD=$(cat ~/password)

# Install dependencies.
sudo apt update
sudo apt install -y \
    curl \
    ca-certificates \
    gnupg

# Download the repository key.
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --yes --dearmor -o ${GPG_KEY_PATH}

# Create the repository configuration.
echo "deb [signed-by=${GPG_KEY_PATH}] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/postgresql.list > /dev/null

# Install PostgreSQL from the repository.
sudo apt update
sudo apt install -y postgresql-${PSQL_VERSION_SHORT}

# Set a password for the postgres user.
echo postgres:${PASSWORD} | sudo chpasswd

# Create a password for the postgres role.
sudo su - postgres -c "psql -c \"ALTER USER postgres PASSWORD '${PASSWORD}';\""

# Create a postgresql role for the default user.
sudo su - postgres -c "psql -c \"CREATE ROLE ubuntu LOGIN CREATEDB CREATEROLE PASSWORD '${PASSWORD}';\""

# Create a database for the default user.
createdb ubuntu

# Stop the PostgreSQL server.
sudo systemctl stop postgresql

# Prevent the PostgreSQL from starting at start-up.
sudo systemctl disable postgresql

# Update the client authentication configuration file.
sudo sed -i '/^# IPv4 local connections:/a host\tall\t\tall\t\t0.0.0.0/0\t\tscram-sha-256' ${CONF_FOLDER}/pg_hba.conf

# Update the main configuration file.
sudo sed -i "s/^#listen_addresses = 'localhost'/listen_addresses = '*'\t/" ${CONF_FOLDER}/postgresql.conf

###########################################
# Uncomment below to install from source. #
###########################################

# Set environment variables. PSQL_VERSION is either exported from `install.sh` or read from user input.
#DOWNLOAD_FOLDER=~/downloads
#BUILD_FOLDER=${DOWNLOAD_FOLDER}/PSQL-${PSQL_VERSION}
#INSTALL_FOLDER=/opt/PSQL-${PSQL_VERSION}
#DATA_FOLDER=/home/postgres/data
#PASSWORD=$(cat ~/password)

# Clean up directories
#sudo rm -r ${BUILD_FOLDER}
#sudo rm -r ${INSTALL_FOLDER}
#sudo rm -r ${DATA_FOLDER}

# Download the PostgreSQL source file.
#cd ${DOWNLOAD_FOLDER}
#wget https://ftp.postgresql.org/pub/source/v${PSQL_VERSION}/postgresql-${PSQL_VERSION}.tar.gz

# Extract the source file.
#mkdir ${BUILD_FOLDER}
#tar -x -f postgresql-${PSQL_VERSION}.tar.gz -C ${BUILD_FOLDER} --strip-components=1

# Install PostgreSQL from source.
#cd ${BUILD_FOLDER}
#./configure --prefix=${INSTALL_FOLDER}
#make -s
#sudo make install

# Create a symlink to PostgreSQL.
#sudo ln -fs ${INSTALL_FOLDER}/bin/psql /usr/local/bin/psql

# Create the postgres group and user with a home directory.
#sudo useradd -m -U postgres

# Set a password for the postgres user.
#echo postgres:${PASSWORD} | sudo chpasswd

# Add the PostgreSQL directory to $PATH.
#sudo sed -i "/\/opt\/PSQL-/d" /home/postgres/.profile
#echo PATH="${INSTALL_FOLDER}/bin:\$PATH" | sudo tee -a /home/postgres/.profile

# Create a data directory.
#sudo mkdir ${DATA_FOLDER}
#sudo chown postgres ${DATA_FOLDER}

# Initialize a database cluster.
#sudo su - postgres -c "initdb -D ${DATA_FOLDER}"

# Update the client authentication configuration file.
#sudo sed -i '/^# IPv4 local connections:/a host\tall\t\tall\t\t0.0.0.0/0\t\tscram-sha-256' ${DATA_FOLDER}/pg_hba.conf

# Update the main configuration file.
#sudo sed -i "s/^#listen_addresses = 'localhost'/listen_addresses = '*'\t/" ${DATA_FOLDER}/postgresql.conf

# Start the PostgreSQL server.
#sudo su - postgres -c "pg_ctl -D ${DATA_FOLDER} -l /home/postgres/logfile start"

# Create a password for the postgres role.
#sudo su - postgres -c "psql -c \"ALTER USER postgres PASSWORD '${PASSWORD}';\""

# Create a postgresql role for the default user.
#sudo su - postgres -c "psql -c \"CREATE ROLE ubuntu LOGIN CREATEDB CREATEROLE PASSWORD '${PASSWORD}';\""

# Create a database for the default user.
#${INSTALL_FOLDER}/bin/createdb ubuntu

# Stop the PostgreSQL server
#sudo su - postgres -c "pg_ctl -D ${DATA_FOLDER} stop"
