#!/usr/bin/env bash

MINOR_VERSIONS=$@

for version in ${MINOR_VERSIONS[*]}; do
    #update base image version
    printf "\nGetting latest version of base image\n"
    buildah pull php:${version}-apache

    #build containers
    printf "\nBuilding version ${version}\n"
    buildah bud --no-cache -t krouma/php-xdebug:${version} -f ${version}/Dockerfile .

    #tag fullversion
    fullversion=$(podman run -a stdout --rm krouma/php-xdebug:${version} php --version | head -1 | awk '{print $2}')
    printf "\nTagging ${version} as ${fullversion}\n"
    buildah tag krouma/php-xdebug:${version} krouma/php-xdebug:${fullversion}
done
