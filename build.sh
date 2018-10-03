#!/usr/bin/env bash

for version in 5.6 7.0 7.1 7.1-nette 7.2 7.2-nette; do
    docker build -t milk/php-xdebug:${version} ${version}
done
