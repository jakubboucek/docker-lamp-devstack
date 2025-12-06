#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

[ "${NO_PULL:-0}" -ne 1 ] && [ "${NO_ASSETS:-0}" -ne 1 ] && ./prepare-assets.sh

export NO_ASSETS=1

./php/build-php-8.1-cli.sh
./php/build-php-8.1.sh
./php/build-php-8.2-cli.sh
./php/build-php-8.2.sh
./php/build-php-8.3-cli.sh
./php/build-php-8.3.sh
./php/build-php-8.4-cli.sh
./php/build-php-8.4.sh
./php/build-php-8.5-cli.sh
./php/build-php-8.5.sh
