disk_usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

if [ "$disk_usage" -gt 80 ]; then
    echo "Превышает 80%."
else
    echo "Все в порядке."
fi
