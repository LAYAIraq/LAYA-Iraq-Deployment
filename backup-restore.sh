#!/bin/bash
####################################
#
# Restore backup script
#
####################################

# What to backup. 
echo $1
echo pwd
backup_files=$1
docker_volumes=${2-"../docker-volumes/"}

# Print start status message.
echo "Restoring Backup Files from $backup_files"
tar -xzfv $backup_files


# Backup the files using tar.
echo "Stopping back-end container"
docker-compose stop laya-backend

# Copy all files from restored backup into docker volume
echo "Copying files into back-end volume"
cp -r ./home/layaadmin/* $docker_volumes
echo "Re-starting backend container"
docker-compose up -d --force-recreate laya-backend

# Print end status message.
echo "Restoring Backup finished"
date
