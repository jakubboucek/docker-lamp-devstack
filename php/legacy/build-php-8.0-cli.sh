#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 8.0
if [ "${NO_PULL:-0}" -ne "1" ]; then
    docker pull php:8.0-cli
    docker run --rm php:8.0-cli php --version
fi

if [ "${NO_BUILD:-0}" -ne "1" ]; then
    docker build --progress plain -f ./Dockerfile-8.0-cli -t jakubboucek/lamp-devstack-php:8.0-legacy-cli ../
fi

if [ "${NO_TEST:-0}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-php:8.0-legacy-cli php --version
    docker run --rm jakubboucek/lamp-devstack-php:8.0-legacy-cli php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:8.0-legacy-cli php -r "var_export(gd_info()) . PHP_EOL;"
fi

if [ "${NO_PUSH:-0}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-php:8.0-legacy-cli
fi
