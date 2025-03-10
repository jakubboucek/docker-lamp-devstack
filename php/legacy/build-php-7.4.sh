#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 7.4
if [ "${NO_PULL:-0}" -ne "1" ]; then
    docker pull php:7.4-apache
    docker run --rm php:7.4-apache php --version
fi

if [ "${NO_BUILD:-0}" -ne "1" ]; then
    docker build --progress plain -f ./Dockerfile-7.4 -t jakubboucek/lamp-devstack-php:7.4-legacy ../
    docker build --progress plain -f ./Dockerfile-7.4-debug -t jakubboucek/lamp-devstack-php:7.4-legacy-debug ../
fi

if [ "${NO_TEST:-0}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-php:7.4-legacy php --version
    docker run --rm jakubboucek/lamp-devstack-php:7.4-legacy-debug php --version
    docker run --rm jakubboucek/lamp-devstack-php:7.4-legacy php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:7.4-legacy-debug php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:7.4-legacy php -r "var_export(gd_info()) . PHP_EOL;"
fi

if [ "${NO_PUSH:-0}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-php:7.4-legacy-debug
    docker push jakubboucek/lamp-devstack-php:7.4-legacy
fi
