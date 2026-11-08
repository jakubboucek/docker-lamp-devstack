#!/bin/bash

set -eu

PHP_IMAGES=(
    8.2-cli
    8.2
    8.2-debug
    8.3-cli
    8.3
    8.3-debug
    8.4-cli
    8.4
    8.4-debug
    8.5-cli
    8.5
    8.5-debug
    8.6-rc-cli
    8.6-rc
    8.6-rc-debug
)

for image in "${PHP_IMAGES[@]}"; do
    version=$(docker run --rm "jakubboucek/lamp-devstack-php:${image}" php -r 'echo PHP_VERSION;')
    printf '%s: %s\n' "$image" "$version"
done
