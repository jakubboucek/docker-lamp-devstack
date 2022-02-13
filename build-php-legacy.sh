#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

./php/legacy/build-php-5.4.sh
./php/legacy/build-php-5.4-cli.sh
./php/legacy/build-php-5.5.sh
./php/legacy/build-php-5.5-cli.sh
./php/legacy/build-php-5.6.sh
./php/legacy/build-php-5.6-cli.sh
./php/legacy/build-php-7.0.sh
./php/legacy/build-php-7.0-cli.sh
./php/legacy/build-php-7.1.sh
./php/legacy/build-php-7.1-cli.sh
./php/legacy/build-php-7.2.sh
./php/legacy/build-php-7.2-cli.sh
