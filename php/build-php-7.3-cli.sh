#!/bin/bash

# shellcheck disable=SC2086
set -eux;

### PHP 7.3
docker pull php:7.3-cli-buster
docker run --rm php:7.3-cli-buster php --version
docker build --progress plain -f php/Dockerfile-7.3-cli -t jakubboucek/lamp-devstack-php:7.3-cli php/
docker run --rm jakubboucek/lamp-devstack-php:7.3-cli php --version
docker run --rm jakubboucek/lamp-devstack-php:7.3-cli php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
docker run --rm jakubboucek/lamp-devstack-php:7.3-cli php -r "var_export(gd_info()) . PHP_EOL;"
PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:7.3-cli php -r "echo PHP_RELEASE_VERSION;")
docker tag jakubboucek/lamp-devstack-php:7.3-cli jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}-cli
docker push jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}-cli
docker push jakubboucek/lamp-devstack-php:7.3-cli
