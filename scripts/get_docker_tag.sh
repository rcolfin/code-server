#!/usr/bin/env bash

set -euo pipefail

function log() {
    >&2 echo "${*}"
}

PLATFORM="linux/amd64"
IMAGE="lscr.io/linuxserver/code-server:latest"

docker pull --platform "${PLATFORM}" --quiet "${IMAGE}" >/dev/null

TAG=$(docker inspect "$IMAGE" | jq -r '.[0].Config.Labels | to_entries | last | .value')

log "TAG=${TAG}"

echo "$TAG"

[ -n "${GITHUB_ENV+x}" ] && echo "TAG=${TAG}" >> "${GITHUB_ENV}"
