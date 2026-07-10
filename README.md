# automated-backup-script
A bash script that automatically backs up DIRs on linux servers
## Features
- Compresses backups as .tar.gz with timestamp
- Accepts custom source dir as an argument
- Keeps only last 7 backups
- Logs all operations with timestamps
- validates source dir before backup

## Usage
# default 
./backup.sh  # backs up ~/Documents 
# custom
./backup.sh /path/to/dir

#use crontab -e for automation 
```bash
git clone https://github.com/m-adell/automated-backup-script.git 
cd automated-backup-script
chmod +x backup.sh
