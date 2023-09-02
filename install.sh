#!/bin/bash

# shellcheck disable=SC2086
set -eu;

# This script copy docker-compose.yml from this project to current directory
# Call this script from your's project diorectory to simple install LAMP server

SOURCE_DIR="$(dirname $0)";

cp $SOURCE_DIR/docker-compose.yml ./docker-compose.yml
