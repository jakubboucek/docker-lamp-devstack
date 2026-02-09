#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

[ "${NO_PULL:-0}" -ne 1 ] && [ "${NO_ASSETS:-0}" -ne 1 ] && ../../prepare-assets.sh

export NO_ASSETS=1

# Disabled build is no more available to fetch because public Debian repositories shut down.
# ./build-php-5.4.sh
# ./build-php-5.4-cli.sh
# ./build-php-5.5.sh
# ./build-php-5.5-cli.sh
# ./build-php-5.6.sh
# ./build-php-5.6-cli.sh
# ./build-php-7.0.sh
# ./build-php-7.0-cli.sh
# ./build-php-7.1.sh
# ./build-php-7.1-cli.sh
# ./build-php-7.2.sh
# ./build-php-7.2-cli.sh
./build-php-7.3.sh
./build-php-7.3-cli.sh
./build-php-7.4.sh
./build-php-7.4-cli.sh
./build-php-8.0.sh
./build-php-8.0-cli.sh
./build-php-8.1.sh
./build-php-8.1-cli.sh
