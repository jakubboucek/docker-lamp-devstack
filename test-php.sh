#!/bin/bash

TAGS=(
    8.2 8.2-cli 8.2-debug
    8.3 8.3-cli 8.3-debug
    8.4 8.4-cli 8.4-debug
    8.5 8.5-cli 8.5-debug
    8.6-rc 8.6-rc-cli 8.6-rc-debug
)

set -ux

if [ "$#" -gt 1 ] || { [ "$#" -eq 1 ] && [ -z "$1" ]; }; then
    echo "Usage: $0 [tag]" >&2
    exit 2
fi

if [ "$#" -eq 1 ]; then
    TAGS=("$1")
fi

cd "$(dirname "$0")" || exit 1

if [ ! -f tools/vendor/autoload.php ]; then
    echo "Install test dependencies first: composer -d tools install" >&2
    exit 1
fi

status=0
for tag in "${TAGS[@]}"; do
    image="jakubboucek/lamp-devstack-php:$tag"
    if ! docker run --rm -v "$(pwd)":/app:ro -w /app \
        -e "DEVSTACK_IMAGE=$image" \
        "$image" composer -d tools/ test; then
        status=1
    fi
done

exit "$status"
