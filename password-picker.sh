#!/bin/bash

database_file="$1"

script_path=$(readlink "$0")
if [ -z "$script_path" ]; then
    script_path="$0"
fi

password_picker_dir=$(dirname "$script_path")
password_prompt_command="zenity --password --text 'master password:' --title 'Master Password' 2>/dev/null"
bad_password_alert="zenity --error --text 'bad password or no entries' --title 'Error' 2>/dev/null"

# $password will be the master password;
# make sure to use quotes around it
list_command='$password_picker_dir/keepass-client -l "$database_file" "$password"'
# $password will be the master password, $entry will be the name of the entry;
# make sure to use quotes around them
grab_command='$password_picker_dir/keepass-client "$database_file" "$password" -g "$entry"'

password=$(eval $password_prompt_command)
if [ -z "$password" ]; then
    exit -1
fi

entries=$(eval $list_command)
if [ -z "$entries" ]; then
    eval $bad_password_alert
    exit -1
fi

entry=$(echo "$entries" | dmenu -i -l 10)
if [ -z "$entry" ]; then
    exit -1
fi

entry_password=$(eval $grab_command)
echo -n "$entry_password" | xclip -selection c

sleep 30

clipboard=$(xclip -out -selection c)
if [ "$clipboard" == "$entry_password" ]; then
    echo -n "" | xclip -selection c
fi
