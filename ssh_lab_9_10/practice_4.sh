REMOTE_USER="username"          # Имя пользователя на удаленном сервере
REMOTE_HOST="remote_host"       # Адрес удаленного сервера
EMAIL="your_email@example.com"   # Email для уведомлений
THRESHOLD=10                     # Пороговое значение свободного места в процентах

# Подключение к удаленному серверу и проверка свободного места
FREE_SPACE=$(ssh "${REMOTE_USER}@${REMOTE_HOST}" "df -h / | grep '/' | awk '{ print \\$5 }' | sed 's/%//g'")

# Сравнение свободного места с порогом
if [ "$FREE_SPACE" -gt "$THRESHOLD" ]; then
    echo "Внимание: свободное место на сервере $REMOTE_HOST составляет ${FREE_SPACE}%, что превышает порог в ${THRESHOLD}%." | mail -s "Уведомление о низком свободном месте на сервере" "$EMAIL"
fi
