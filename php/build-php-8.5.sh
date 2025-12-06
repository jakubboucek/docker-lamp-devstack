#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 8.5
if [ "${NO_PULL:-0}" -ne "1" ]; then
    if [ "${NO_ASSETS:-0}" -ne "1" ]; then
        ../prepare-assets.sh
    fi

    docker pull php:8.5-apache-trixie
    docker run --rm php:8.5-apache-trixie php --version
fi

if [ "${NO_BUILD:-0}" -ne "1" ]; then
    docker build --progress plain -f ./Dockerfile-8.5 -t jakubboucek/lamp-devstack-php:8.5 ./
    docker build --progress plain -f ./Dockerfile-8.5-debug -t jakubboucek/lamp-devstack-php:8.5-debug ./
    PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.5 php -r "echo PHP_RELEASE_VERSION;")
    docker tag jakubboucek/lamp-devstack-php:8.5 jakubboucek/lamp-devstack-php:latest
    docker tag jakubboucek/lamp-devstack-php:8.5 jakubboucek/lamp-devstack-php:8
    docker tag jakubboucek/lamp-devstack-php:8.5 jakubboucek/lamp-devstack-php:8.5.${PHP_RELEASE}
    docker tag jakubboucek/lamp-devstack-php:8.5-debug jakubboucek/lamp-devstack-php:debug
    docker tag jakubboucek/lamp-devstack-php:8.5-debug jakubboucek/lamp-devstack-php:8-debug
    docker tag jakubboucek/lamp-devstack-php:8.5-debug jakubboucek/lamp-devstack-php:8.5.${PHP_RELEASE}-debug
fi

if [ "${NO_TEST:-0}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-php:8.5 php --version
    docker run --rm jakubboucek/lamp-devstack-php:8.5-debug php --version
    docker run --rm jakubboucek/lamp-devstack-php:8.5 php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:8.5-debug php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:8.5 php -r "var_export(gd_info()) . PHP_EOL;"
fi

if [ "${NO_PUSH:-0}" -ne "1" ]; then
    PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.5 php -r "echo PHP_RELEASE_VERSION;")
    docker push jakubboucek/lamp-devstack-php:8.5.${PHP_RELEASE}-debug
    docker push jakubboucek/lamp-devstack-php:8.5-debug
    docker push jakubboucek/lamp-devstack-php:8-debug
    docker push jakubboucek/lamp-devstack-php:debug
    docker push jakubboucek/lamp-devstack-php:8.5.${PHP_RELEASE}
    docker push jakubboucek/lamp-devstack-php:8.5
    docker push jakubboucek/lamp-devstack-php:8
    docker push jakubboucek/lamp-devstack-php:latest
fi
