#!/bin/bash

validate_environment() {
  local required_vars=(
    "DATABASE_URL"
    "API_KEY"
    "DEPLOY_ENV"
    "LOG_LEVEL"
  )

  local missing_vars=()

  for var in "${required_vars[@]}"; do
    if [[ -z "${!var}" ]]; then
      missing_vars+=("$var")
    fi
  done

  if [[ ${#missing_vars[@]} -gt 0 ]]; then
    echo "ERROR: Missing required environment variables:" >&2
    printf "  %s\n" "${missing_vars[@]}" >&2
    echo "Set these variables and try again." >&2
    exit 1
  fi
}
