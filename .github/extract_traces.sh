#!/bin/bash
echo "Extracting .trace files from ZIP archives..."
find . -type f -name "*.zip" | while read -r zip_file; do
    folder_name="${zip_file%.zip}"
    mkdir -p "$folder_name"
    unzip -o "$zip_file" -d "$folder_name" "*.trace"
done