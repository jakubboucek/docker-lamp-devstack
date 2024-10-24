#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 8.4-rc
if [ "${NO_PULL:-0}" -ne "1" ]; then
    docker pull php:8.4-rc-apache-bookworm
    docker run --rm php:8.4-rc-apache-bookworm php --version
fi

if [ "${NO_BUILD:-0}" -ne "1" ]; then
    docker build --progress plain -f ./Dockerfile-8.4 -t jakubboucek/lamp-devstack-php:8.4-rc ./
    docker build --progress plain -f ./Dockerfile-8.4-debug -t jakubboucek/lamp-devstack-php:8.4-rc-debug ./
    PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.4-rc php -r "echo PHP_RELEASE_VERSION;")
    PHP_RELEASE_EXTRA=$(docker run --rm jakubboucek/lamp-devstack-php:8.4-rc php -r "echo PHP_EXTRA_VERSION;")
#    docker tag jakubboucek/lamp-devstack-php:8.4-rc jakubboucek/lamp-devstack-php:8
#    docker tag jakubboucek/lamp-devstack-php:8.4-rc jakubboucek/lamp-devstack-php:latest
    docker tag jakubboucek/lamp-devstack-php:8.4-rc jakubboucek/lamp-devstack-php:8.4.${PHP_RELEASE}-rc
    docker tag jakubboucek/lamp-devstack-php:8.4-rc jakubboucek/lamp-devstack-php:8.4.${PHP_RELEASE}-rc-${PHP_RELEASE_EXTRA}
#    docker tag jakubboucek/lamp-devstack-php:8.4-rc-debug jakubboucek/lamp-devstack-php:debug
#    docker tag jakubboucek/lamp-devstack-php:8.4-rc-debug jakubboucek/lamp-devstack-php:8-debug
    docker tag jakubboucek/lamp-devstack-php:8.4-rc-debug jakubboucek/lamp-devstack-php:8.4.${PHP_RELEASE}-rc-debug
    docker tag jakubboucek/lamp-devstack-php:8.4-rc-debug jakubboucek/lamp-devstack-php:8.4.${PHP_RELEASE}-rc-debug-${PHP_RELEASE_EXTRA}
fi

if [ "${NO_TEST:-0}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-php:8.4-rc php --version
    docker run --rm jakubboucek/lamp-devstack-php:8.4-rc-debug php --version
    docker run --rm jakubboucek/lamp-devstack-php:8.4-rc php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:8.4-rc-debug php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:8.4-rc php -r "var_export(gd_info()) . PHP_EOL;"
fi

if [ "${NO_PUSH:-0}" -ne "1" ]; then
    PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.4-rc php -r "echo PHP_RELEASE_VERSION;")
    PHP_RELEASE_EXTRA=$(docker run --rm jakubboucek/lamp-devstack-php:8.4-rc php -r "echo PHP_EXTRA_VERSION;")
    docker push jakubboucek/lamp-devstack-php:8.4.${PHP_RELEASE}-rc-debug
    docker push jakubboucek/lamp-devstack-php:8.4-rc-debug
#    docker push jakubboucek/lamp-devstack-php:8-debug
#    docker push jakubboucek/lamp-devstack-php:debug
    docker push jakubboucek/lamp-devstack-php:8.4.${PHP_RELEASE}-rc-${PHP_RELEASE_EXTRA}
    docker push jakubboucek/lamp-devstack-php:8.4.${PHP_RELEASE}-rc
    docker push jakubboucek/lamp-devstack-php:8.4-rc
#    docker push jakubboucek/lamp-devstack-php:8
#    docker push jakubboucek/lamp-devstack-php:latest
fi
