#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 8.2
if [ "${NO_PULL:-0}" -ne "1" ]; then
    docker pull php:8.2-rc-apache-bullseye
    docker run --rm php:8.2-rc-apache-bullseye php --version
fi

if [ "${NO_BUILD:-0}" -ne "1" ]; then
    docker build --progress plain -f ./Dockerfile-8.2 -t jakubboucek/lamp-devstack-php:8.2-rc ./
    docker build --progress plain -f ./Dockerfile-8.2-debug -t jakubboucek/lamp-devstack-php:8.2-rc-debug ./
    PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.2-rc php -r "echo PHP_RELEASE_VERSION;")
    PHP_RELEASE_EXTRA=$(docker run --rm jakubboucek/lamp-devstack-php:8.2-rc php -r "echo PHP_EXTRA_VERSION;")
    docker tag jakubboucek/lamp-devstack-php:8.2-rc jakubboucek/lamp-devstack-php:8.2.${PHP_RELEASE}-rc
    docker tag jakubboucek/lamp-devstack-php:8.2-rc jakubboucek/lamp-devstack-php:8.2.${PHP_RELEASE}-rc-${PHP_RELEASE_EXTRA}
    docker tag jakubboucek/lamp-devstack-php:8.2-rc-debug jakubboucek/lamp-devstack-php:8.2.${PHP_RELEASE}-rc-debug
    docker tag jakubboucek/lamp-devstack-php:8.2-rc-debug jakubboucek/lamp-devstack-php:8.2.${PHP_RELEASE}-rc-debug-${PHP_RELEASE_EXTRA}
fi

if [ "${NO_TEST:-0}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-php:8.2-rc php --version
    docker run --rm jakubboucek/lamp-devstack-php:8.2-rc-debug php --version
    docker run --rm jakubboucek/lamp-devstack-php:8.2-rc php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:8.2-rc-debug php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:8.2-rc php -r "var_export(gd_info()) . PHP_EOL;"
fi

if [ "${NO_PUSH:-0}" -ne "1" ]; then
    PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.2-rc php -r "echo PHP_RELEASE_VERSION;")
    PHP_RELEASE_EXTRA=$(docker run --rm jakubboucek/lamp-devstack-php:8.2-rc php -r "echo PHP_EXTRA_VERSION;")
    docker push jakubboucek/lamp-devstack-php:8.2.${PHP_RELEASE}-rc-debug-${PHP_RELEASE_EXTRA}
    docker push jakubboucek/lamp-devstack-php:8.2.${PHP_RELEASE}-rc-debug
    docker push jakubboucek/lamp-devstack-php:8.2-rc-debug
    docker push jakubboucek/lamp-devstack-php:8.2.${PHP_RELEASE}-rc-${PHP_RELEASE_EXTRA}
    docker push jakubboucek/lamp-devstack-php:8.2.${PHP_RELEASE}-rc
    docker push jakubboucek/lamp-devstack-php:8.2-rc
fi
