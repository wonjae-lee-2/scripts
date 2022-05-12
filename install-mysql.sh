#!/bin/bash

# Check the latest version of MySQL. https://www.mysql.com/

if [ -z $1 ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else  
    # Set environment variables.
    MYSQL_VERSION=$1
    MYSQL_VERSION_SHORT=$(echo $1 | cut -d "." -f -2)
    DOWNLOAD_FOLDER=~/downloads
    INSTALL_FOLDER=/opt/mysql-$MYSQL_VERSION
    DATA_FOLDER=/home/mysql/data
    SECURE_FILES_FOLDER=/home/mysql/mysql-files
    PASSWORD=$(cat password)

    # Clean up directories
    sudo rm -r $INSTALL_FOLDER
    sudo rm -r $DATA_FOLDER
    sudo rm -r $SECURE_FILES_FOLDER

    # Download the MySQL generic binary.
    cd $DOWNLOAD_FOLDER
    wget https://dev.mysql.com/get/Downloads/MySQL-$MYSQL_VERSION_SHORT/mysql-$MYSQL_VERSION-linux-glibc2.12-x86_64.tar.xz
    
    # Extract the binary file.
    sudo mkdir $INSTALL_FOLDER
    sudo tar -x -f mysql-$MYSQL_VERSION-linux-glibc2.12-x86_64.tar.xz -C $INSTALL_FOLDER --strip-components=1

    # Install runtime dependencies.
    sudo apt install -y \
        libaio1 \
        libtinfo5

    # Create a symlink to MySQL.
    sudo ln -fs /opt/mysql-$MYSQL_VERSION/bin/mysql /usr/local/bin/mysql
    sudo ln -fs /opt/mysql-$MYSQL_VERSION/bin/mysql /usr/local/bin/mysql-$MYSQL_VERSION

    # Create the MySQL group and user with a home directory.
    sudo useradd -m -U mysql

    # Set a password for the mysql user.
    echo mysql:$PASSWORD | sudo chpasswd

    # Add the MySQL directory to $PATH.
    sudo sed -i "/\/opt\/mysql-/d" /home/mysql/.profile
    echo PATH="$INSTALL_FOLDER/bin:\$PATH" | sudo tee -a /home/mysql/.profile

    # Create a data directory.
    sudo mkdir $DATA_FOLDER
    sudo chown mysql $DATA_FOLDER

    # Create a secure files directory.
    sudo mkdir $SECURE_FILES_FOLDER
    sudo chown mysql $SECURE_FILES_FOLDER

    # Initialize the data directory.
    sudo su - mysql -c "$INSTALL_FOLDER/bin/mysqld --initialize-insecure --basedir=$INSTALL_FOLDER --datadir=$DATA_FOLDER"
    sudo su - mysql -c "$INSTALL_FOLDER/bin/mysql_ssl_rsa_setup --datadir=$DATA_FOLDER"

    # Start the MySQL server.
    sudo su - mysql -c "$INSTALL_FOLDER/bin/mysqld_safe --basedir=$INSTALL_FOLDER --datadir=$DATA_FOLDER --secure-file-priv=$SECURE_FILES_FOLDER &"

    # Connect to the server.
    sudo su - mysql -c "mysql -u root --skip-password < echo 'root'@'localhost' IDENTIFIED BY '$PASSWORD';"

    sudo su - mysql -c "mysql -u root --skip-password < echo 'root'@'localhost' IDENTIFIED BY '$PASSWORD';"

    sudo su - mysql -c "mysql -u root --skip-password < echo 'root'@'localhost' IDENTIFIED BY '$PASSWORD';"

    /opt/mysql-$INSTALL_FOLDER/bin/mysqladmin -u root -p shutdown

fi
