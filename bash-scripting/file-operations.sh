#!/bin/bash

set -euo pipefail

directory_name="bash_demo"
file_name="demo.txt"
current_date=$(date +%F)

mkdir -p "$directory_name"
echo "Directory '$directory_name' created."

cd "$directory_name"

echo "This file was created by a Bash script on $current_date" > "$file_name"
echo "File '$file_name' created."

echo "File contents:"
cat "$file_name"