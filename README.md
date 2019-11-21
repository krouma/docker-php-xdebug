# Docker php-xdebug image

This image is based on the official php image.
It also does the following:
* Enable `pdo_pgsql`, `pdo_mysql`, `mysqli`, `mbstring`, `mcrypt`, `zip`, `sockets`, `intl` and `bcmath` extensions.
* Install [composer](https://getcomposer.org/).
* Install [XDebug](https://xdebug.org/).
* Install [APCu](http://php.net/manual/en/book.apcu.php).
* Configure [XDebug](https://xdebug.org/) to be used in Docker.
* Enable [OPCache](http://php.net/manual/en/book.opcache.php).
* Configure [`realpath_cache_size` and `realpath_cache_ttl`](http://php.net/manual/en/ini.core.php#ini.sect.performance).
* Set the [default timezone](http://php.net/manual/en/datetime.configuration.php#ini.date.timezone) to `UTC`.
* Enable the apache [rewrite](http://httpd.apache.org/docs/current/mod/mod_rewrite.html) module.

## Base image

* [`php`](https://hub.docker.com/_/php/)

## Supported tags and respective `Dockerfile` links

* [`7.3.0`, `7.3`, `7`, `latest` (*7.3/Dockerfile*)](https://github.com/krouma/docker-php-xdebug/blob/master/7.3/Dockerfile)
* [`7.2.12`, `7.2` (*7.2/Dockerfile*)](https://github.com/krouma/docker-php-xdebug/blob/master/7.2/Dockerfile)
* [`7.1.24`, `7.1` (*7.1/Dockerfile*)](https://github.com/krouma/docker-php-xdebug/blob/master/7.1/Dockerfile)

## How to use this image.

See [the `php` image documentation](https://hub.docker.com/_/php/).

But use `krouma/php-xdebug` instead of `php`.

## How to use XDebug

### With apache

It should work out of the box with your IDE.

### In CLI

You must specify the following option:
* `xdebug.remote_autostart`
* `xdebug.remote_host`

For example, you can run:
```
php -d xdebug.remote_autostart=1 -d xdebug.remote_host=192.168.99.1 test.php
```

## Supported Docker versions

This image is officially supported on Docker version 1.8.1.

Support for older versions (down to 1.6) is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.

