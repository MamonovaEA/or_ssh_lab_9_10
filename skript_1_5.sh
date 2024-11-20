echo "Введите путь к директории:"
read dir_p

for file in "$dir_p"/*; do
	mv "$file" "$dir_p/backup_$ (basename "$file")"
done

echo "Все файлы переименованы"
