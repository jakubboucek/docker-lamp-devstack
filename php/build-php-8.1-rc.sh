#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

### PHP 8.1-rc
docker pull php:8.1-rc-apache-buster
docker run --rm php:8.1-rc-apache-buster php --version
docker build --progress plain -f ./Dockerfile-8.1-rc -t jakubboucek/lamp-devstack-php:8.1-rc ./
docker run --rm jakubboucek/lamp-devstack-php:8.1-rc php --version
docker run --rm jakubboucek/lamp-devstack-php:8.1-rc php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
docker run --rm jakubboucek/lamp-devstack-php:8.1-rc php -r "var_export(gd_info()) . PHP_EOL;"
PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.1-rc php -r "echo PHP_RELEASE_VERSION . '-' . PHP_EXTRA_VERSION;")
docker tag jakubboucek/lamp-devstack-php:8.1-rc jakubboucek/lamp-devstack-php:8.1.${PHP_RELEASE}
docker push jakubboucek/lamp-devstack-php:8.1.${PHP_RELEASE}
docker push jakubboucek/lamp-devstack-php:8.1-rc
