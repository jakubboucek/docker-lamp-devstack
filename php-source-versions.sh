#!/bin/bash

set -eu

PHP_IMAGES=(
    8.2-cli-trixie
    8.2-apache-trixie
    8.3-cli-trixie
    8.3-apache-trixie
    8.4-cli-trixie
    8.4-apache-trixie
    8.5-cli-trixie
    8.5-apache-trixie
    8.6-rc-cli-trixie
    8.6-rc-apache-trixie
)

for image in "${PHP_IMAGES[@]}"; do
    version=$(docker run --rm "php:${image}" php -r 'echo PHP_VERSION;')
    printf '%s: %s\n' "$image" "$version"
done
