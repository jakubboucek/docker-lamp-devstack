# LAMP devstack as Docker
Prepared images for local development in [LAMP devstack](https://en.wikipedia.org/wiki/LAMP_(software_bundle))

* [Builded images](#builded-images)
* [Main features](#main-features)
* [Basic usage](#basic-usage)
    + [Version tags](#version-tags)
    + [Using MySQL](#using-mysql)
    + [Windows issue](#windows-issue)
* [Extended configuration](#extended-configuration)
    + [PHP configuration](#php-configuration) 
    + [Document Root](#document-root)
    + [Timezone](#timezone)
    + [Temporary, Upload and Session storage directory](#temporary-upload-and-session-storage-directory)
    + [Other PHP configurations](#other-php-configurations)
* [Advanced usage](#advanced-usage)
    + [Xdebug](#xdebug)
    + [Debugging CLI with PhpStorm](#debugging-cli-with-phpstorm)
* [Building notes](#building-notes)


## Builded images

- PHP: [`jakubboucek/lamp-devstack-php`](https://hub.docker.com/r/jakubboucek/lamp-devstack-php)
- MySQL: [`jakubboucek/lamp-devstack-mysql`](https://hub.docker.com/r/jakubboucek/lamp-devstack-mysql)

## Main features
- architecture: `linux/amd64`
- the current versions of **PHP** 8.1, 8.0 and 7.4
- the legacy versions of **PHP** 7.3, 7.2, 7.1, 7.0, 5.6, 5.5 and 5.4 (with limited stability, unoptimized, unmaintained)
- the current versions of **MariaDB** 10.3, 10.4, 10.5 and 10.6
- the current version of **Apache** 2.4 (in non-CLI images)
- the current version of **Xdebug** 3.1 (in debug images)
- PHP has added extensions:
    [`bmath`](https://www.php.net/manual/en/book.bc.php),
    [`bz2`](https://www.php.net/manual/en/book.bzip2.php),
    [`exif`](https://www.php.net/manual/en/book.exif.php),
    [`gd`](https://www.php.net/manual/en/book.image.php) with support PNG, WebP, AVIF (for PHP 8.1) and FreeType fonts,
    [`gettext`](https://www.php.net/manual/en/book.gettext.php),
    [`gmp`](https://www.php.net/manual/en/book.gmp.php),
    [`imap`](https://www.php.net/manual/en/book.imap.php),
    [`intl`](https://www.php.net/manual/en/book.intl.php),
    [`mysqli`](https://www.php.net/manual/en/book.mysqli.php),
    [`pdo_mysql`](https://www.php.net/manual/en/book.pdo.php),
    [`opcache`](https://www.php.net/manual/en/book.opcache.php),
    [`pcntl`](https://www.php.net/manual/en/book.pcntl.php),
    [`sockets`](https://www.php.net/manual/en/book.sockets.php),
    [`soap`](https://www.php.net/manual/en/book.soap.php),
    [`sodium`](https://www.php.net/manual/en/book.sodium.php),
    [`xsl`](https://www.php.net/manual/en/book.xsl.php) and
    [`zip`](https://www.php.net/manual/en/book.zip.php)
- Apache activated modules: [`expires`](https://httpd.apache.org/docs/current/mod/mod_expires.html),
    [`headers`](https://httpd.apache.org/docs/current/mod/mod_headers.html) and
    [`rewrite`](https://httpd.apache.org/docs/current/mod/mod_rewrite.html)
- Apache `DocumentRoot` changed to: `/var/www/html/www` (configurable by ENV)
- PHP image has also pre-installed [Composer 2.2+](https://getcomposer.org/) and [Git 2.30+](https://git-scm.com/) to 
    use it in guest shell  
- MySQL properly configured to `utf8mb4` as default charset and optional support of Windows Host
- optimized for correct support timezones
- optimized for small image size a fast load


## Basic usage
Copy the [`docker-compose.yml`](docker-compose.yml) file
([download](https://downfile.github.io/download?url=https%3A//raw.githubusercontent.com/jakubboucek/docker-lamp-devstack/master/docker-compose.yml&file=docker-compose.yml))
to Your project's root (you needn't clone/download whole repo, just copy the one file).

Call `docker compose up`. After docker containers runs, your project will be served at http://localhost:8080/.

Served is the only directory `/www` from your project, but PHP scripts has access to whole project's root.  
That's mean, your application is no public accessible from the web, only `/www` directory.

Example:
```
my_project/                 <-- project's root
    docker-compose.yml      <-- docker config from this repository
    www/                    <-- Document Root, accessible at http://localhost:8080/
        index.php           <-- your PHP app
        logo.png            <-- accessible at http://localhost:8080/logo.png
        gallery/
            photo1.jpg      <-- accessible at http://localhost:8080/gallery/photo1.jpg
    vendor/
        autoload.php        <-- not accessible from web, but PHP can: require(__DIR__ . '/../vendor/autoload.php')
```

### Version tags

Images are tagged by the cascaded SemVer:
- `jakubboucek/lamp-devstack-php:latest` – means `latest` available stable PHP image,
- `jakubboucek/lamp-devstack-php:8` – represents the highest PHP image of `8` version, but lower than `9.0.0`,
- `jakubboucek/lamp-devstack-php:8.1` – represents the highest PHP image of `8.1` version, but lower than `8.2.0`,
- `jakubboucek/lamp-devstack-php:8.1.10` – represents most specific PHP image, directly version `8.1.10`.

**Legacy PHP** images are tagged by defferent strategy, only last one revision for each minor version, use `-legacy`
tag suffix:

- `jakubboucek/lamp-devstack-php:7.3-legacy`
- `jakubboucek/lamp-devstack-php:7.2-legacy`
- `jakubboucek/lamp-devstack-php:7.1-legacy`
- `jakubboucek/lamp-devstack-php:7.0-legacy`
- `jakubboucek/lamp-devstack-php:5.6-legacy`
- `jakubboucek/lamp-devstack-php:5.5-legacy`
- `jakubboucek/lamp-devstack-php:5.4-legacy`

All PHP images has XDebug variants, use `-debug` tag suffix, example:
- `jakubboucek/lamp-devstack-php:debug`
- `jakubboucek/lamp-devstack-php:8-debug`
- `jakubboucek/lamp-devstack-php:8.1-debug`
- `jakubboucek/lamp-devstack-php:8.1.10-debug`
- `jakubboucek/lamp-devstack-php:7.3-legacy-debug`

All PHP images has CLI variants, use `-cli` tag suffix, example:
- `jakubboucek/lamp-devstack-php:cli`
- `jakubboucek/lamp-devstack-php:8-cli`
- `jakubboucek/lamp-devstack-php:8.1-cli`
- `jakubboucek/lamp-devstack-php:8.1.10-cli`
- `jakubboucek/lamp-devstack-php:7.3-legacy-cli`


### Using MySQL
MySQL starts at the same time as web server.

Available MySQL images:

- 10.3: `jakubboucek/lamp-devstack-mysql:10.3`
- 10.4: `jakubboucek/lamp-devstack-mysql:10.4`
- 10.5: `jakubboucek/lamp-devstack-mysql:10.5`
- 10.6: `jakubboucek/lamp-devstack-mysql:latest`

Default credentials:
- user: `root`
- password: `devstack`
- database name: `default`

From Host is MySQL accessible on:
- host: `127.0.0.1`
- port: `33060`

From docker guest is MySQL accessible on:
- host: `mysqldb`
- port: `3306`

That's mean, when you are connecting to MySQL from PHP application inside Docker, use the guest access, but when you
connect from outside (from Your computer, for example the [HeidiSQL](https://www.heidisql.com/)
or [Sequel](https://sequel-ace.com/)), use host access.

PHP example:
```php
$pdo = new PDO('mysql:host=mysqldb;dbname=default;charset=utf8mb4', 'root', 'devstack');
// or
$mysqli = new mysqli('mysqldb', 'root', 'devstack', 'default');
$mysqli->set_charset('utf8mb4');
```

### Windows issue

MySQL maybe crash when Host is Windows platform: 

```
The Auto-extending innodb_system data file './ibdata1' is of a different size 0 pages than specified in the .cnf file
```

You can try to fix it with [`mysql-windows.cnf`](mysql/mysql-windows.cnf)
([download](https://downfile.github.io/download?url=https%3A//raw.githubusercontent.com/jakubboucek/docker-lamp-devstack/master/mysql/mysql-windows.cnf))
and add it to path `/etc/mysql/conf.d/` inside Docker container.

In `docker-compose.yml` file just link this downloaded file to `volume` section:

```yaml
volumes:
    - "./docker/mysql/data:/var/lib/mysql"
    - "./mysql-windows.cnf:/etc/mysql/conf.d/mysql-windows.cnf"
```

## Extended configuration

### PHP configuration 

Certain [`php.ini` directives](https://www.php.net/manual/en/ini.list.php) can be modified without manipulating with
image content, these feature using the environment variables. It can be defined in `ducker run` command or in
`docker-compose.yml` file.

Adjustable directives:
 
- `PHP_MAX_EXECUTION_TIME` – change the [`max_execution_time` directive](https://www.php.net/manual/en/info.configuration.php#ini.max-execution-time) (default value: `30`)
- `PHP_MEMORY_LIMIT` – change the [`memory_limit` directive](https://www.php.net/manual/en/ini.core.php#ini.memory-limit) (default value: `2G`)
- `PHP_OPCACHE_ENABLE` – change the [`opcache.enable` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.enable) (default value: `1`)
- `PHP_OPCACHE_ENABLE_CLI` – change the [`opcache.enable_cli` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.enable-cli) (default value: `0`)
- `PHP_OPCACHE_MEMORY_CONSUPTION` – change the [`opcache.memory_consumption` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.memory-consumption) (default value: `128`)
- `PHP_OPCACHE_VALIDATE_TIMESTAMPS` – change the [`opcache.validate_timestamps` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.validate-timestamps) (default value: `1`)
- `PHP_OPCACHE_REVALIDATE_FREQ` – change the [`opcache.revalidate_freq` directive](https://www.php.net/manual/en/opcache.configuration.php#ini.opcache.revalidate-freq) (default value: `2`)

Example for `docker run` command:

```shell
docker run --rm -e PHP_MEMORY_LIMIT=1G jakubboucek/lamp-devstack-php php -i
```

Example `docker-compose.yml` file:

```yaml
environment:
    PHP_MEMORY_LIMIT: 1G
```

### Document Root

Put custom `APACHE_DOCUMENT_ROOT` environment variable with path to Document Root as the value.

You can put it directly with `docker run`:

```shell
docker run -it --rm -e APACHE_DOCUMENT_ROOT=/my-web jakubboucek/lamp-devstack-php
```

You can also put it to `docker-compose.yml` file:

```yaml
environment:
    APACHE_DOCUMENT_ROOT: "/my-web"
```

### Timezone

The default timezone is not defined (aka `UTC`). You can modify the default timezone by the `TZ` environment variable
with timezone name as value (e.g.: `Europe/Prague`).

You can put it directly with `docker run`:

```shell
docker run -it --rm -e TZ=Europe/Prague jakubboucek/lamp-devstack-php
```

You can also put it to `docker-compose.yml` file:

```yaml
environment:
    TZ: Europe/Prague
```

The `TZ` environment variable is recognized by Linux, by that variable you modify the default timezone for the whole Linux
operating system, PHP, and also MySQL.

### Temporary, Upload and Session storage directory

PHP is using native Linux temporary directory for all own temporary files (inlcuding Session and Upload storage). This
image does not provide custom way to modify them. You can use the `TEMPDIR` environment variable to modify all of them.

You can put it directly with `docker run`:

```shell
docker run -it --rm -e TEMPDIR=/var/www/temp jakubboucek/lamp-devstack-php
```

You can also put it to `docker-compose.yml` file:

```yaml
environment:
  TEMPDIR: /var/www/temp
```

Note: The directory MUST already exists and MUST be writable to all users (`0777`), otherwise PHP can be unstable or
can lost data (e.g. Sessions data). Moving temporary directory to volume binded to the Host can have a big impact
on performance.

The `TEMPDIR` environment variable is recognized by Linux, by that variable you modify the default temporary directory
for the whole Linux operating system, PHP, and also MySQL.

### Other PHP configurations

Settings other than those listed above can be set by INI file. You can inject it to `/usr/local/etc/php/conf.d`
directory through [Volume mounting](https://docs.docker.com/storage/volumes/#choose-the--v-or---mount-flag)
without building custom image.

Create `custom.ini` file to Your project's root:

```ini
sendmail_from = any@my-domain.tld
```

Mount file to container by `volume` directive to `docker-compose.yml` file:

```yaml
volumes:
  - "./custom.ini:/usr/local/etc/php/conf.d/custom.ini"
```

Check available [`docker-compose.yml`](docker-compose.yml) file to example of `volume` usage.

## Advanced usage

### Xdebug

Prepared is PHP with Xdebug variant too. Use [`docker-compose-debug.yml`](docker-compose-debug.yml)
([download](https://downfile.github.io/download?url=https%3A//raw.githubusercontent.com/jakubboucek/docker-lamp-devstack/master/docker-compose-debug.yml&file=docker-compose.yml))
instead (copy and rename it to `docker-compose.yml`).

Xdebug is not started by default, you must call requests with [relevant Trigger](https://xdebug.org/docs/all_settings#start_with_request#trigger)
(tip: [how to fire Triggers from your Browser](https://www.jetbrains.com/help/phpstorm/2021.1/browser-debugging-extensions.html)).

Xdebug has enabled features:

- [`Profiler`](https://xdebug.org/docs/profiler)
- [`Step Debugger`](https://xdebug.org/docs/step_debug)
- [`Tracing`](https://xdebug.org/docs/trace)

Profiler a Tracing outputs are saved to `/var/www/html/log` directory inside Container. Thats means the output files are
propagated to the Host to `log/` directory (this directory must be manually created first).

You can change output directory through Environment variable `XDEBUG_CONFIG` with `output_dir` parameter.

In [`docker-compose.yml`](docker-compose-debug.yml) file just modify `environment` section:

```yaml
environment:
    XDEBUG_CONFIG: "client_host=host.docker.internal output_dir=/another/dir"
    #                                                ^^^^^^^^^^^^^^^^^^^^^^^
```

Form Xdebug 3.1 Profiler a Tracing outputs are compressed by GZip. You can turn off GZip compression through Environment
variable `XDEBUG_CONFIG` with `use_compression` parameter and `false` value.

In [`docker-compose.yml`](docker-compose-debug.yml) file just modify `environment` section:

```yaml
environment:
    XDEBUG_CONFIG: "client_host=host.docker.internal use_compression=false"
    #                                                ^^^^^^^^^^^^^^^^^^^^^
```

### Debugging CLI with PhpStorm

With PhpStorm you can also debug the CLI scripts. But you need set the Server name,
[PhpStorm requires it to mapping paths](https://blog.jetbrains.com/phpstorm/2012/03/new-in-4-0-easier-debugging-of-remote-php-command-line-scripts/).

In [`docker-compose.yml`](docker-compose-debug.yml) file just add Environment variable `PHP_IDE_CONFIG` with `serverName` parameter:

```yaml
environment:
    PHP_IDE_CONFIG: "serverName=docker-cli"
```

## Building notes
If you need build custom images based on this repo, see [Build notes](build-notes.md)
