#!/bin/bash

# shellcheck disable=SC2086
set -eux;

docker pull php:8.1-cli-trixie
docker pull php:8.1-apache-trixie
docker pull php:8.2-cli-trixie
docker pull php:8.2-apache-trixie
docker pull php:8.3-cli-trixie
docker pull php:8.3-apache-trixie
docker pull php:8.4-cli-trixie
docker pull php:8.4-apache-trixie
docker pull php:8.5-cli-trixie
docker pull php:8.5-apache-trixie

docker pull mariadb:10.6
docker pull mariadb:10.11
docker pull mariadb:11.4
docker pull mariadb:11.8
docker pull mariadb:12.0
docker pull mariadb:12.1
docker pull mariadb:12.2-rc
