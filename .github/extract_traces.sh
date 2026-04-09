#!/bin/bash

mkdir __traces__

echo "Extracting .trace files from ZIP archives..."
find . -type f -name "*.zip" | while read -r zip_file; do
    zip_name="$(basename "$zip_file" .zip)"
    folder_name="__traces__/${zip_name}"
    mkdir -p "$folder_name"
    unzip -o "$zip_file" -d "$folder_name" "*.trace"
done
