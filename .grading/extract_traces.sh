#!/bin/bash

mkdir __traces__

echo "Extracting .trace files from ZIP archives..."
find . -type f -name "*.zip" | while read -r zip_file; do
    zip_name="$(basename "$zip_file" .zip)"
    folder_name="__traces__/${zip_name}"
    mkdir -p "$folder_name"
    unzip -o "$zip_file" -d "$folder_name" "*.trace"
done

TRACE_FILES=$(find __traces__ -type f -name "*.trace")

if [ -z "$TRACE_FILES" ]; then
    echo "No trace files were found."
    echo
    echo "This typically means that the tests did not run, or produced no traces."
    echo "Make sure to include the tracing=True option in each of your test files."
    echo "See the readme and example test files for more information."
    exit 1  # Error
fi

echo "These extracted files contain all the browser states and events that were"
echo "recorded during the tests. They will be used to verify that the tests"
echo "covered the expected scenarios and that the application behaved as intended."
