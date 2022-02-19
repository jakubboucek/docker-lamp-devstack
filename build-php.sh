#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

./php/build-php-7.4-cli.sh
./php/build-php-7.4.sh
./php/build-php-8.0-cli.sh
./php/build-php-8.0.sh
./php/build-php-8.1-cli.sh
./php/build-php-8.1.sh
