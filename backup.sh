#!/usr/bin/env bash 

set -euo pipefail

timestamp=$(date "+%Y-%m-%d|%H:%M:%S")
SOURCE_DIR="${1:-$HOME/Documents}"
BACKUP_DIR="$HOME/Backup"
BACKUP_FILE="$BACKUP_DIR/backup_[$timestamp].tar.gz"
LOG_FILE="$HOME/backup.log"
KEEP=7

# making backup dir
mkdir -p "$BACKUP_DIR" 2> /dev/null

#backing up source dir
backup(){
if [[ ! -d $SOURCE_DIR ]]; then
      echo "[$timestamp]ERR: Source Dir [$SOURCE_DIR] dosen't exsist" >> "$LOG_FILE" 
      exit 1
fi

if tar -czf "$BACKUP_FILE" "$SOURCE_DIR" 2> /dev/null; then
      echo "[$timestamp] -Backup [$SOURCE_DIR] succeeded: $BACKUP_FILE" >> "$LOG_FILE"  
else 
      rm -f "$BACKUP_FILE"
      echo "[$timestamp] -Backup FAILED for $SOURCE_DIR" >> "$LOG_FILE"
      exit 1 
fi
}

# Keep only last 7 backups
cleaning(){
ls -1t "$BACKUP_DIR"/*.tar.gz 2> /dev/null | tail -n +$((KEEP+1)) | while read -r old; do
rm -f "$old" 
echo "[$timestamp] -Deleted old backup: $old" >> "$LOG_FILE"
done
}

backup
cleaning
