echo "Укажите имя файла:"
read flename
echo "Укажите слово:"
read word

count=$(grep -o "\$word\b" "$filename" | wc -l)

echo "Слово '$word' встречается в файле '$filename': $count раз."
