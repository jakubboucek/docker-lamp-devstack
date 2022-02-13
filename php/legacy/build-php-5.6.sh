#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 5.6
docker pull php:5.6-apache
docker run --rm php:5.6-apache php --version
# Origin image uses outdated schema1 manifest format - use DOCKER_BUILDKIT=0
DOCKER_BUILDKIT=0 docker build --progress plain -f ./Dockerfile-5.6 -t jakubboucek/lamp-devstack-php:5.6-legacy ../
DOCKER_BUILDKIT=0 docker build --progress plain -f ./Dockerfile-5.6-debug -t jakubboucek/lamp-devstack-php:5.6-legacy-debug ../
docker run --rm jakubboucek/lamp-devstack-php:5.6-legacy php --version
docker run --rm jakubboucek/lamp-devstack-php:5.6-legacy-debug php --version
docker run --rm jakubboucek/lamp-devstack-php:5.6-legacy php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
docker run --rm jakubboucek/lamp-devstack-php:5.6-legacy-debug php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
docker run --rm jakubboucek/lamp-devstack-php:5.6-legacy php -r "var_export(gd_info()) . PHP_EOL;"
docker push jakubboucek/lamp-devstack-php:5.6-legacy-debug
docker push jakubboucek/lamp-devstack-php:5.6-legacy
