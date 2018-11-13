#!/usr/bin/env bash

MINOR_VERSIONS=7.1 7.2

for version in $MINOR_VERSIONS; do
    #update base container version and save it to fullversion
    echo "\nGetting latest version of PHP ${version}\n"
    docker pull php:${version}
    fullversion=$(docker run -a stdout --rm php:${version}-apache php --version | head -1 | awk '{print $2}')

    #build containers
    echo "\nBuilding version ${fullversion}\n"
    docker build -t krouma/php-xdebug:${version} ${version} --no-cache
    docker build -t krouma/php-xdebug:${version}-nette ${version}-nette --no-cache

    #tag fullversion
    echo "\nTagging ${version} as ${fulversion}\n"
    docker tag krouma/php-xdebug:${version} krouma/php-xdebug{$fullversion}
    docker tag krouma/php-xdebug:${version}-nette krouma/php-xdebug{$fullversion}-nette
done
