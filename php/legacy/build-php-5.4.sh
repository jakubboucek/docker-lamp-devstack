#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 5.4
if [ "${NO_PULL:-0}" -ne "1" ]; then
    docker pull php:5.4-apache
    docker run --rm php:5.4-apache php --version
fi

if [ "${NO_BUILD:-0}" -ne "1" ]; then
    # Origin image uses outdated schema1 manifest format - use DOCKER_BUILDKIT=0
    DOCKER_BUILDKIT=0 docker build -f ./Dockerfile-5.4 -t jakubboucek/lamp-devstack-php:5.4-legacy ../
    DOCKER_BUILDKIT=0 docker build -f ./Dockerfile-5.4-fixed -t jakubboucek/lamp-devstack-php:5.4-legacy-fixed ../
    DOCKER_BUILDKIT=0 docker build -f ./Dockerfile-5.4-debug -t jakubboucek/lamp-devstack-php:5.4-legacy-debug ../
fi

if [ "${NO_TEST:-0}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-php:5.4-legacy php --version
    docker run --rm jakubboucek/lamp-devstack-php:5.4-legacy-fixed php --version
    docker run --rm jakubboucek/lamp-devstack-php:5.4-legacy-debug php --version
    docker run --rm jakubboucek/lamp-devstack-php:5.4-legacy-fixed php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:5.4-legacy-debug php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:5.4-legacy-fixed php -r "var_export(gd_info()) . PHP_EOL;"
fi

if [ "${NO_PUSH:-0}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-php:5.4-legacy-debug
    docker push jakubboucek/lamp-devstack-php:5.4-legacy-fixed
    docker push jakubboucek/lamp-devstack-php:5.4-legacy
fi
