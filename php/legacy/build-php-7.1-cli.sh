#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 7.1
docker pull php:7.1-cli
docker run --rm php:7.1-cli php --version
docker build --progress plain -f ./Dockerfile-7.1-cli -t jakubboucek/lamp-devstack-php:7.1-legacy-cli ../
docker run --rm jakubboucek/lamp-devstack-php:7.1-legacy-cli php --version
docker run --rm jakubboucek/lamp-devstack-php:7.1-legacy-cli php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
docker run --rm jakubboucek/lamp-devstack-php:7.1-legacy-cli php -r "var_export(gd_info()) . PHP_EOL;"
docker push jakubboucek/lamp-devstack-php:7.1-legacy-cli
