#!/bin/bash

# shellcheck disable=SC2086
set -eux;

./php/build-php-7.3-cli.sh
./php/build-php-7.3.sh
./php/build-php-7.4-cli.sh
./php/build-php-7.4.sh
./php/build-php-8.0-cli.sh
./php/build-php-8.0.sh
./php/build-php-8.1-rc.sh
./php/build-php-8.1-rc-cli.sh
