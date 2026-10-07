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

echo "Traces found in the following folders:"
echo
echo "$TRACE_FILES" | xargs -n1 dirname | sort -u
echo
echo
echo "These files contain all the browser states and events that were recorded during"
echo "the tests. They will be used to verify that the tests covered the expected"
echo "scenarios and that the application behaved as intended."
