#!/bin/bash

# Define the backup directory
backup_dir="/mnt/Mac-Mini-Backup/home_backups"

# List backup directory to file temp.txt
ls "${backup_dir}" >temp.txt

#Build prior month search fragment
OLDMON=$(date -d "last month" "+%m")
CURYEAR=$(date +%Y)
CURDAY=$(date +%d)
F_NAME="$CURYEAR$OLDMON$CURDAY"

#Find prior month file
echo $F_NAME
OLDFILE="$(grep ."$F_NAME" temp.txt)"

#Clean up my mess. The file is small but I don't want to get into the habit
#of leaving crap all over the directory tree.

rm "${OLDFILE}"
rm temp.txt
