#!/bin/bash

argLength=$#

validate_arguments() {
    if [ $argLength -ne 2 ]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
    fi
}

create_destination_directory() { 
    if [ ! -d "$from_dir" ]; then
        echo "Error: Source directory '$from_dir' not found."
        exit 1
    fi

    if [ ! -d "$to_dir" ]; then
        mkdir -p "$to_dir"
    fi
}

create_backup() {
    timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

    backup_filename="backup_$timestamp.tar.gz"

    tar -czf "$to_dir/$backup_filename" -C "$from_dir" .
}


confirm_backup() {
    if [ $? -eq 0 ]; then
    echo "Backup created successfully: $to_dir/$backup_filename"
    else
        echo "Error: Backup creation failed."
        exit 1
    fi
}


validate_arguments

from_dir="$1"
to_dir="$2"

create_destination_directory

create_backup

confirm_backup
