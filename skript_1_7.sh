add() {
	local num1=$1
	local num2=$2
	local sum=$((num1 + num2))
	echo "Сумма $num1 и $num2 равна: $sum"
}

add "$1" "$2"
