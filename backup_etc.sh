#!/bin/bash

# تعریف مسیرها
SOURCE="/etc"
DEST="/var/lib/jenkins/backups02"

# ساخت نام فایل بکاپ با تاریخ و ساعت
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
FILENAME="etc_backup_$DATE.tar.gz"

# چک کردن وجود پوشه بکاپ
if [ ! -d "$DEST" ]; then
    mkdir -p "$DEST"
fi

# حذف بکاپ‌های قدیمی‌تر از 7 روز
find "$DEST" -name "etc_backup_*.tar.gz" -type f -mtime +7 -exec rm {} \;

# اجرای بکاپ با tar
sudo tar -czf "$DEST/$FILENAME" "$SOURCE"

# بررسی موفقیت عملیات
if [ $? -eq 0 ]; then
    echo "Backup successful: $DEST/$FILENAME"
else
    echo "Backup failed!"
    exit 1
fi
