#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 5.4
docker pull php:5.4-cli
docker run --rm php:5.4-cli php --version
# Origin image uses outdated schema1 manifest format - use DOCKER_BUILDKIT=0
DOCKER_BUILDKIT=0 docker build --progress plain -f ./Dockerfile-5.4-cli -t jakubboucek/lamp-devstack-php:5.4-legacy-cli ../
docker run --rm jakubboucek/lamp-devstack-php:5.4-legacy-cli php --version
docker run --rm jakubboucek/lamp-devstack-php:5.4-legacy-cli php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
docker run --rm jakubboucek/lamp-devstack-php:5.4-legacy-cli php -r "var_export(gd_info()) . PHP_EOL;"
docker push jakubboucek/lamp-devstack-php:5.4-legacy-cli
