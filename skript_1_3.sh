echo "Введите путь к директории:"
read dir_path

if [[ ! -d "$dir_path" ]]; then
	
	echo "Указанная директория не существует!"
	exit 1
fi

current_date=$(date +%Y-%m-%d)

archiv_name="${dir_path##/}_$current_date.tar.gz"

tar -czf "$archiv_name" -C "$(dirname "$dir_path")" "${dir_path##/}"

echo "Архив $archiv_name был успешно создан."
