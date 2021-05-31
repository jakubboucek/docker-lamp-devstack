# LAMP devstack as Docker
Prepared images for local development in [LAMP devstack](https://en.wikipedia.org/wiki/LAMP_(software_bundle))

## Builded images

- PHP: [`jakubboucek/lamp-devstack-php`](https://hub.docker.com/r/jakubboucek/lamp-devstack-php)
- MySQL: [`jakubboucek/lamp-devstack-mysql`](https://hub.docker.com/r/jakubboucek/lamp-devstack-mysql)

## Main features
- architecture: `linux/amd64`
- the current versions of **PHP** 8.0, 7.4 and 7.3
- the current versions of **MariaDB** 10.5 and 10.6-beta
- the current version of **Apache** 2.4 (in non-CLI images)
- the current version of **Xdebug** 3 (in debug images)
- PHP has added extensions:
    [`bmath`](https://www.php.net/manual/en/book.bc.php),
    [`gd`](https://www.php.net/manual/en/book.image.php),
    [`intl`](https://www.php.net/manual/en/book.intl.php),
    [`mysqli`](https://www.php.net/manual/en/book.mysqli.php),
    [`pdo_mysql`](https://www.php.net/manual/en/book.pdo.php),
    [`pcntl`](https://www.php.net/manual/en/book.pcntl.php),
    [`sockets`](https://www.php.net/manual/en/book.sockets.php),
    [`xsl`](https://www.php.net/manual/en/book.xsl.php) and
    [`zip`](https://www.php.net/manual/en/book.zip.php)
- Apache activated modules: [`expires`](https://httpd.apache.org/docs/current/mod/mod_expires.html),
    [`headers`](https://httpd.apache.org/docs/current/mod/mod_headers.html) and
    [`rewrite`](https://httpd.apache.org/docs/current/mod/mod_rewrite.html)
- MySQL properly configured to `utf8mb4` as default charset and optional support of Windows Host
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

- `jakubboucek/lamp-devstack-php:latest` – means `latest` available PHP image,
- `jakubboucek/lamp-devstack-php:7` – represents the highest PHP image of `7.x.x` version, but lower than `8.0.0`,
- `jakubboucek/lamp-devstack-php:7.3` – represents the highest PHP image of `7.3.x` version, but lower than `7.4.0`,
- `jakubboucek/lamp-devstack-php:7.3.24` – represents most specific PHP image, directly version `7.3.24`.

All PHP images has parallel XDebug variants with `-debug` tag suffix, example:
- `jakubboucek/lamp-devstack-php:debug`
- `jakubboucek/lamp-devstack-php:7-debug`
- `jakubboucek/lamp-devstack-php:7.3-debug`
- `jakubboucek/lamp-devstack-php:7.3.24-debug`

All PHP images has parallel CLI variants with `-cli` tag suffix, example:
- `jakubboucek/lamp-devstack-php:cli`
- `jakubboucek/lamp-devstack-php:7-cli`
- `jakubboucek/lamp-devstack-php:7.3-cli`
- `jakubboucek/lamp-devstack-php:7.3.24-cli`

### Using MySQL
MySQL starts at the same time as web server.

Available MySQL images:

- Stable (10.5): `jakubboucek/lamp-devstack-mysql:laster`
- Beta (10.6): `jakubboucek/lamp-devstack-mysql:beta`

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
$pdo = new PDO('mysql:host=mysqldb;dbname=default', 'root', 'devstack');
// or
$mysqli = new mysqli('mysqldb', 'root', 'devstack', 'default');
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

Profiler a Tracing outputs are saved to `/var/www/html/log` directry inside Container. Thats means the output files are
propagated to the Host to `log/` directory (this directory must be manually created first).

You can change output directory through Environment variable `XDEBUG_CONFIG` with `output_dir` parameter.

In [`docker-compose.yml`](docker-compose-debug.yml) file just modify `environment` section:

```yaml
environment:
    XDEBUG_CONFIG: "client_host=host.docker.internal output_dir=/another/dir"
    #                                                ^^^^^^^^^^^^^^^^^^^^^^^
```

### Debugging CLI with PhpStorm

With PhpStorm you can ando debug the CLI scripts. But you need set the Server name,
[PhpStorm requires it to mapping paths](https://blog.jetbrains.com/phpstorm/2012/03/new-in-4-0-easier-debugging-of-remote-php-command-line-scripts/).

In [`docker-compose.yml`](docker-compose-debug.yml) file just add Environment variable `PHP_IDE_CONFIG` with `serverName` parameter:

```yaml
environment:
    PHP_IDE_CONFIG: "serverName=docker-cli"
```

## Building notes
If you need build custom images based on this repo, see [Build notes](build-notes.md)
