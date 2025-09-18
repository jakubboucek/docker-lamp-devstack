#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 8.1
if [ "${NO_PULL:-0}" -ne "1" ]; then
    docker pull php:8.1-apache-trixie
    docker run --rm php:8.1-apache-trixie php --version
fi

if [ "${NO_BUILD:-0}" -ne "1" ]; then
    docker build --progress plain -f ./Dockerfile-8.1 -t jakubboucek/lamp-devstack-php:8.1 ./
    docker build --progress plain -f ./Dockerfile-8.1-debug -t jakubboucek/lamp-devstack-php:8.1-debug ./
    PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.1 php -r "echo PHP_RELEASE_VERSION;")
    docker tag jakubboucek/lamp-devstack-php:8.1 jakubboucek/lamp-devstack-php:8.1.${PHP_RELEASE}
    docker tag jakubboucek/lamp-devstack-php:8.1-debug jakubboucek/lamp-devstack-php:8.1.${PHP_RELEASE}-debug
fi

if [ "${NO_TEST:-0}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-php:8.1 php --version
    docker run --rm jakubboucek/lamp-devstack-php:8.1-debug php --version
    docker run --rm jakubboucek/lamp-devstack-php:8.1 php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:8.1-debug php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:8.1 php -r "var_export(gd_info()) . PHP_EOL;"
fi

if [ "${NO_PUSH:-0}" -ne "1" ]; then
    PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.1 php -r "echo PHP_RELEASE_VERSION;")
    docker push jakubboucek/lamp-devstack-php:8.1.${PHP_RELEASE}-debug
    docker push jakubboucek/lamp-devstack-php:8.1-debug
    docker push jakubboucek/lamp-devstack-php:8.1.${PHP_RELEASE}
    docker push jakubboucek/lamp-devstack-php:8.1
fi
