#!/bin/bash

# Variables
timestamp=$(date +%Y%m%d%H%M%S)
backup_dir="/$HOME/superset" # outpunya akan .tar (konsepnya kaya zip jadi reduce size juga)
log_file="/$HOME/superset/postgreBackup.log"
database_name='database_name'
database_user='database_user'
database_password='database_password'

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Backup command
backup_command="pg_dump -U $database_user -w -F t -f $backup_dir/$database_name-$timestamp.tar $database_name"

# Backup database and log the process
echo "Starting database backup..."
echo "Backup command: $backup_command" >> "$log_file"
echo "Backup started at $(date)" >> "$log_file"

# Execute the backup command and capture the output
output=$($backup_command 2>&1)

# Log the output
echo "Backup output:" >> "$log_file"
echo "$output" >> "$log_file"

# Check if the backup command was successful
if [ $? -eq 0 ]; then
    echo "Database backup completed successfully."
    echo "Backup completed at $(date)" >> "$log_file"
else
    echo "Error: Database backup failed."
    echo "Backup failed at $(date)" >> "$log_file"
fi