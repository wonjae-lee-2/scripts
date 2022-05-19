#!/bin/bash

JULIA_VERSION="1.7.2"
PYTHON_VERSION="3.10.4"
R_VERSION="4.2.0"
POSTGRES_VERSION="14.2"
MYSQL_VERSION="8.0.29"
SOURCE="/home/ubuntu/github"

# Provide the first command line argument to run the Julia, Python, R or Postgres container.
# Provide the second command line argument to run Pluto, Jupyter or Rstudio. If no second command line argument is provided, run bash.
# In case of Postgres, the second command line argument sets the password.

if [ $1 = "julia" ]
then
    if [ -z $2 ]
    then
        docker run -d -it -p 1234:1234 --rm --mount type=bind,src=$SOURCE,dst=/root/github --name julia lee/julia:$JULIA_VERSION bash
    elif [ $2 = "pluto" ]
    then
        docker run -it -p 1234:1234 --rm --mount type=bind,src=$SOURCE,dst=/root/github --name julia lee/julia:$JULIA_VERSION
    fi
elif [ $1 = "python" ]
then
    if [ -z $2 ]
    then
        docker run -d -it -p 8888:8888 --rm --mount type=bind,src=$SOURCE,dst=/root/github --name python lee/python:$PYTHON_VERSION bash
    elif [ $2 = "jupyter" ]
    then
        docker run -it -p 8888:8888 --rm --mount type=bind,src=$SOURCE,dst=/root/github --name python lee/python:$PYTHON_VERSION
    fi
elif [ $1 = "r" ]
then
    if [ -z $2 ]
    then
        docker run -d -it -p 8787:8787 --rm --mount type=bind,src=$SOURCE,dst=/home/rstudio/github --name r-docker lee/r:$R_VERSION bash
    elif [ $2 = "rstudio" ]
    then
        docker run -it -p 8787:8787 --rm --mount type=bind,src=$SOURCE,dst=/home/rstudio/github --name r-docker lee/r:$R_VERSION
    fi
elif [ $1 = "postgres" ]
then
    docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=$2 --mount type=volume,src=postgres,dst=/var/lib/postgresql/data --name postgres postgres:$POSTGRES_VERSION
    # Use the username 'postgres' and the password '$2' to connect to the database remotely.
    # Type `docker run -exec -it -u postgres postgres bash` to open a new terminal as the user `postgres`.
elif [ $1 = "mysql" ]
then
    docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$2 --mount type=volume,src=mysql,dst=/var/lib/mysql --name mysql mysql:$MYSQL_VERSION
    # Use the username 'root' and the password '$2' to connect to the database remotely.
    # Type `docker run -exec -it mysql bash` to open a new terminal as the user `root`.
fi
