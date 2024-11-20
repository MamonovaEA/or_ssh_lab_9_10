for file in *; do
	if [ -f "$file" ]; then
		new_file=$(echo "$file" | tr '[:upper:]' '[:lower:]')
        	
		if [ "$file" != "$new_file" ]; then
			mv "$file" "$new_file"
		fi
	fi
done

echo "Переименовали на строчные буквы"
