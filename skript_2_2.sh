echo "Введите первое число:"
read num1
echo "Введите второе число:"
read num2

if ((num1 > num2)); then
    echo "$num1 больше, чем $num2."
elif ((num1 < num2)); then
    echo "$num1 меньше, чем $num2."
else
    echo "$num1 и $num2 равны."
fi
