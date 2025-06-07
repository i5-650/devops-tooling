#!/bin/bash

handle_error() {
  local exit_code=$?
  local line_number=$1
  local command="$2"
  local function_name="${FUNCNAME[2]}"

  {
    echo "==============================================="
    echo "SCRIPT FAILURE REPORT"
    echo "==============================================="
    echo "Script: $0"
    echo "Function: ${function_name:-main}"
    echo "Line: $line_number"
    echo "Command: $command"
    echo "Exit Code: $exit_code"
    echo "Time: $(date)"
    echo "User: $(whoami)"
    echo "Working Directory: $(pwd)"
    echo "Environment: ${DEPLOY_ENV:-unknown}"
    echo ""
    echo "Recent Commands:"
    history | tail -5
    echo ""
    echo "System Info:"
    uname -a
    echo "Disk Space:"
    df -h
    echo "Memory:"
    free -h
    echo "==============================================="
  } >&2

  # Send to monitoring system
  send_alert "Script Failure" "Script $0 failed at line $line_number"

  exit $exit_code
}
