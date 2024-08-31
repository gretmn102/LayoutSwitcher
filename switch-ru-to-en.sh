#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 'text'"
    exit 1
fi

input_text="$1"

en='`~!@#$%^&*()-_=+\|qwertyuiop[]asdfghjkl;'\''zxcvbnm,./QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?'
ru='ёЁ!"№;%:?*()-_=+\/йцукенгшщзхъфывапролджэячсмитьбю.ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,'

declare -A ru_to_eng_map
fill() {
    for ((i = 0; i < ${#ru}; i++)); do
        local ru_char="${ru:$i:1}"
        local en_char="${en:$i:1}"
        ru_to_eng_map["$ru_char"]="$en_char"
    done
}
fill

output_text=""
for ((i = 0; i < ${#input_text}; i++)); do
    char="${input_text:$i:1}"
    output_text+="${ru_to_eng_map[$char]:-$char}"
done

echo "$output_text"
