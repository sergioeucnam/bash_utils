#!/bin/bash

# Directory where backups will be stored
BACKUP_DIR="/var/backups"

# Filename for backups
BACKUP_FILENAME="mybackup"

# Log file
LOG_FILE="$BACKUP_DIR/$(date '+%Y-%m-%d_%H-%M-%S')-backup-resumen.log"

# Get the current username
USERNAME=$USER

# Check if backup directory exists, if not create it
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
fi

# Log start of backup process
echo "Starting backup process [$(date '+%Y-%m-%d %H:%M:%S')]" >> $LOG_FILE

# Create backup of installed packages for apt, snap, and flatpak
if [ -x "$(command -v apt)" ]; then
  echo "Creating backup of installed packages with apt [$(date '+%Y-%m-%d %H:%M:%S')]" >> $LOG_FILE
  apt list --installed > "$BACKUP_DIR/$BACKUP_FILENAME.$USERNAME.apt.packages.log" 2>&1
fi

if [ -x "$(command -v snap)" ]; then
  echo "Creating backup of installed packages with snap [$(date '+%Y-%m-%d %H:%M:%S')]" >> $LOG_FILE
  snap list > "$BACKUP_DIR/$BACKUP_FILENAME.$USERNAME.snap.packages.log" 2>&1
fi

if [ -x "$(command -v flatpak)" ]; then
  echo "Creating backup of installed packages with flatpak [$(date '+%Y-%m-%d %H:%M:%S')]" >> $LOG_FILE
  flatpak list > "$BACKUP_DIR/$BACKUP_FILENAME.$USERNAME.flatpak.packages.log" 2>&1
fi

# Create backup of user crontabs
echo "Creating backup of user crontabs [$(date '+%Y-%m-%d %H:%M:%S')]" >> $LOG_FILE
for user in $(cut -f1 -d: /etc/passwd); do
  crontab -u "$user" -l > "$BACKUP_DIR/$BACKUP_FILENAME.$user.cron" 2>&1
done

# Create backup of home directory for the current user
echo "Creating backup of home directory for user $USERNAME [$(date '+%Y-%m-%d %H:%M:%S')]" >> $LOG_FILE
tar -czf "$BACKUP_DIR/$BACKUP_FILENAME.$USERNAME.home.tar.gz" --exclude='node_modules/*' "/home/$USERNAME/" 2>&1

# Log end of backup process
echo "Backup process completed [$(date '+%Y-%m-%d %H:%M:%S')]" >> $LOG_FILE
