#!/usr/bin/env bash

MINOR_VERSIONS=(7.1 7.2)

for version in ${MINOR_VERSIONS[*]}; do
    #update base container version and save it to fullversion
    printf "\nGetting latest version of PHP ${version}\n"
    docker pull php:${version}
    fullversion=$(docker run -a stdout --rm php:${version}-apache php --version | head -1 | awk '{print $2}')

    #build containers
    printf "\nBuilding version ${fullversion}\n"
    docker build -t krouma/php-xdebug:${version} ${version} --no-cache

    #tag fullversion
    printf "\nTagging ${version} as ${fullversion}\n"
    docker tag krouma/php-xdebug:${version} krouma/php-xdebug:${fullversion}
done
