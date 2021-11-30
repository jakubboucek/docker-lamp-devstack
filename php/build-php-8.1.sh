#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 8.1
docker pull php:8.1-apache-buster
docker run --rm php:8.1-apache-buster php --version
docker build --progress plain -f ./Dockerfile-8.1 -t jakubboucek/lamp-devstack-php:8.1 ./
docker build --progress plain -f ./Dockerfile-8.1-debug -t jakubboucek/lamp-devstack-php:8.1-debug ./
docker run --rm jakubboucek/lamp-devstack-php:8.1 php --version
docker run --rm jakubboucek/lamp-devstack-php:8.1-debug php --version
docker run --rm jakubboucek/lamp-devstack-php:8.1 php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
docker run --rm jakubboucek/lamp-devstack-php:8.1 php -r "var_export(gd_info()) . PHP_EOL;"
PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.1 php -r "echo PHP_RELEASE_VERSION;")
docker tag jakubboucek/lamp-devstack-php:8.1 jakubboucek/lamp-devstack-php:8
docker tag jakubboucek/lamp-devstack-php:8.1 jakubboucek/lamp-devstack-php:latest
docker tag jakubboucek/lamp-devstack-php:8.1 jakubboucek/lamp-devstack-php:8.1.${PHP_RELEASE}
docker tag jakubboucek/lamp-devstack-php:8.1-debug jakubboucek/lamp-devstack-php:debug
docker tag jakubboucek/lamp-devstack-php:8.1-debug jakubboucek/lamp-devstack-php:8-debug
docker tag jakubboucek/lamp-devstack-php:8.1-debug jakubboucek/lamp-devstack-php:8.1.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:8.1.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:8.1-debug
docker push jakubboucek/lamp-devstack-php:8-debug
docker push jakubboucek/lamp-devstack-php:debug
docker push jakubboucek/lamp-devstack-php:8.1.${PHP_RELEASE}
docker push jakubboucek/lamp-devstack-php:8.1
docker push jakubboucek/lamp-devstack-php:8
docker push jakubboucek/lamp-devstack-php:latest
