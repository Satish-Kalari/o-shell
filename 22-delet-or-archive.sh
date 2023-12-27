#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# Check if all arguments are provided
if [ $# -lt 4 ]; then
 echo "Usage: $0 <source_directory> <action> <destination_directory> <days> [max_size]"
 exit 1
fi

# Assign arguments to variables
source_directory=$1
action=$2
destination_directory=$3
days=$4
max_size=$5

# Check if action is either delete or archive
if [ "$action" != "delete" ] && [ "$action" != "archive" ]; 
then
 echo -e "$R Invalid action.$N Action must be either delete or archive."
 exit 1
fi

# Check if action is archive and destination directory is provided
if [ "$action" = "archive" ] && [ -z "$destination_directory" ]; 
then
 echo -e " $R Destination directory must be provided when action is archive.$N"
 exit 1
fi

# If max_size is provided, find files older than the specified number of days and larger than the maximum size
if [ -n "$max_size" ]; 
then
 files=$(find "$source_directory" -name "*.log" -mtime +$days -size +$max_size)
else
 files=$(find "$source_directory" -name "*.log" -mtime +$days)
fi

# Loop over the files
for file in $files; 
do
 # If action is delete, delete the file
 if [ "$action" = "delete" ]; then
 rm "$file"
 # If action is archive, archive the file
 elif [ "$action" = "archive" ]; then
 zip -r "$destination_directory/$(basename "$file").zip" "$file"
 rm "$file"
 fi
done
