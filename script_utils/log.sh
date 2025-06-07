#!/bin/bash

log() {
  local level="$1"
  shift
  echo "[$(date -u +"%Y-%m-%dT%H:%M:%SZ")] [$level] [PID:$SCRIPT_PID] $*" >&$LOG_FD
  [[ "$level" == "ERROR" ]] && echo "[$(date -u +"%Y-%m-%dT%H:%M:%SZ")] [$level] $*" >&2
}

info() { log "INFO" "$@"; }
warn() { log "WARN" "$@"; }
error() { log "ERROR" "$@"; }
