#!/bin/bash

set -eEo pipefail
IFS=$'\n\t'

# Script metadata
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_PID=$$

# Load configuration
readonly CONFIG_FILE="${SCRIPT_DIR}/config.env"
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"

# Logging setup
exec 3> >(logger -t "$SCRIPT_NAME")
readonly LOG_FD=3

log() {
  local level="$1"
  shift
  echo "[$(date -u +"%Y-%m-%dT%H:%M:%SZ")] [$level] [PID:$SCRIPT_PID] $*" >&$LOG_FD
  [[ "$level" == "ERROR" ]] && echo "[$(date -u +"%Y-%m-%dT%H:%M:%SZ")] [$level] $*" >&2
}

info() { log "INFO" "$@"; }
warn() { log "WARN" "$@"; }
error() { log "ERROR" "$@"; }

handle_error() {
  local exit_code=$?
  local line_number=$1

  error "Script failed at line $line_number with exit code $exit_code"
  error "Command: $BASH_COMMAND"
  error "Function: ${FUNCNAME[2]:-main}"

  # TODO: alert method

  exit $exit_code
}

trap 'handle_error $LINENO' ERR

# Validation
validate_prerequisites() {
  info "Validating prerequisites"

  # Check required commands
  local required_commands=("curl" "jq" "docker")
  for cmd in "${required_commands[@]}"; do
    if ! command -v "$cmd" >/dev/null; then
      error "Required command not found: $cmd"
      exit 1
    fi
  done

  # Check required environment variables
  local required_vars=("DEPLOY_ENV" "API_KEY")
  for var in "${required_vars[@]}"; do
    if [[ -z "${!var}" ]]; then
      error "Required environment variable not set: $var"
      exit 1
    fi
  done

  info "All prerequisites validated"
}

# Main function
main() {

  info "Starting $SCRIPT_NAME with action: $action"

  validate_prerequisites

  # TODO : write script

  info "Script completed successfully"
}

# Run main function
main "$@"
