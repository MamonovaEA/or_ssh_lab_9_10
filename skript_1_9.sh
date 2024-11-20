echo "Введите команду:"
read u_command

$u_command &

pid=$!

echo "Команда '$u_command' запущена с PID: $pid"
