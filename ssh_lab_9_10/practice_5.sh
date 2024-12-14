REMOTE_USER="username"          # Имя пользователя на удаленном сервере
REMOTE_HOST="remote_host"       # Адрес удаленного сервера
LOCAL_DIR="/path/to/local/directory"    # Локальная директория
REMOTE_DIR="/path/to/remote/directory"  # Удаленная директория
EMAIL="your_email@example.com"   # Email для уведомлений
EXCLUDE_PATTERN="*.tmp"          # Шаблон для игнорирования файлов (можно добавить другие)

# Синхронизация локальной директории с удаленной
rsync -avz --delete --exclude="$EXCLUDE_PATTERN" -e "ssh" "$LOCAL_DIR/" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/"

# Синхронизация удаленной директории с локальной
rsync -avz --delete --exclude="$EXCLUDE_PATTERN" -e "ssh" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/" "$LOCAL_DIR/"

# Отправка отчета по электронной почте
if [ $? -eq 0 ]; then
    echo "Синхронизация завершена успешно." | mail -s "Отчет о синхронизации" "$EMAIL"
else
    echo "Ошибка при синхронизации." | mail -s "Отчет о синхронизации" "$EMAIL"
fi

