#!/bin/bash

# Get a list of all databases, except for system databases
databases=$(mysql -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|mysql|sys)")

# Loop through each database and dump it to a separate file
for db in $databases; do
    echo "Dumping database: $db"
    mysqldump $db | gzip > "${db}.sql.gz"
    
    if [ $? -eq 0 ]; then
        echo "Successfully dumped $db"
    else
        echo "Failed to dump $db"
    fi
done

echo "All databases have been dumped."
