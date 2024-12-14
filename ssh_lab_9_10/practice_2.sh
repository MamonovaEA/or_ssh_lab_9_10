REMOTE_USER="username"          # Имя пользователя на удаленном сервере
REMOTE_HOST="remote_host"       # Адрес удаленного сервера
EMAIL="your_email@example.com"   # Email для уведомлений
SSH_KEY="/path/to/your/private/key"  # Путь к вашему SSH-ключу (если используется)

# Подключение к удаленному серверу и выполнение команд
ssh -i "$SSH_KEY" "${REMOTE_USER}@${REMOTE_HOST}" << 'EOF'

# Проверка наличия обновлений
if [ -f /etc/debian_version ]; then
    # Для Debian/Ubuntu
    sudo apt update
    UPDATES=$(sudo apt list --upgradable 2>/dev/null | wc -l)
    if [ "$UPDATES" -gt 1 ]; then
        sudo apt upgrade -y
        REBOOT_REQUIRED=1
    fi
elif [ -f /etc/redhat-release ]; then
    # Для CentOS/RHEL
    sudo yum check-update
    UPDATES=$(sudo yum list updates | wc -l)
    if [ "$UPDATES" -gt 1 ]; then
        sudo yum -y update
        REBOOT_REQUIRED=1
    fi
else
    echo "Неизвестная операционная система"
    exit 1
fi

# Перезагрузка сервера, если это необходимо
if [ "$REBOOT_REQUIRED" ]; then
    sudo reboot
    echo "Сервер был перезагружен после обновления."
    echo "Сервер $HOSTNAME был перезагружен после установки обновлений." | mail -s "Уведомление о перезагрузке сервера" "$EMAIL"
else
    echo "Обновления не требуются. Сервер не перезагружен."
fi
EOF
