#!/bin/bash

ID=$(id -u)

VALIDATE(){
    if [ $? -eq 0 ] #$? exit stsus for previous command, scuess=0, failure=other than zero value
    then
        echo "!!!!!!!!!!!!Sucuessfully installed!!!!!!!!!!"
    else
        echo "---------Error: Failed to install----------"
    fi

}

if [ $ID -eq 0 ]
then
    echo "Proceeding with installtion"
else 
    echo "Run script as ROOT USER"
    exit 1
fi

yum install mysql -y
VALIDATE $? "MySql"
yum install git -y
VALIDATE $? "Git"