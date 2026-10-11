
#!/bin/bash

# Check root privileges
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root."
    exit 1
fi

# Directories to back up
SOURCES=(
    "/home/ec2-user/data"
    "/etc"
    "/boot"
    "/usr"
)

# Backup destination
BACKUP_DIR="/mnt/backup"

# Generate archive filename
HOST=$(hostname)
DATE=$(date +"%Y-%m-%d-%H-%M")
FILENAME="${HOST}-${DATE}.tgz"

# Check source directories
for DIR in "${SOURCES[@]}"; do
    if [[ ! -d "$DIR" ]]; then
        echo "Error: Source directory $DIR does not exist."
        exit 1
    fi
done

# Create backup directory
mkdir -p "$BACKUP_DIR" || exit 1

# Start backup
echo "Backup started: $(date)"

# Create compressed archive
if tar -czvf "$BACKUP_DIR/$FILENAME" "${SOURCES[@]}"; then
    echo "Backup completed successfully: $(date)"
else
    echo "Error: Backup failed."
    exit 1
fi

# Display backup files
ls -lh "$BACKUP_DIR"

exit 0

# CRON SETUP:
# sudo crontab -e
# */5 * * * * /bin/bash /home/ec2-user/backup.sh >> /var/log/backup.log 2>&1
