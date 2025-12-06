#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

mkdir -p php/build

curl -L https://github.com/php/pie/releases/latest/download/pie.phar -o php/build/pie.phar

# Compress the PHAR file to reduce its size
php -d phar.readonly=0 -r "
\$phar = new Phar('php/build/pie.phar');
\$phar->compressFiles(Phar::GZ);
"

chmod +x php/build/pie.phar
