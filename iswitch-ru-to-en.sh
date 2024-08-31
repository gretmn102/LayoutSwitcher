#!/bin/bash

temp_file=$(mktemp)

nano "$temp_file"

content=$(<"$temp_file")
rm "$temp_file"

./switch-ru-to-en.sh "$content"
