#!/bin/bash

set -eux

cd "$(dirname $0)";

NO_PULL=${NO_PULL:-0}
NO_BUILD=${NO_BUILD:-0}
NO_TEST=${NO_TEST:-0}
NO_PUSH=${NO_PUSH:-0}

### MariaDB - 10.3
MARIADB_RELEASE=39
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.3.${MARIADB_RELEASE}
    docker tag mariadb:10.3.${MARIADB_RELEASE} mariadb:10.3
    docker run --rm mariadb:10.3 mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.3 -t jakubboucek/lamp-devstack-mysql:10.3 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.3 jakubboucek/lamp-devstack-mysql:10.3.${MARIADB_RELEASE}
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.3 mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.3.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:10.3
fi


### MariaDB - 10.4
MARIADB_RELEASE=29
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.4.${MARIADB_RELEASE}
    docker tag mariadb:10.4.${MARIADB_RELEASE} mariadb:10.4
    docker run --rm mariadb:10.4 mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.4 -t jakubboucek/lamp-devstack-mysql:10.4 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.4 jakubboucek/lamp-devstack-mysql:10.4.${MARIADB_RELEASE}
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.4 mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.4.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:10.4
fi


### MariaDB - 10.5
MARIADB_RELEASE=20
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.5.${MARIADB_RELEASE}
    docker tag mariadb:10.5.${MARIADB_RELEASE} mariadb:10.5
    docker run --rm mariadb:10.5 mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.5 -t jakubboucek/lamp-devstack-mysql:10.5 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.5 jakubboucek/lamp-devstack-mysql:10.5.${MARIADB_RELEASE}
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.5 mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.5.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:10.5
fi


### MariaDB - 10.6
MARIADB_RELEASE=13
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.6.${MARIADB_RELEASE}
    docker tag mariadb:10.6.${MARIADB_RELEASE} mariadb:10.6
    docker run --rm mariadb:10.6 mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.6 -t jakubboucek/lamp-devstack-mysql:10.6 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:lts
    docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:10-lts
    docker tag jakubboucek/lamp-devstack-mysql:10.6 jakubboucek/lamp-devstack-mysql:10.6.${MARIADB_RELEASE}
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.6 mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.6.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:10.6
    docker push jakubboucek/lamp-devstack-mysql:10-lts
    docker push jakubboucek/lamp-devstack-mysql:lts
fi


### MariaDB - 10.8
MARIADB_RELEASE=8
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.8.${MARIADB_RELEASE}
    docker tag mariadb:10.8.${MARIADB_RELEASE} mariadb:10.8
    docker run --rm mariadb:10.8 mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.8 -t jakubboucek/lamp-devstack-mysql:10.8 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.8 jakubboucek/lamp-devstack-mysql:10.8.${MARIADB_RELEASE}
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.8 mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.8.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:10.8
fi


### MariaDB - 10.9
MARIADB_RELEASE=6
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.9.${MARIADB_RELEASE}
    docker tag mariadb:10.9.${MARIADB_RELEASE} mariadb:10.9
    docker run --rm mariadb:10.9 mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.9 -t jakubboucek/lamp-devstack-mysql:10.9 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.9 jakubboucek/lamp-devstack-mysql:10.9.${MARIADB_RELEASE}
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.9 mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.9.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:10.9
fi


### MariaDB - 10.10
MARIADB_RELEASE=4
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.10.${MARIADB_RELEASE}
    docker tag mariadb:10.10.${MARIADB_RELEASE} mariadb:10.10
    docker run --rm mariadb:10.10 mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.10 -t jakubboucek/lamp-devstack-mysql:10.10 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.10 jakubboucek/lamp-devstack-mysql:10.10.${MARIADB_RELEASE}
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.10 mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.10.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:10.10
fi

### MariaDB - 10.11
MARIADB_RELEASE=3
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.11.${MARIADB_RELEASE}
    docker tag mariadb:10.11.${MARIADB_RELEASE} mariadb:10.11
    docker run --rm mariadb:10.11 mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.11 -t jakubboucek/lamp-devstack-mysql:10.11 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.11 jakubboucek/lamp-devstack-mysql:latest
    docker tag jakubboucek/lamp-devstack-mysql:10.11 jakubboucek/lamp-devstack-mysql:10
    docker tag jakubboucek/lamp-devstack-mysql:10.11 jakubboucek/lamp-devstack-mysql:10.11.${MARIADB_RELEASE}
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.11 mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.11.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:10.11
    docker push jakubboucek/lamp-devstack-mysql:10
    docker push jakubboucek/lamp-devstack-mysql:latest
fi

### MariaDB - 11.0
MARIADB_RELEASE=1
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:11.0.${MARIADB_RELEASE}-rc
    docker tag mariadb:11.0.${MARIADB_RELEASE}-rc mariadb:11.0-rc
    docker run --rm mariadb:11.0-rc mariadb --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-11.0 -t jakubboucek/lamp-devstack-mysql:11.0-rc mysql/
    docker tag jakubboucek/lamp-devstack-mysql:11.0-rc jakubboucek/lamp-devstack-mysql:11.0.${MARIADB_RELEASE}-rc
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:11.0-rc mariadb --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:11.0.${MARIADB_RELEASE}-rc
    docker push jakubboucek/lamp-devstack-mysql:11.0-rc
fi
