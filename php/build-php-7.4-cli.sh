#!/bin/bash

# shellcheck disable=SC2086
set -eux;

### PHP 7.4
docker pull php:7.4-cli
docker run --rm php:7.4-cli php --version
docker build --progress plain -f php/Dockerfile-7.4-cli -t jakubboucek/lamp-devstack-php:7.4-cli php/
docker run --rm jakubboucek/lamp-devstack-php:7.4-cli php --version
docker run --rm jakubboucek/lamp-devstack-php:7.4-cli php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
docker run --rm jakubboucek/lamp-devstack-php:7.4-cli php -r "var_export(gd_info()) . PHP_EOL;"
PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:7.4-cli php -r "echo PHP_RELEASE_VERSION;")
docker tag jakubboucek/lamp-devstack-php:7.4-cli jakubboucek/lamp-devstack-php:7-cli
docker tag jakubboucek/lamp-devstack-php:7.4-cli jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}-cli
docker push jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}-cli
docker push jakubboucek/lamp-devstack-php:7.4-cli
docker push jakubboucek/lamp-devstack-php:7-cli
