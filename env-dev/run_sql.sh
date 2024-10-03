#!/bin/bash

# Directory where your versioned folders are stored
SOURCE_DIR="./"

# Loop through each SQL file in subdirectories of the SOURCE_DIR
find "$SOURCE_DIR" -type f -name '*.sql' | sort -V | while read sqlfile; do
    echo "$0: running $sqlfile"
    # Get the directory (folder) name and file name
    folder_name=$(basename "$(dirname "$sqlfile")")  # Extracts the folder name
    file_name=$(basename "$sqlfile")  # Extracts the file name

    # New filename format: folder-file-name.sql
    new_filename="${folder_name}-${file_name}"

    # Move the file to the SOURCE_DIR with the new name
    echo "newfile: $new_filename" 
    # cp "$sqlfile" "$SOURCE_DIR/$new_filename"
done
