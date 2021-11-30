#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 8.1
docker pull php:8.1-cli-buster
docker run --rm php:8.1-cli-buster php --version
docker build --progress plain -f ./Dockerfile-8.1-cli -t jakubboucek/lamp-devstack-php:8.1-cli ./
docker run --rm jakubboucek/lamp-devstack-php:8.1-cli php --version
docker run --rm jakubboucek/lamp-devstack-php:8.1-cli php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
docker run --rm jakubboucek/lamp-devstack-php:8.1-cli php -r "var_export(gd_info()) . PHP_EOL;"
PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.1-cli php -r "echo PHP_RELEASE_VERSION;")
docker tag jakubboucek/lamp-devstack-php:8.1-cli jakubboucek/lamp-devstack-php:cli
docker tag jakubboucek/lamp-devstack-php:8.1-cli jakubboucek/lamp-devstack-php:8-cli
docker tag jakubboucek/lamp-devstack-php:8.1-cli jakubboucek/lamp-devstack-php:8.1.${PHP_RELEASE}-cli
docker push jakubboucek/lamp-devstack-php:8.1.${PHP_RELEASE}-cli
docker push jakubboucek/lamp-devstack-php:8.1-cli
docker push jakubboucek/lamp-devstack-php:8-cli
docker push jakubboucek/lamp-devstack-php:cli
