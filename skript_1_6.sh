echo "Введите путь к директории:"
read dir_path

cd "$dir_path"

rm $file 

echo "Удаление файлов завершено."
