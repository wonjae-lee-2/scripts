#!/bin/bash

echo "Check the latest version of MySQL. https://www.mysql.com/"
echo
read -p "Which version of MySQL would you like to install? " INPUT
if [ -z $INPUT ]
then
    echo "Please enter a version number as the first argument."
    exit 1
else
    ##############################################################
    # Uncomment below to install from the third-party repository #
    ##############################################################
        
    # Set environment variables.
    #MYSQL_VERSION=$(echo $INPUT | cut -d "." -f -2)
    #GPG_KEY_PATH=/usr/share/keyrings/mysql.gpg
    #PASSWORD=$(cat ~/password)

    # Install dependencies.
    #sudo apt update
    #sudo apt install -y \
        #curl \
        #ca-certificates \
        #gnupg
    
    # Download the repository key.
    #sudo gpg --keyserver keyserver.ubuntu.com --receive-keys 3A79BD29

    # Export the repository key.
    #sudo gpg -o $GPG_KEY_PATH --export 3A79BD29

    # Create the repository configuration.
    #echo "deb [signed-by=$GPG_KEY_PATH] http://repo.mysql.com/apt/ubuntu $(lsb_release -cs) mysql-$MYSQL_VERSION" | sudo tee /etc/apt/sources.list.d/mysql.list > /dev/null

    # Install MySQL from the repository.
    #sudo apt update
    #sudo DEBIAN_FRONTEND=noninteractive apt install -y mysql-server

    # Create a MySQL user for the default user. (root@localhost is authenticated with the auth_socket plugin, which disregards password. Type `sudo mysql` to log in as root@localhost.)
    #sudo mysql -u root -e "CREATE USER 'ubuntu'@'%' IDENTIFIED BY '$PASSWORD';"

    # Grant all privileges to the default user. (Type `mysql -p` to log in as ubuntu@% with password.)
    #sudo mysql -u root -e "GRANT ALL ON *.* TO 'ubuntu'@'%';"
    
    # Stop the MySQL server.
    #sudo systemctl stop mysql
    
    # Prevent the SQL server from starting at startup.
    #sudo systemctl disable mysql

    #######################################################
    # Uncomment below to install from the generic binary. #
    #######################################################

    # Set environment variables.
    MYSQL_VERSION=$INPUT
    MYSQL_VERSION_SHORT=$(echo $1 | cut -d "." -f -2)
    DOWNLOAD_FOLDER=~/downloads
    INSTALL_FOLDER=/opt/mysql-$MYSQL_VERSION
    DATA_FOLDER=/home/mysql/data
    SECURE_FILES_FOLDER=/home/mysql/mysql-files
    PASSWORD=$(cat ~/password)

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
    sudo apt update
    sudo apt install -y \
        libaio1 \
        libtinfo5

    # Create a symlink to MySQL.
    sudo ln -fs $INSTALL_FOLDER/bin/mysql /usr/local/bin/mysql

    # Create the MySQL group and user with a home directory.
    sudo useradd -m -U mysql

    # Set a password for the mysql user.
    echo mysql:$PASSWORD | sudo chpasswd

    # Add the MySQL directory to $PATH.
    sudo sed -i "/mysql-$MYSQL_VERSION/d" /home/mysql/.profile
    echo PATH="$INSTALL_FOLDER/bin:\$PATH" | sudo tee -a /home/mysql/.profile

    # Create a data directory.
    sudo mkdir $DATA_FOLDER
    sudo chown mysql $DATA_FOLDER

    # Create a secure files directory.
    sudo mkdir $SECURE_FILES_FOLDER
    sudo chown mysql $SECURE_FILES_FOLDER

    # Initialize the data directory.
    sudo su - mysql -c "mysqld --initialize-insecure --basedir=$INSTALL_FOLDER --datadir=$DATA_FOLDER"
    sudo su - mysql -c "mysql_ssl_rsa_setup --datadir=$DATA_FOLDER"

    # Start the MySQL server.
    sudo su - mysql -c "mysqld_safe --basedir=$INSTALL_FOLDER --datadir=$DATA_FOLDER --secure-file-priv=$SECURE_FILES_FOLDER &"

    # Wait few seconds before the server starts in the background.
    sleep 5

    # Create a MySQL password for the root user.
    mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$PASSWORD';"
    
    # Create a MySQL user for the default user.
    mysql -u root -p$PASSWORD -e "CREATE USER 'ubuntu'@'%' IDENTIFIED BY '$PASSWORD';"

    # Grant all privileges to the default user.
    mysql -u root -p$PASSWORD -e "GRANT ALL ON *.* TO 'ubuntu'@'%';"

    # Stop the MySQL server.
    $INSTALL_FOLDER/bin/mysqladmin -p$PASSWORD shutdown
fi
