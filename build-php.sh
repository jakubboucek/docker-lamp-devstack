# shellcheck disable=SC2086
set -eux;

### PHP 8.0
docker pull php:8.0-apache
docker pull php:8.0-cli
docker run --rm php:8.0-apache php --version
docker run --rm php:8.0-cli php --version
docker build --progress plain -f php/Dockerfile-8.0 -t jakubboucek/lamp-devstack-php:8.0 php/
docker build --progress plain -f php/Dockerfile-8.0-debug -t jakubboucek/lamp-devstack-php:8.0-debug php/
docker build --progress plain -f php/Dockerfile-8.0-cli -t jakubboucek/lamp-devstack-php:8.0-cli php/
docker run --rm jakubboucek/lamp-devstack-php:8.0 php --version
docker run --rm jakubboucek/lamp-devstack-php:8.0-debug php --version
docker run --rm jakubboucek/lamp-devstack-php:8.0-cli php --version
docker run --rm jakubboucek/lamp-devstack-php:8.0 php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:8.0 php -r "echo PHP_RELEASE_VERSION;")
docker tag jakubboucek/lamp-devstack-php:8.0 jakubboucek/lamp-devstack-php:latest
docker tag jakubboucek/lamp-devstack-php:8.0 jakubboucek/lamp-devstack-php:8
docker tag jakubboucek/lamp-devstack-php:8.0 jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}
docker tag jakubboucek/lamp-devstack-php:8.0-debug jakubboucek/lamp-devstack-php:debug
docker tag jakubboucek/lamp-devstack-php:8.0-debug jakubboucek/lamp-devstack-php:8-debug
docker tag jakubboucek/lamp-devstack-php:8.0-debug jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}-debug
docker tag jakubboucek/lamp-devstack-php:8.0-cli jakubboucek/lamp-devstack-php:cli
docker tag jakubboucek/lamp-devstack-php:8.0-cli jakubboucek/lamp-devstack-php:8-cli
docker tag jakubboucek/lamp-devstack-php:8.0-cli jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}-cli
docker push jakubboucek/lamp-devstack-php:latest
docker push jakubboucek/lamp-devstack-php:8
docker push jakubboucek/lamp-devstack-php:8.0
docker push jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}
docker push jakubboucek/lamp-devstack-php:debug
docker push jakubboucek/lamp-devstack-php:8-debug
docker push jakubboucek/lamp-devstack-php:8.0-debug
docker push jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:cli
docker push jakubboucek/lamp-devstack-php:8-cli
docker push jakubboucek/lamp-devstack-php:8.0-cli
docker push jakubboucek/lamp-devstack-php:8.0.${PHP_RELEASE}-cli

### PHP 7.4
docker pull php:7.4-apache
docker pull php:7.4-cli
docker run --rm php:7.4-apache php --version
docker run --rm php:7.4-cli php --version
docker build --progress plain -f php/Dockerfile-7.4 -t jakubboucek/lamp-devstack-php:7.4 php/
docker build --progress plain -f php/Dockerfile-7.4-debug -t jakubboucek/lamp-devstack-php:7.4-debug php/
docker build --progress plain -f php/Dockerfile-7.4-cli -t jakubboucek/lamp-devstack-php:7.4-cli php/
docker run --rm jakubboucek/lamp-devstack-php:7.4 php --version
docker run --rm jakubboucek/lamp-devstack-php:7.4-debug php --version
docker run --rm jakubboucek/lamp-devstack-php:7.4-cli php --version
docker run --rm jakubboucek/lamp-devstack-php:7.4 php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:7.4 php -r "echo PHP_RELEASE_VERSION;")
docker tag jakubboucek/lamp-devstack-php:7.4 jakubboucek/lamp-devstack-php:7
docker tag jakubboucek/lamp-devstack-php:7.4 jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}
docker tag jakubboucek/lamp-devstack-php:7.4-debug jakubboucek/lamp-devstack-php:7-debug
docker tag jakubboucek/lamp-devstack-php:7.4-debug jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}-debug
docker tag jakubboucek/lamp-devstack-php:7.4-cli jakubboucek/lamp-devstack-php:7-cli
docker tag jakubboucek/lamp-devstack-php:7.4-cli jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}-cli
docker push jakubboucek/lamp-devstack-php:7
docker push jakubboucek/lamp-devstack-php:7.4
docker push jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}
docker push jakubboucek/lamp-devstack-php:7-debug
docker push jakubboucek/lamp-devstack-php:7.4-debug
docker push jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:7-cli
docker push jakubboucek/lamp-devstack-php:7.4-cli
docker push jakubboucek/lamp-devstack-php:7.4.${PHP_RELEASE}-cli

### PHP 7.3
docker pull php:7.3-apache
docker pull php:7.3-cli
docker run --rm php:7.3-apache php --version
docker run --rm php:7.3-cli php --version
docker build --progress plain -f php/Dockerfile-7.3 -t jakubboucek/lamp-devstack-php:7.3 php/
docker build --progress plain -f php/Dockerfile-7.3-debug -t jakubboucek/lamp-devstack-php:7.3-debug php/
docker build --progress plain -f php/Dockerfile-7.3-cli -t jakubboucek/lamp-devstack-php:7.3-cli php/
docker run --rm jakubboucek/lamp-devstack-php:7.3 php --version
docker run --rm jakubboucek/lamp-devstack-php:7.3-debug php --version
docker run --rm jakubboucek/lamp-devstack-php:7.3-cli php --version
docker run --rm jakubboucek/lamp-devstack-php:7.3 php -r "echo implode(', ', get_loaded_extensions()) . PHP_EOL;"
PHP_RELEASE=$(docker run --rm jakubboucek/lamp-devstack-php:7.3 php -r "echo PHP_RELEASE_VERSION;")
docker tag jakubboucek/lamp-devstack-php:7.3 jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}
docker tag jakubboucek/lamp-devstack-php:7.3-debug jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}-debug
docker tag jakubboucek/lamp-devstack-php:7.3-cli jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}-cli
docker push jakubboucek/lamp-devstack-php:7.3
docker push jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}
docker push jakubboucek/lamp-devstack-php:7.3-debug
docker push jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}-debug
docker push jakubboucek/lamp-devstack-php:7.3-cli
docker push jakubboucek/lamp-devstack-php:7.3.${PHP_RELEASE}-cli
