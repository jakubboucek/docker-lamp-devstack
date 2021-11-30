#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 7.4
docker pull php:7.4-apache-bullseye
docker run --rm php:7.4-apache-bullseye php --version
docker build --progress plain -f ./Dockerfile-7.4 -t jakubboucek/lamp-devstack-php:7.4 ./
docker build --progress plain -f ./Dockerfile-7.4-debug -t jakubboucek/lamp-devstack-php:7.4-debug ./
docker run --rm jakubboucek/lamp-devstack-php:7.4 php --version
docker run --rm jakubboucek/lamp-devstack-php:7.4-debug php --version
docker run --rm jakubboucek/lamp-devstack-php:7.4 php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
docker run --rm jakubboucek/lamp-devstack-php:7.4 php -r "var_export(gd_info()) . PHP_EOL;"
PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:7.4 php -r "echo PHP_RELEASE_VERSION;")
docker tag jakubboucek/lamp-devstack-php:7.4 jakubboucek/lamp-devstack-php:7
docker tag jakubboucek/lamp-devstack-php:7.4 jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}
docker tag jakubboucek/lamp-devstack-php:7.4-debug jakubboucek/lamp-devstack-php:7-debug
docker tag jakubboucek/lamp-devstack-php:7.4-debug jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:7.4-debug
docker push jakubboucek/lamp-devstack-php:7-debug
docker push jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}
docker push jakubboucek/lamp-devstack-php:7.4
docker push jakubboucek/lamp-devstack-php:7
