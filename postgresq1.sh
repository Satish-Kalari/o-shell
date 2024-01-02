#!/bin/bash

# Update the system
sudo dnf update

# Install PostgreSQL
sudo dnf install -y postgresql15.x86_64 postgresql15-server

# Initialize the database
sudo postgresql-setup --initdb

# Start the PostgreSQL service
sudo systemctl start postgresql

# Enable the PostgreSQL service to start on boot
sudo systemctl enable postgresql

# Check the status of the PostgreSQL service
sudo systemctl status postgresql

# Take a backup of the postgresql.conf file
sudo cp /var/lib/pgsql/data/postgresql.conf /var/lib/pgsql/data/postgresql.conf.bak

# Modify the postgresql.conf file to accept connections from anywhere
sudo sed -i 's/#listen_addresses = 'localhost'/listen_addresses = '\''\*'\''/' /var/lib/pgsql/data/postgresql.conf

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
sudo sed -i 's/#host all all 127.0.0.1\/32 ident host all all 0.0.0.0\/0 md5/host all all 0.0.0.0\/0 md5/' /var/lib/pgsql/data/pg_hba.conf

# Restart the PostgreSQL service
sudo systemctl restart postgresql