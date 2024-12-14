SOURCE_DIR="/path/to/source/directory"  # Директория для резервного копирования
BACKUP_DIR="/path/to/backup/directory"   # Локальная директория для временного хранения архивов
REMOTE_USER="username"                    # Имя пользователя на удаленном сервере
REMOTE_HOST="remote_host"                 # Адрес удаленного сервера
REMOTE_BACKUP_DIR="/path/to/remote/backup/directory"  # Удаленная директория для хранения архивов
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")       # Текущая дата и время
ARCHIVE_NAME="backup_$TIMESTAMP.tar.gz"   # Имя архива

# 1. Создание архива
tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" -C "$SOURCE_DIR" .

# 2. Копирование архива на удалённый сервер
scp "$BACKUP_DIR/$ARCHIVE_NAME" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_BACKUP_DIR}"

# 3. Удаление старых архивов на удалённом сервере
ssh "${REMOTE_USER}@${REMOTE_HOST}" "cd ${REMOTE_BACKUP_DIR} && ls -t | tail -n +4 | xargs -I {} rm -- {}"

echo "Резервное копирование завершено. Архив $ARCHIVE_NAME успешно скопирован на удалённый сервер."