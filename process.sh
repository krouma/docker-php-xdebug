#!/usr/bin/env bash

VERSIONS=$@
./build.sh $VERSIONS
./push.sh $VERSIONS

