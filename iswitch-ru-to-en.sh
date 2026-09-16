#!/bin/bash

set -euo pipefail

usage() {
  echo "Usage: $(basename "$0")"
  echo 'Программа создает временный файл и открывает его в `nano`. По выходу всё содержимое преобразовывается через `switch-ru-to-en` и выводится в консоль. Временный файл уничтожается.'
  echo
  echo "Where:"
  echo "-c            To clipboard"
  echo
  echo "Options:"
  echo "  --help, -h  Show this help."
  exit 1
}

to_clipboard=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    -c)
      to_clipboard=true
      shift
      ;;
    -*)
      echo "Error: Unknown option: $1" >&2
      echo "Type --help for details."
      exit 1
      ;;
    *)  # first non‑option argument -> start of positional args
      break
      ;;
  esac
done

temp_file=$(mktemp)

nano "$temp_file"

content=$(<"$temp_file")
rm "$temp_file"

result=$(switch-ru-to-en "$content")

if [ "$to_clipboard" = true ]; then
  termux-clipboard-set "$result"
  echo "Copied output to clipboard."
else
  echo "$result"
fi
