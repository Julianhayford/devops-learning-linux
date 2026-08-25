#!/bin/bash

set -euo pipefail

read -r -p "Enter source directory: " source_directory

if [[ -z $source_directory ]]; then
    echo "Error: No source directory was entered."
    exit 1
fi

if [[ ! -d $source_directory ]]; then
    echo "Error: Source directory '$source_directory' does not exist."
    exit 1
fi

timestamp=$(date +%F_%H-%M-%S)
backup_directory="backup_$timestamp"

mkdir -p "$backup_directory"
echo "Backup directory created: $backup_directory"
echo "Copying .txt files..."

shopt -s nullglob
text_files=("$source_directory"/*.txt)
file_count=${#text_files[@]}

if (( file_count > 0 )); then
    cp -- "${text_files[@]}" "$backup_directory/"
fi

echo "Backup complete! Files backed up: $file_count"