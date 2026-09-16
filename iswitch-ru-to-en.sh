#!/bin/bash

set -euo pipefail

usage() {
  echo "Usage: $(basename "$0")"
  echo 'Программа создает временный файл и открывает его в `nano`. По выходу всё содержимое преобразовывается через `switch-ru-to-en` и выводится в консоль. Временный файл уничтожается.'
  echo
  echo "Where:"
  echo
  echo "Options:"
  echo "  --help, -h  Show this help."
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
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

switch-ru-to-en "$content"
