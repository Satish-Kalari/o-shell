#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

VALIDATE(){

    if [ $1 -ne 0 ] #l$1 takes valuve from $? VALIDATE command from line 43  
    then
        echo -e "$2 ... $R FAILLED $N" #-e enables $ functions in this case color coding
        exit 1
    else 
        echo -e "$2 ...$G SUCESSFUL $N " # &=both success and failure >>=appending, >= overwite content 
    fi
}

# Update the system
dnf update &>> $LOGFILE
VALIDATE $? "Update dnf"

# Install PostgreSQL
dnf install -y postgresql15.x86_64 postgresql15-server &>> $LOGFILE
VALIDATE $? "Install postgresql"

# Initialize the database
postgresql-setup --initdb &>> $LOGFILE
VALIDATE $? "postgresql setup"

# Start the PostgreSQL service
systemctl start postgresql &>> $LOGFILE
VALIDATE $? "postgresql start"

# Enable the PostgreSQL service to start on boot
systemctl enable postgresql &>> $LOGFILE
VALIDATE $? "postgresql enabled"

# Check the status of the PostgreSQL service
systemctl status postgresql &>> $LOGFILE
VALIDATE $? "postgresql status"

# Take a backup of the postgresql.conf file
cp /var/lib/pgsql/data/postgresql.conf /var/lib/pgsql/data/postgresql.conf.bak &>> $LOGFILE
VALIDATE $? "postgresql start"

# Modify the postgresql.conf file to accept connections from anywhere
sed -i 's/#listen_addresses = 'localhost'/listen_addresses = '\''\*'\''/' /var/lib/pgsql/data/postgresql.conf &>> $LOGFILE
VALIDATE $? "postgresql remote acess"

# Change the password of the postgres user
echo "postgres" | sudo passwd --stdin postgres

# Login using Postgres system account
su - postgres <<EOF

# Change the postgres user password
psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"

# Exit from the postgres user
exit
EOF

# Modify the pg_hba.conf file to allow remote connections
sed -i 's/#host all all 127.0.0.1\/32 ident host all all 0.0.0.0\/0 md5/host all all 0.0.0.0\/0 md5/' /var/lib/pgsql/data/pg_hba.conf

# Restart the PostgreSQL service
systemctl restart postgresql &>> $LOGFILE
VALIDATE $? "postgresql restart"