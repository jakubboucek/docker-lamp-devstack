# LAMP devstack as Docker 
Prepared images for local development in [LAMP devstack](https://en.wikipedia.org/wiki/LAMP_(software_bundle)

## Main features
- current version of PHP 7.3
- current version of Apache (with added [`mod_expires`](https://httpd.apache.org/docs/current/mod/mod_expires.html)
    and [`mod_rewrite`](https://httpd.apache.org/docs/current/mod/mod_rewrite.html) modules)
- current version of Maria 10  (with properly configured `utf8mb4` charset)
- optimized for small image size a fast load

## Usage
Just copy the [`docker-compose.yml`](docker-compose.yml) file to Your project's root and call `docker-compose up`.

It starts Apache which looks into `/www` directory in project as
[`DocumentRoot`](https://httpd.apache.org/docs/2.4/mod/core.html#documentroot), but for PHP is accesible whole project
directory.

At the same time starts MySQL database server, ready to use. 

## Building notes
- `docker build -f php/Dockerfile -t jakubboucek/lamp-devstack-php php/`
- `docker build -f mysql/Dockerfile -t jakubboucek/lamp-devstack-mysql mysql/`
