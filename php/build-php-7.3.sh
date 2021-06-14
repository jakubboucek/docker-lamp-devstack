#!/bin/bash

# shellcheck disable=SC2086
set -eux;

### PHP 7.3
docker pull php:7.3-apache
docker run --rm php:7.3-apache php --version
docker build --progress plain -f php/Dockerfile-7.3 -t jakubboucek/lamp-devstack-php:7.3 php/
docker build --progress plain -f php/Dockerfile-7.3-debug -t jakubboucek/lamp-devstack-php:7.3-debug php/
docker run --rm jakubboucek/lamp-devstack-php:7.3 php --version
docker run --rm jakubboucek/lamp-devstack-php:7.3-debug php --version
docker run --rm jakubboucek/lamp-devstack-php:7.3 php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
docker run --rm jakubboucek/lamp-devstack-php:7.3 php -r "var_export(gd_info()) . PHP_EOL;"
PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:7.3 php -r "echo PHP_RELEASE_VERSION;")
docker tag jakubboucek/lamp-devstack-php:7.3 jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}
docker tag jakubboucek/lamp-devstack-php:7.3-debug jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:7.3-debug
docker push jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}
docker push jakubboucek/lamp-devstack-php:7.3
