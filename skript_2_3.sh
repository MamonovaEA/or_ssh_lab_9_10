echo "Введите длину пароля:"
read lenght

bute_lenght=$((($lenght*3+3)/4))

password=$(openssl rand -base64 $bute_length | cut -c1-$length)

echo "Ваш пароль: $password"
