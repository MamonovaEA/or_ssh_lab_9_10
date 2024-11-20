file_to_watch="$1"

last_checksum=$(md5sum "$file_to_watch" | cut -d ' ' -f 1)

while true; do
	sleep 2
	current_checksum=$(md5sum "$file_to_watch" | cut -d ' ' -f 1)

	if [ "$last_checksum" != "$current_checksum" ]; then
		echo "Файл '$file_to_watch' был изменен."
		last_checksum="$current_checksum"  
	fi
done
