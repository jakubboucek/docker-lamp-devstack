#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 7.2
docker pull php:7.2-apache
docker run --rm php:7.2-apache php --version
docker build --progress plain -f ./Dockerfile-7.2 -t jakubboucek/lamp-devstack-php:7.2-legacy ../
docker build --progress plain -f ./Dockerfile-7.2-debug -t jakubboucek/lamp-devstack-php:7.2-legacy-debug ../
docker run --rm jakubboucek/lamp-devstack-php:7.2-legacy php --version
docker run --rm jakubboucek/lamp-devstack-php:7.2-legacy-debug php --version
docker run --rm jakubboucek/lamp-devstack-php:7.2-legacy php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
docker run --rm jakubboucek/lamp-devstack-php:7.2-legacy php -r "var_export(gd_info()) . PHP_EOL;"
docker push jakubboucek/lamp-devstack-php:7.2-legacy-debug
docker push jakubboucek/lamp-devstack-php:7.2-legacy
