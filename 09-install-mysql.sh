#!/bin/bash

ID=$(id -u)

if [ $ID -ne 0 ]
then 
    echo "Run this with root acess"
    exit 1 # value should be other than 0
else
    echo "You are root user"
fi # fi indicates end of if condition

yum install mysql -y

if [ $? -eq 0 ] #$? outputs scuess or failure, scuess=0, failure=other than zero value
then
    echo "Sucuessfully installed"
else
    echo "Error: Failed to install"
fi