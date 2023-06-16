#!/bin/bash

echo "[Input All Parameter]"
echo ""
read -p "Time Schedule (crontab format)  : " time
read -p "Database Name                   : " database_name
read -p "Database User                   : " database_user
read -s -p "Database Password               : " database_password
echo


sudo sed -i "s/database_name='database_name'/database_name='$database_name'/g" ./postgreBackup.sh
sudo sed -i "s/database_user='database_user'/database_user='$database_user'/g" ./postgreBackup.sh
sudo sed -i "s/database_password='database_password'/database_password='$database_password'/g" ./postgreBackup.sh

sudo chmod +x ./postgreBackup.sh
sudo mkdir $HOME/shell_startup
sudo cp ./postgreBackup.sh $HOME/shell_startup

echo "+++ INSERT AUTO BACKUP POSTGRESQL TO CRONJOB +++"
sudo crontab -l > cron_bkp
sudo echo "$time sync && sh -c $HOME/shell_startup/postgreBackup.sh" >> cron_bkp
sudo crontab cron_bkp
sudo rm cron_bkp

