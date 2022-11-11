#!/bin/bash

set -eux

cd "$(dirname $0)";

NO_PULL=${NO_PULL:-0}
NO_BUILD=${NO_BUILD:-0}
NO_TEST=${NO_TEST:-0}
NO_PUSH=${NO_PUSH:-0}

### MariaDB - 10.3
MARIADB_RELEASE=37
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
MARIADB_RELEASE=27
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
MARIADB_RELEASE=18
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
MARIADB_RELEASE=11
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


### MariaDB - 10.7
MARIADB_RELEASE=7
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.7.${MARIADB_RELEASE}
    docker tag mariadb:10.7.${MARIADB_RELEASE} mariadb:10.7
    docker run --rm mariadb:10.7 mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.7 -t jakubboucek/lamp-devstack-mysql:10.7 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.7 jakubboucek/lamp-devstack-mysql:10.7.${MARIADB_RELEASE}
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.7 mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.7.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:10.7
fi


### MariaDB - 10.8
MARIADB_RELEASE=6
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
MARIADB_RELEASE=4
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.9.${MARIADB_RELEASE}
    docker tag mariadb:10.9.${MARIADB_RELEASE} mariadb:10.9
    docker run --rm mariadb:10.9 mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.9 -t jakubboucek/lamp-devstack-mysql:10.9 mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.9 jakubboucek/lamp-devstack-mysql:latest
    docker tag jakubboucek/lamp-devstack-mysql:10.9 jakubboucek/lamp-devstack-mysql:10
    docker tag jakubboucek/lamp-devstack-mysql:10.9 jakubboucek/lamp-devstack-mysql:10.9.${MARIADB_RELEASE}
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.9 mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.9.${MARIADB_RELEASE}
    docker push jakubboucek/lamp-devstack-mysql:10.9
    docker push jakubboucek/lamp-devstack-mysql:10
    docker push jakubboucek/lamp-devstack-mysql:latest
fi


### MariaDB - 10.10
MARIADB_RELEASE=1
if [ "${NO_PULL}" -ne "1" ]; then
    docker pull mariadb:10.10.${MARIADB_RELEASE}-rc
    docker tag mariadb:10.10.${MARIADB_RELEASE}-rc mariadb:10.10-rc
    docker run --rm mariadb:10.10-rc mysql --version
fi

if [ "${NO_BUILD}" -ne "1" ]; then
    docker build --progress plain -f mysql/Dockerfile-10.10 -t jakubboucek/lamp-devstack-mysql:10.10-rc mysql/
    docker tag jakubboucek/lamp-devstack-mysql:10.10-rc jakubboucek/lamp-devstack-mysql:10.10.${MARIADB_RELEASE}-rc
fi

if [ "${NO_TEST}" -ne "1" ]; then
    docker run --rm jakubboucek/lamp-devstack-mysql:10.10-rc mysql --version
fi

if [ "${NO_PUSH}" -ne "1" ]; then
    docker push jakubboucek/lamp-devstack-mysql:10.10.${MARIADB_RELEASE}-rc
    docker push jakubboucek/lamp-devstack-mysql:10.10-rc
fi
