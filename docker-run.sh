#!/bin/bash

SOURCE="/home/ubuntu/github"

# Provide the first command line argument to run the Julia, Python, R or Postgres container.
# Provide the second command line argument to run Pluto, Jupyter or Rstudio. If no second command line argument is provided, run bash.
# In case of Postgres, the second command line argument sets the password.

read -p "Which language would you like to run? " INPUT1
read -p "Which version would you like to run? " INPUT2
read -p "Which program would you like to run? " INPUT3
read -p "For PostgreSQL and MySQL, what is your password? " INPUT4
if [ $INPUT1 = "julia" ]
then
    if [ $INPUT3 = "bash" ]
    then
        docker run -d -it -p 1234:1234 --rm --mount type=bind,src=$SOURCE,dst=/root/github --name julia lee/julia:$INPUT2 bash
    elif [ $INPUT3 = "jupyter" ]
    then
        docker run -it -p 1234:1234 --rm --mount type=bind,src=$SOURCE,dst=/root/github --name julia lee/julia:$INPUT2
    elif [ $INPUT3 = "pluto" ]
    then
        docker run -it -p 1234:1234 --rm --mount type=bind,src=$SOURCE,dst=/root/github --name julia lee/julia:$INPUT2 julia -e 'using Pluto; Pluto.run(; host="0.0.0.0", port=1234, launch_browser=false)'
    fi
elif [ $INPUT1 = "python" ]
then
    if [ $INPUT3 = "bash" ]
    then
        docker run -d -it -p 8888:8888 --rm --mount type=bind,src=$SOURCE,dst=/root/github --name python lee/python:$INPUT2 bash
    elif [ $INPUT3 = "jupyter" ]
    then
        docker run -it -p 8888:8888 --rm --mount type=bind,src=$SOURCE,dst=/root/github --name python lee/python:$INPUT2
    fi
elif [ $INPUT1 = "r" ]
then
    if [ $INPUT3 = "bash" ]
    then
        docker run -d -it -p 8787:8787 --rm --mount type=bind,src=$SOURCE,dst=/home/rstudio/github --name r-docker lee/r:$INPUT2 bash
    elif [ $INPUT3 = "rstudio" ]
    then
        docker run -it -p 8787:8787 --rm --mount type=bind,src=$SOURCE,dst=/home/rstudio/github --name r-docker lee/r:$INPUT2
    fi
elif [ $INPUT1 = "postgresql" ]
then
    docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=$INPUT4 --mount type=volume,src=postgres,dst=/var/lib/postgresql/data --name postgres postgres:$INPUT2
    # Use the username 'postgres' and the password '$INPUT4' to connect to the database remotely.
    # Type `docker run -exec -it -u postgres postgres bash` to open a new terminal as the user `postgres`.
elif [ $INPUT1 = "mysql" ]
then
    docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$INPUT4 --mount type=volume,src=mysql,dst=/var/lib/mysql --name mysql mysql:$INPUT2
    # Use the username 'root' and the password '$INPUT4' to connect to the database remotely.
    # Type `docker run -exec -it mysql bash` to open a new terminal as the user `root`.
fi
