REMOTE_USER="username"          # Имя пользователя на удаленном сервере
REMOTE_HOST="remote_host"       # Адрес удаленного сервера
REMOTE_DIR="/path/to/remote/directory"  # Директория для архивирования на удаленном сервере
LOCAL_DIR="/path/to/local/directory"    # Локальная директория для хранения архива
ARCHIVE_NAME="backup_$(date +%Y%m%d_%H%M%S).tar.gz"  # Имя архива с текущей датой и временем

# 1. Подключение к удаленному серверу и архивирование директории
ssh "${REMOTE_USER}@${REMOTE_HOST}" "tar -czf /tmp/$ARCHIVE_NAME -C $REMOTE_DIR ."

# 2. Скачивание архива на локальную машину
scp "${REMOTE_USER}@${REMOTE_HOST}:/tmp/$ARCHIVE_NAME" "$LOCAL_DIR"

# 3. Удаление архива на удаленном сервере
ssh "${REMOTE_USER}@${REMOTE_HOST}" "rm /tmp/$ARCHIVE_NAME"

# 4. Разархивирование скачанного архива
tar -xzf "$LOCAL_DIR/$ARCHIVE_NAME" -C "$LOCAL_DIR"

# 5. Сообщение о завершении
echo "Архивирование и скачивание завершено. Архив разархивирован в $LOCAL_DIR."

