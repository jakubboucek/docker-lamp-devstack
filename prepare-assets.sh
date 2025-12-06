#!/bin/bash

# shellcheck disable=SC2086
set -eux;

cd "$(dirname $0)";

mkdir -p php/build

curl -fL https://github.com/php/pie/releases/latest/download/pie.phar -o php/build/pie.phar

# Check that PHP is available
if ! command -v php >/dev/null 2>&1; then
    echo "Error: PHP is not installed or not in PATH." >&2
    exit 1
fi

# Check that the PHAR file was downloaded successfully and is not empty
if [ ! -s php/build/pie.phar ]; then
    echo "Error: Failed to download pie.phar or file is empty." >&2
    exit 1
fi

# Compress the PHAR file to reduce its size
php -d phar.readonly=0 -r "
\$phar = new Phar('php/build/pie.phar');
\$phar->compressFiles(Phar::GZ);
" || { echo "Error: PHP compression step failed." >&2; exit 1; }

chmod +x php/build/pie.phar
