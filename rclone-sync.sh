#!/bin/bash

while true
do
    rclone sync ~/github onedrive:backup/github --exclude=/renv/library/ > /dev/null # Exclude the renv library folder which consists of symlinks instead of pysical files.
    sleep 600
done
