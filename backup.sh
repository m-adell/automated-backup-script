#!/usr/bin/env bash 


timestamp=$(date "+%Y-%m-%d.%H:%M:%S")
SOURCE_DIR="$HOME/Documents"
BACKUP_DIR="$HOME/Backup"
BACKUP_FILE="$BACKUP_DIR/backup$timestamp.tar.gz"
LOG_FILE="$HOME/backup.log"
KEEP=7

mkdir -p "$BACKUP_DIR" 2> /dev/null

backup(){
tar -czf "$BACKUP_FILE" "$SOURCE_DIR" 2> /dev/null
if [[ $? -eq 0 ]]; then
      echo "[$timestamp] -Backup succeeded: $BACKUP_FILE" >> $LOG_FILE  
else 
      echo "[$timestamp] -Backup FAILED for $SOURCE_DIR" >> $LOG_FILE
fi
}

# Keep only last 7 backups
cleaning(){
cd "$BACKUP_DIR" || exit 
ls -1t "$BACKUP_DIR" 2> /dev/null | tail -n +$((KEEP+1)) | while read old; do
rm -f "$old" 
echo "[$timestamp] -Deleted old backup: $old" >> $LOG_FILE
done
}

backup
cleaning
