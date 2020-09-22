#!/usr/bin/env bash

MINOR_VERSIONS=$@

for version in ${MINOR_VERSIONS[*]}; do
    #update base container version and save it to fullversion
    printf "\nGetting latest version of PHP ${version}\n"
    buildah pull php:${version}-apache
    fullversion=$(podman run -a stdout --rm php:${version}-apache php --version | head -1 | awk '{print $2}')

    #build containers
    printf "\nBuilding version ${fullversion}\n"
    buildah bud --no-cache -t krouma/php-xdebug:${version} ${version}

    #tag fullversion
    printf "\nTagging ${version} as ${fullversion}\n"
    buildah tag krouma/php-xdebug:${version} krouma/php-xdebug:${fullversion}
done
