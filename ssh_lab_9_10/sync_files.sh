
LOCAL_DIR="/path/to/local/directory"       # Локальная директория
REMOTE_USER="username"                      # Имя пользователя на удаленном сервере
REMOTE_HOST="remote_host"                   # Адрес удаленного сервера
REMOTE_DIR="/path/to/remote/directory"      # Удаленная директория
EXCLUDE_FILE="exclude.txt"                  # Файл с шаблонами для исключения

# Создаем файл исключений, если он не существует
if [ ! -f "$EXCLUDE_FILE" ]; then
    echo "*.tmp" >> "$EXCLUDE_FILE"         # Исключить временные файлы
    echo "*.log" >> "$EXCLUDE_FILE"         # Исключить файлы журналов
    echo "cache/" >> "$EXCLUDE_FILE"        # Исключить директорию cache
fi

# 1. Синхронизация файлов с использованием rsync
rsync -avz --exclude-from="$EXCLUDE_FILE" -e ssh "$LOCAL_DIR/" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}"

echo "Синхронизация завершена."
