#!/bin/bash

ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)

LOGFILE="/tmp/$0-$TIMESTAMP" #$0 pulles scrit file name

VALIDATE(){
    if [ $1 -eq 0 ] #$? outputs scuess or failure, scuess=0, failure=other than zero value
    then
        echo "$2 Sucuessfully!"
    else
        echo "$2 Failed"
    fi

}

if [ $ID -eq 0 ]
then
    echo "Proceeding with installtion"
else 
    echo "Run script as ROOT USER"
    exit 1
fi

yum install mysql -y &>> $LOGFILE
VALIDATE $? "MySql installed"
yum install git -y &>> $LOGFILE
VALIDATE $? "Git installed"