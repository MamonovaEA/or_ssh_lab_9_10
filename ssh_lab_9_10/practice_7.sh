REMOTE_USER="username"          # Имя пользователя на удаленном сервере
REMOTE_HOST="remote_host"       # Адрес удаленного сервера
LOAD_THRESHOLD=2.0              # Пороговая загрузка процессора
PROCESSES_TO_KILL=("process_name_1" "process_name_2")  # Массив процессов для завершения

# Проверка загрузки процессора на удаленном сервере
LOAD_AVG=$(ssh "$REMOTE_USER@$REMOTE_HOST" "uptime | awk -F'load average:' '{ print \\$2 }' | awk '{ print \\$1 }' | tr -d ','")
LOAD_AVG=$(echo "$LOAD_AVG" | awk '{printf "%.2f", \$1}')  # Форматируем до двух знаков после запятой

echo "Средняя загрузка на сервере $REMOTE_HOST: $LOAD_AVG"

# Сравнение средней загрузки с порогом
if (( $(echo "$LOAD_AVG > $LOAD_THRESHOLD" | bc -l) )); then
    echo "Загрузка превышает порог $LOAD_THRESHOLD. Завершаем процессы..."

    for PROCESS in "${PROCESSES_TO_KILL[@]}"; do
        # Получаем PID процессов
        PIDS=$(ssh "$REMOTE_USER@$REMOTE_HOST" "pgrep $PROCESS")
        
        if [ -n "$PIDS" ]; then
            echo "Завершение процессов $PROCESS с PID: $PIDS"
            ssh "$REMOTE_USER@$REMOTE_HOST" "kill $PIDS"
        else
            echo "Процесс $PROCESS не найден."
        fi
    done
else
    echo "Загрузка в пределах нормы. Никакие процессы не будут завершены."
fi

