FROM php:7.3-apache-stretch

WORKDIR /tmp

# OS binaries install && update critical binaries
RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
	&& apt-get install --no-install-recommends -y \
        ca-certificates \
        curl \
        libjpeg62-turbo-dev \
        libpng-dev \
        openssl \
	    zip \
	    unzip \
	&& docker-php-ext-install \
	    mysqli \
	    bcmath \
	    gd \
	    pdo_mysql \
	&& docker-php-ext-configure \
	    gd --with-jpeg-dir=/usr/include/ \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# Configura Apache & PHP
ENV APACHE_DOCUMENT_ROOT /var/www/html/www
COPY php.ini /usr/local/etc/php/conf.d/dev-memory-increase.ini

RUN DEBIAN_FRONTEND=noninteractive \
	&& curl -sS https://getcomposer.org/installer | php \
  	&& mv ./composer.phar /usr/local/bin/composer \
    && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
	&& a2enmod rewrite expires \
	&& service apache2 restart

WORKDIR /var/www/html
