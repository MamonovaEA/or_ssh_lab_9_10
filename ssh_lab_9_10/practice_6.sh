SERVER_LIST="servers.txt"         # Файл с перечнем серверов
COMMAND="your_command_here"        # Команда, которую нужно выполнить
LOG_FILE="command_output.log"      # Лог-файл для сохранения вывода команд

# Очистка лог-файла перед записью
> "$LOG_FILE"

# Чтение серверов из файла и выполнение команды
while IFS= read -r SERVER; do
    echo "Выполнение команды на сервере $SERVER..." | tee -a "$LOG_FILE"
    ssh "$SERVER" "$COMMAND" 2>&1 | tee -a "$LOG_FILE"
    echo "----------------------------------------" | tee -a "$LOG_FILE"
done < "$SERVER_LIST"

echo "Команды выполнены. Вывод сохранён в $LOG_FILE."

