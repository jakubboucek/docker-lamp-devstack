#!/bin/bash

set -eux

cd "$(dirname $0)";

### MariaDB - 10.3
MARIADB_RELEASE=34
docker pull mariadb:10.3.${MARIADB_RELEASE}
docker tag mariadb:10.3.${MARIADB_RELEASE} mariadb:10.3
docker run --rm mariadb:10.3 mysql --version
docker build --progress plain -f mysql/Dockerfile-10.3 -t jakubboucek/lamp-devstack-mysql:10.3 mysql/
docker run --rm jakubboucek/lamp-devstack-mysql:10.3 mysql --version
docker tag jakubboucek/lamp-devstack-mysql:10.3 jakubboucek/lamp-devstack-mysql:10.3.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.3.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.3

### MariaDB - 10.4
MARIADB_RELEASE=24
docker pull mariadb:10.4.${MARIADB_RELEASE}
docker tag mariadb:10.4.${MARIADB_RELEASE} mariadb:10.4
docker run --rm mariadb:10.4 mysql --version
docker build --progress plain -f mysql/Dockerfile-10.4 -t jakubboucek/lamp-devstack-mysql:10.4 mysql/
docker run --rm jakubboucek/lamp-devstack-mysql:10.4 mysql --version
docker tag jakubboucek/lamp-devstack-mysql:10.4 jakubboucek/lamp-devstack-mysql:10.4.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.4.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.4

### MariaDB - 10.5
MARIADB_RELEASE=15
docker pull mariadb:10.5.${MARIADB_RELEASE}
docker tag mariadb:10.5.${MARIADB_RELEASE} mariadb:10.5
docker run --rm mariadb:10.5 mysql --version
docker build --progress plain -f mysql/Dockerfile-10.5 -t jakubboucek/lamp-devstack-mysql:10.5 mysql/
docker run --rm jakubboucek/lamp-devstack-mysql:10.5 mysql --version
docker tag jakubboucek/lamp-devstack-mysql:10.5 jakubboucek/lamp-devstack-mysql:10.5.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.5.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.5

### MariaDB - 10.6
MARIADB_RELEASE=7
docker pull mariadb:10.6.${MARIADB_RELEASE}
docker tag mariadb:10.6.${MARIADB_RELEASE} mariadb:10.6
docker run --rm mariadb:10.6 mysql --version
docker build --progress plain -f mysql/Dockerfile-10.6 -t jakubboucek/lamp-devstack-mysql:10.6 mysql/
docker run --rm jakubboucek/lamp-devstack-mysql:10.6 mysql --version
docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:lts
docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:10-lts
docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:10.6.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.6.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.6
docker push jakubboucek/lamp-devstack-mysql:10-lts
docker push jakubboucek/lamp-devstack-mysql:lts

### MariaDB - 10.7
MARIADB_RELEASE=3
docker pull mariadb:10.7.${MARIADB_RELEASE}
docker tag mariadb:10.7.${MARIADB_RELEASE} mariadb:10.7
docker run --rm mariadb:10.7 mysql --version
docker build --progress plain -f mysql/Dockerfile-10.7 -t jakubboucek/lamp-devstack-mysql:10.7 mysql/
docker run --rm jakubboucek/lamp-devstack-mysql:10.7 mysql --version
docker tag jakubboucek/lamp-devstack-mysql:10.7 jakubboucek/lamp-devstack-mysql:latest
docker tag jakubboucek/lamp-devstack-mysql:10.7 jakubboucek/lamp-devstack-mysql:10
docker tag jakubboucek/lamp-devstack-mysql:10.7 jakubboucek/lamp-devstack-mysql:10.7.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.7.${MARIADB_RELEASE}
docker push jakubboucek/lamp-devstack-mysql:10.7
docker push jakubboucek/lamp-devstack-mysql:10
docker push jakubboucek/lamp-devstack-mysql:latest

### MariaDB - 10.8
MARIADB_RELEASE=2
docker pull mariadb:10.8.${MARIADB_RELEASE}
docker tag mariadb:10.8.${MARIADB_RELEASE} mariadb:10.8
docker run --rm mariadb:10.8 mysql --version
docker build --progress plain -f mysql/Dockerfile-10.8 -t jakubboucek/lamp-devstack-mysql:10.8-rc mysql/
docker run --rm jakubboucek/lamp-devstack-mysql:10.8-rc mysql --version
docker tag jakubboucek/lamp-devstack-mysql:10.8-rc jakubboucek/lamp-devstack-mysql:10.8.${MARIADB_RELEASE}-rc
docker push jakubboucek/lamp-devstack-mysql:10.8.${MARIADB_RELEASE}-rc
docker push jakubboucek/lamp-devstack-mysql:10.8-rc
