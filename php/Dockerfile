FROM php:7.4-apache

# Workdir during installation
WORKDIR /tmp

# OS binaries install && update critical binaries
RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates \
        libjpeg-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libwebp-dev \
        openssl \
        zip \
        unzip \
    && docker-php-ext-configure \
        gd --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) \
        mysqli \
        bcmath \
        gd \
        pdo_mysql \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* /tmp/pear/temp/*

# Configure Apache & PHP
COPY php.ini /usr/local/etc/php/conf.d/dev-memory-increase.ini

# Move Apache Document root to sub-directory `www` (PHP frameworks convention)
ENV APACHE_DOCUMENT_ROOT /var/www/html/www

# Setup Devstack (install Composer, setup DocumentRoot)
RUN DEBIAN_FRONTEND=noninteractive \
    && curl -sS https://getcomposer.org/installer | php \
    && mv ./composer.phar /usr/local/bin/composer \
    && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && a2enmod rewrite expires

# Workdir after installation
WORKDIR /var/www/html
