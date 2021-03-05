# Building notes
Notes how to build new vestion of prepared images.

This note is not necessary for USE images, it's for BUILD him. 

### PHP 8.0
```shell
docker pull php:8.0-apache
docker run --rm php:8.0-apache php --version
docker build --progress plain --no-cache -f php/Dockerfile-8.0 -t jakubboucek/lamp-devstack-php:8.0 php/
docker build --progress plain --no-cache -f php/Dockerfile-8.0-debug -t jakubboucek/lamp-devstack-php:8.0-debug php/
docker run --rm jakubboucek/lamp-devstack-php:8.0 php --version
docker run --rm jakubboucek/lamp-devstack-php:8.0-debug php --version
PHP_RELEASE=`docker run --rm jakubboucek/lamp-devstack-php:8.0 php -r "echo PHP_RELEASE_VERSION;"`
docker tag jakubboucek/lamp-devstack-php:8.0 jakubboucek/lamp-devstack-php:latest
docker tag jakubboucek/lamp-devstack-php:8.0 jakubboucek/lamp-devstack-php:8
docker tag jakubboucek/lamp-devstack-php:8.0 jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}
docker tag jakubboucek/lamp-devstack-php:8.0-debug jakubboucek/lamp-devstack-php:debug
docker tag jakubboucek/lamp-devstack-php:8.0-debug jakubboucek/lamp-devstack-php:8-debug
docker tag jakubboucek/lamp-devstack-php:8.0-debug jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:latest
docker push jakubboucek/lamp-devstack-php:8
docker push jakubboucek/lamp-devstack-php:8.0
docker push jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}
docker push jakubboucek/lamp-devstack-php:debug
docker push jakubboucek/lamp-devstack-php:8-debug
docker push jakubboucek/lamp-devstack-php:8.0-debug
docker push jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}-debug
```

### PHP 7.4
```shell
docker pull php:7.4-apache
docker run --rm php:7.4-apache php --version
docker build --progress plain --no-cache -f php/Dockerfile-7.4 -t jakubboucek/lamp-devstack-php:7.4 php/
docker build --progress plain --no-cache -f php/Dockerfile-7.4-debug -t jakubboucek/lamp-devstack-php:7.4-debug php/
docker run --rm jakubboucek/lamp-devstack-php:7.4 php --version
docker run --rm jakubboucek/lamp-devstack-php:7.4-debug php --version
PHP_RELEASE=`docker run --rm jakubboucek/lamp-devstack-php:7.4 php -r "echo PHP_RELEASE_VERSION;"`
docker tag jakubboucek/lamp-devstack-php:7.4 jakubboucek/lamp-devstack-php:7
docker tag jakubboucek/lamp-devstack-php:7.4 jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}
docker tag jakubboucek/lamp-devstack-php:7.4-debug jakubboucek/lamp-devstack-php:7-debug
docker tag jakubboucek/lamp-devstack-php:7.4-debug jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:7
docker push jakubboucek/lamp-devstack-php:7.4
docker push jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}
docker push jakubboucek/lamp-devstack-php:7-debug
docker push jakubboucek/lamp-devstack-php:7.4-debug
docker push jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}-debug
```

### PHP 7.3
```shell
docker pull php:7.3-apache
docker run --rm php:7.3-apache php --version
docker build --progress plain --no-cache -f php/Dockerfile-7.3 -t jakubboucek/lamp-devstack-php:7.3 php/
docker build --progress plain --no-cache -f php/Dockerfile-7.3-debug -t jakubboucek/lamp-devstack-php:7.3-debug php/
docker run --rm jakubboucek/lamp-devstack-php:7.3 php --version
docker run --rm jakubboucek/lamp-devstack-php:7.3-debug php --version
PHP_RELEASE=`docker run --rm jakubboucek/lamp-devstack-php:7.3 php -r "echo PHP_RELEASE_VERSION;"`
docker tag jakubboucek/lamp-devstack-php:7.3 jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}
docker tag jakubboucek/lamp-devstack-php:7.3-debug jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:7.3
docker push jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}
docker push jakubboucek/lamp-devstack-php:7.3-debug
docker push jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}-debug
```

### MariaDB
```shell
docker pull mariadb:10.4
docker run --rm mariadb:10.4 mysql --version
docker build --progress plain --no-cache -f mysql/Dockerfile -t jakubboucek/lamp-devstack-mysql:latest mysql/
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.4
docker tag jakubboucek/lamp-devstack-mysql:latest jakubboucek/lamp-devstack-mysql:10.4.x
docker push jakubboucek/lamp-devstack-mysql:latest
docker push jakubboucek/lamp-devstack-mysql:10
docker push jakubboucek/lamp-devstack-mysql:10.4
docker push jakubboucek/lamp-devstack-mysql:10.4.x
```
