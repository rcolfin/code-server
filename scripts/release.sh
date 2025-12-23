#!/usr/bin/env bash

set -euo pipefail

function log() {
    >&2 echo "${*}"
}

# Get the current time in seconds since the epoch
CURRENT_TIME=$(date -u +%s)

# Fetch the `LAST_MODIFIED` field from the Docker registry API
LAST_MODIFIED=$(curl -s https://registry.hub.docker.com/v2/repositories/linuxserver/code-server | jq -r '.last_updated')

#LAST_MODIFIED="2024-12-15T15:31:18.725818Z"

# Convert `LAST_MODIFIED` to seconds since the epoch
LAST_MODIFIED_TIME=$(date -d "$LAST_MODIFIED" +%s)

log "CURRENT_TIME=${CURRENT_TIME}"
log "LAST_MODIFIED=${LAST_MODIFIED}"
log "LAST_MODIFIED_TIME=${LAST_MODIFIED_TIME}"

# Calculate the time difference in hours
TIME_DIFFERENCE=$(( (CURRENT_TIME - LAST_MODIFIED_TIME) / 3600 ))

# Check if the difference is within the last 12 hours
if [ $TIME_DIFFERENCE -le 12 ]; then
    log "The Docker image was updated within the last 12 hours."
    echo "true"
else
    log "The Docker image was NOT updated within the last 12 hours."
    echo "false"
fi
