#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 8.0
docker pull php:8.0-apache-bullseye
docker run --rm php:8.0-apache-bullseye php --version
docker build --progress plain -f ./Dockerfile-8.0 -t jakubboucek/lamp-devstack-php:8.0 ./
docker build --progress plain -f ./Dockerfile-8.0-debug -t jakubboucek/lamp-devstack-php:8.0-debug ./
docker run --rm jakubboucek/lamp-devstack-php:8.0 php --version
docker run --rm jakubboucek/lamp-devstack-php:8.0-debug php --version
docker run --rm jakubboucek/lamp-devstack-php:8.0 php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
docker run --rm jakubboucek/lamp-devstack-php:8.0 php -r "var_export(gd_info()) . PHP_EOL;"
PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.0 php -r "echo PHP_RELEASE_VERSION;")
docker tag jakubboucek/lamp-devstack-php:8.0 jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}
docker tag jakubboucek/lamp-devstack-php:8.0-debug jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:8.0-debug
docker push jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}
docker push jakubboucek/lamp-devstack-php:8.0
