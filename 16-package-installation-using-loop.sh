#!.bin/bash

ID=$(id -u) #getting user ID

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log" #$0 is to get script file name

echo "script started excicuting at $TIMESTAMP" &>> $LOGFILE # &=both sucess and failure >>appending 

VALIDATE(){

    if [ $1 -ne 0 ] #l$1 takes valuve from $? VALIDATE command from line 43  
    then
        echo -e "$2 ... $R FAILLED $N" 
    else 
        echo -e "$2 ...$G SUCESSFUL $N "
    fi
}

if [ $ID -ne 0 ] #checking if user as root acess or permisions to intall the packages 
then
    echo -e "$R Use Root Acess $N" #if does not have permission then asks to get permission
    exit 1 #since cany install exiting the program
else 
    echo -e "$G Proceding with Installation $N" # if had all permmsions it will proceeed to instaltion of packages
fi

#echo all arguments passed: $@
#packes to be inalled  --- git mysql postfix net-tool
#package=git for first time, mysql for 2nd time and so on 

for package in $@
do
    yum list intalled $package &>> $LOGFILE #checking pachages is already installed or not 
    if [ $? -ne 0 ] #if not install package
    then
        yum install $package -y &>> $LOGFILE #intalling package
        VALIDATE $? "Installation of $package" #validaing if package is installed or not
    else
        echo -e "$package is alreday isntalled..  $Y SKIPPING $N"
    fi
done