#!/bin/bash

sanitize_input() {
  local input="$1"
  local max_length="${2:-50}"

  # Remove anything that isn't alphanumeric, underscore, or dash
  input=$(echo "$input" | tr -cd '[:alnum:]_-')

  # Truncate to max length
  input="${input:0:$max_length}"

  # Ensure it's not empty after sanitization
  [[ -n "$input" ]] || {
    echo "Invalid input: contains illegal characters" >&2
    return 1
  }

  echo "$input"
}
