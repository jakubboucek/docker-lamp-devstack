#!/bin/bash

# shellcheck disable=SC2086
set -eux;

docker pull php:8.1-cli-bookworm
docker pull php:8.1-apache-bookworm
docker pull php:8.2-cli-bookworm
docker pull php:8.2-apache-bookworm
docker pull php:8.3-cli-bookworm
docker pull php:8.3-apache-bookworm
docker pull php:8.4-cli-bookworm
docker pull php:8.4-apache-bookworm
docker pull php:8.5-rc-cli-bookworm
docker pull php:8.5-rc-apache-bookworm

docker pull mariadb:10.6
docker pull mariadb:10.11
docker pull mariadb:11.4
docker pull mariadb:11.8
docker pull mariadb:12.0-rc
