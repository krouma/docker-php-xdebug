#!/usr/bin/env bash

VERSIONS=$@
HIGHEST_MAJOR=0
HIGHEST_MINOR=0


for VERSION in $VERSIONS; do
    # Determine newest patch version
    ABS_VERSION=$(buildah images krouma/php-xdebug --format "{{.Tag}}"| grep $VERSION | sort -k1 -r | head -n1)
    MAJOR_VERSION=$(echo $VERSION | cut -d "." -f1)
    MINOR_VERSION=$(echo $VERSION | cut -d "." -f2)
    
    # Push
    buildah push krouma/php-xdebug:$VERSION
    buildah push krouma/php-xdebug:$ABS_VERSION
    
    if [ $MAJOR_VERSION -gt $HIGHEST_MAJOR ]; then
        HIGHEST_MAJOR=$MAJOR_VERSION
        HIGHEST_MINOR=$MINOR_VERSION
    elif [ $MINOR_VERSION -gt $HIGHEST_MINOR ]; then
        HIGHEST_MINOR=$MINOR_VERSION
    fi
done

buildah tag krouma/php-xdebug:${HIGHEST_MAJOR}.${HIGHEST_MINOR} krouma/php-xdebug:${HIGHEST_MAJOR}
buildah tag krouma/php-xdebug:${HIGHEST_MAJOR}.${HIGHEST_MINOR} krouma/php-xdebug:latest

buildah push krouma/php-xdebug:${HIGHEST_MAJOR}
buildah push krouma/php-xdebug:latest

