REMOTE_USER="username"        # Имя пользователя на удаленном сервере
REMOTE_HOST="remote_host"     # Адрес удаленного сервера
REMOTE_DIR="/path/to/remote/directory"  # Директория для архивирования на удаленном сервере
LOCAL_DIR="/path/to/local/directory"    # Директория для сохранения архива на локальной машине
ARCHIVE_NAME="archive.tar.gz"  # Имя создаваемого архива

# 1. Подключаемся к удалённому серверу и архивируем указанную директорию
ssh ${REMOTE_USER}@${REMOTE_HOST} "tar -czf ${ARCHIVE_NAME} -C ${REMOTE_DIR} ."

# 2. Скачиваем созданный архив на локальную машину
scp ${REMOTE_USER}@${REMOTE_HOST}:${ARCHIVE_NAME} ${LOCAL_DIR}

# 3. Разархивируем архив на локальной машине
tar -xzf ${LOCAL_DIR}/${ARCHIVE_NAME} -C ${LOCAL_DIR}

# Удаление архива на удаленном сервере (опционально)
ssh ${REMOTE_USER}@${REMOTE_HOST} "rm ${ARCHIVE_NAME}"

echo "Архивирование, скачивание и разархивирование завершены."
