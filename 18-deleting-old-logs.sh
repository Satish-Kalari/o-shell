#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR="/tmp/shellscript-logs"

if [ ! -d $SOURCE_DIR ] #! denotes opposit, in this case if source dir does not exsist
then
    echo -e "$R Sourec Directory: $SOURCE_DIR Dose Not Exsist $N"
fi

FILES_TO_DELETE=$(find $SOURCE_DIR -type f -mtime +15 -name "*.log") # -type f= type to find is file, -mtime=Modified time, 15=days, -name *.log= fild all files with extention .log

while IFS= read -r line #IFS= Interna; Feild Separator
do
    echo "Deleting File: $line"
    rm -rf $line
done <<< $FILES_TO_DELETE
