#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 8.2
if [ "${NO_PULL:-0}" -ne "1" ]; then
    docker pull php:8.2-rc-cli-bullseye
    docker run --rm php:8.2-rc-cli-bullseye php --version
fi

if [ "${NO_BUILD:-0}" -ne "1" ]; then
    docker build --progress plain -f ./Dockerfile-8.2-cli -t jakubboucek/lamp-devstack-php:8.2-rc-cli ./
    PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.2-rc-cli php -r "echo PHP_RELEASE_VERSION;")
    PHP_RELEASE_EXTRA=$(docker run --rm jakubboucek/lamp-devstack-php:8.2-rc-cli php -r "echo PHP_EXTRA_VERSION;")
    docker tag jakubboucek/lamp-devstack-php:8.2-rc-cli jakubboucek/lamp-devstack-php:8.2.${PHP_RELEASE}-rc-cli
    docker tag jakubboucek/lamp-devstack-php:8.2-rc-cli jakubboucek/lamp-devstack-php:8.2.${PHP_RELEASE}-rc-${PHP_RELEASE_EXTRA}-cli
fi

if [ "${NO_TEST:-0}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-php:8.2-rc-cli php --version
    docker run --rm jakubboucek/lamp-devstack-php:8.2-rc-cli php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
    docker run --rm jakubboucek/lamp-devstack-php:8.2-rc-cli php -r "var_export(gd_info()) . PHP_EOL;"
fi

if [ "${NO_PUSH:-0}" -ne "1" ]; then
    PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.2-rc-cli php -r "echo PHP_RELEASE_VERSION;")
    PHP_RELEASE_EXTRA=$(docker run --rm jakubboucek/lamp-devstack-php:8.2-rc-cli php -r "echo PHP_EXTRA_VERSION;")
    docker push jakubboucek/lamp-devstack-php:8.2.${PHP_RELEASE}-rc-${PHP_RELEASE_EXTRA}-cli
    docker push jakubboucek/lamp-devstack-php:8.2.${PHP_RELEASE}-rc-cli
    docker push jakubboucek/lamp-devstack-php:8.2-rc-cli
fi
