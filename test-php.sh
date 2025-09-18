#!/bin/bash

# shellcheck disable=SC2086
set -ux;

cd "$(dirname $0)";

docker run --rm -it -v "$(pwd)":/app -w /app jakubboucek/lamp-devstack-php:8.1 composer -d tools/ test;
docker run --rm -it -v "$(pwd)":/app -w /app jakubboucek/lamp-devstack-php:8.1-cli composer -d tools/ test;
docker run --rm -it -v "$(pwd)":/app -w /app jakubboucek/lamp-devstack-php:8.2 composer -d tools/ test;
docker run --rm -it -v "$(pwd)":/app -w /app jakubboucek/lamp-devstack-php:8.2-cli composer -d tools/ test;
docker run --rm -it -v "$(pwd)":/app -w /app jakubboucek/lamp-devstack-php:8.3 composer -d tools/ test;
docker run --rm -it -v "$(pwd)":/app -w /app jakubboucek/lamp-devstack-php:8.3-cli composer -d tools/ test;
docker run --rm -it -v "$(pwd)":/app -w /app jakubboucek/lamp-devstack-php:8.4 composer -d tools/ test;
docker run --rm -it -v "$(pwd)":/app -w /app jakubboucek/lamp-devstack-php:8.4-cli composer -d tools/ test;
docker run --rm -it -v "$(pwd)":/app -w /app jakubboucek/lamp-devstack-php:8.5-rc composer -d tools/ test;
docker run --rm -it -v "$(pwd)":/app -w /app jakubboucek/lamp-devstack-php:8.5-rc-cli composer -d tools/ test;
