#!/bin/bash

# Variables
timestamp=$(date +%Y%m%d%H%M%S)
backup_file="/$HOME/superset/20230615111337.tar"
#backup_file="/$HOME/billingcenter.sql"
log_file="/$HOME/superset/fileRestore.log"
database_name='database_name'
database_user='database_user'
database_password='database_password'

# Restore command
restore_command="pg_restore -U $database_user -w -d $database_name -c $backup_file"

# Restore database and log the process
echo "Starting database restore..."
echo "Restore command: $restore_command" >> "$log_file"
echo "Restore started at $(date)" >> "$log_file"

# Execute the restore command and capture the output
output=$($restore_command 2>&1)

# Log the output
echo "Restore output:" >> "$log_file"
echo "$output" >> "$log_file"

# Check if the restore command was successful
if [ $? -eq 0 ]; then
    echo "Database restore completed successfully."
    echo "Restore completed at $(date)" >> "$log_file"
else
    echo "Error: Database restore failed."
    echo "Restore failed at $(date)" >> "$log_file"
fi