#!/bin/bash

# Check the latest version of MySQL. https://www.mysql.com/

if [ -z $1 ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else
    ##############################################################
    # Uncomment below to install from the third-party repository #
    ##############################################################
        
    # Set environment variables.
    MYSQL_VERSION=$(echo $1 | cut -d "." -f -2)
    GPG_KEY_PATH=/usr/share/keyrings/repo.mysql.com.gpg
    SECURE_FILES_FOLDER=/usr/local/mysql/mysql-files
    PASSWORD=$(cat password)

    # Install dependencies.
    sudo apt install -y \
        curl \
        ca-certificates \
        gnupg
    
    # Download the repository key.
    gpg --keyserver keyserver.ubuntu.com --recv-keys 3A79BD29

    # Export the repository key.
    gpg --export 3A79BD29 | sudo tee $GPG_KEY_PATH

    # Create the repository configuration.
    echo "deb [signed-by=$GPG_KEY_PATH] http://repo.mysql.com/apt/ubuntu $(lsb_release -cs) mysql-$MYSQL_VERSION" | sudo tee /etc/apt/sources.list.d/mysql.list

    # Install MySQL from the repository.
    sudo apt update
    sudo apt install -y mysql-server

    #######################################################
    # Uncomment below to install from the generic binary. #
    #######################################################

    # Set environment variables.
    #MYSQL_VERSION=$1
    #MYSQL_VERSION_SHORT=$(echo $1 | cut -d "." -f -2)
    #DOWNLOAD_FOLDER=~/downloads
    #INSTALL_FOLDER=/opt/mysql-$MYSQL_VERSION
    #DATA_FOLDER=/home/mysql/data
    #SECURE_FILES_FOLDER=/home/mysql/mysql-files
    #PASSWORD=$(cat password)

    # Clean up directories
    #sudo rm -r $INSTALL_FOLDER
    #sudo rm -r $DATA_FOLDER
    #sudo rm -r $SECURE_FILES_FOLDER

    # Download the MySQL generic binary.
    #cd $DOWNLOAD_FOLDER
    #wget https://dev.mysql.com/get/Downloads/MySQL-$MYSQL_VERSION_SHORT/mysql-$MYSQL_VERSION-linux-glibc2.12-x86_64.tar.xz
    
    # Extract the binary file.
    #sudo mkdir $INSTALL_FOLDER
    #sudo tar -x -f mysql-$MYSQL_VERSION-linux-glibc2.12-x86_64.tar.xz -C $INSTALL_FOLDER --strip-components=1

    # Install runtime dependencies.
    #sudo apt install -y \
        #libaio1 \
        #libtinfo5

    # Create a symlink to MySQL.
    #sudo ln -fs /opt/mysql-$MYSQL_VERSION/bin/mysql /usr/local/bin/mysql
    #sudo ln -fs /opt/mysql-$MYSQL_VERSION/bin/mysql /usr/local/bin/mysql-$MYSQL_VERSION

    # Create the MySQL group and user with a home directory.
    #sudo useradd -m -U mysql

    # Set a password for the mysql user.
    #echo mysql:$PASSWORD | sudo chpasswd

    # Add the MySQL directory to $PATH.
    #sudo sed -i "/\/opt\/mysql-/d" /home/mysql/.profile
    #echo PATH="$INSTALL_FOLDER/bin:\$PATH" | sudo tee -a /home/mysql/.profile

    # Create a data directory.
    #sudo mkdir $DATA_FOLDER
    #sudo chown mysql $DATA_FOLDER

    # Create a secure files directory.
    #sudo mkdir $SECURE_FILES_FOLDER
    #sudo chown mysql $SECURE_FILES_FOLDER

    # Initialize the data directory.
    #sudo su - mysql -c "mysqld --initialize-insecure --basedir=$INSTALL_FOLDER --datadir=$DATA_FOLDER"
    #sudo su - mysql -c "mysql_ssl_rsa_setup --datadir=$DATA_FOLDER"

    # Start the MySQL server.
    #sudo su - mysql -c "mysqld_safe --basedir=$INSTALL_FOLDER --datadir=$DATA_FOLDER --secure-file-priv=$SECURE_FILES_FOLDER &"

    # Wait few seconds before the server starts in the background.
    #sleep 5

    # Create a MySQL password for the root user.
    #mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$PASSWORD';"

    #mysql -u root -p$PASSWORD -e "CREATE USER 'ubuntu'@'%' IDENTIFIED BY '$PASSWORD';"

    #mysql -u root -p$PASSWORD -e "GRANT ALL ON *.* TO 'ubuntu'@'%';"

    #$INSTALL_FOLDER/bin/mysqladmin -p$PASSWORD shutdown
fi
