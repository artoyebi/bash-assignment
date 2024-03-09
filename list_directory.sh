#!/bin/bash

arg1=$1

arg2=$2

arg3=$3

entries=8

argLength=$#


directory=$arg2

validate_arguments() {
    if [ $argLength -lt 2 ]; then
        echo "Length of argument is less than 2."
        exit 1
    fi

    if [[ $arg1 == '-n' && $argLength -gt 2 && $arg2 =~ ^[0-9]+$ ]]
    then
        directory=$arg3
        entries=$arg2
    else
        directory=$arg2
    fi

    if [[ $arg1 == '-d' ]] 
    then
        directory=$arg2
    fi
}



validate_directory() {
    if [ -z $directory ]
        then
            echo "Please provide a directory"
            exit 1
    elif [ ! -d $directory ]
        then
            echo "The directory $directory does not exist"
            exit 1
    fi
}

get_directory_list_and_disk_usage() {
    sudo find $directory -type d -exec du -h --max-depth=1 {} \; | sort -rh | head -n $entries
}

list_directories_and_files() {
    sudo ls -l $directory
}

execute() {
    echo "Directory is $directory"
    if [ $arg1 == '-n' ]
        then
            echo "Top $entries entries for $directory disk usage"
            get_directory_list_and_disk_usage
    elif [ $arg1 == '-d' ]
        then
            list_directories_and_files
    else
        echo "Invalid argument"
        exit 1
    fi
}


validate_arguments

validate_directory

execute
