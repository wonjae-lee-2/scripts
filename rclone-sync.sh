#!/bin/bash

while true
do 
    rclone sync ~/github onedrive:backup/github > /dev/null
    sleep 600
done