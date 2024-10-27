#!/bin/bash

# Define MySQL login credentials
USER="your_mysql_username"
PASSWORD="your_mysql_password"
HOST="your_mysql_host" # or localhost

# Get a list of all databases, except for system databases
databases=$(mysql -u $USER -p$PASSWORD -h $HOST -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|mysql|sys)")

# Loop through each database and dump it to a separate file
for db in $databases; do
    echo "Dumping database: $db"
    mysqldump -u $USER -p$PASSWORD -h $HOST $db | gzip > "${db}.sql.gz"
    
    if [ $? -eq 0 ]; then
        echo "Successfully dumped $db"
    else
        echo "Failed to dump $db"
    fi
done

echo "All databases have been dumped."
