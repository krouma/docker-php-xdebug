#!/usr/bin/env bash

declare -A apcu_version
apcu_version=(
	[5.6]='apcu-4.0.11'
	[7.0]='apcu-stable'
	[7.1]='apcu-stable'
	[7.2]='apcu-stable'
	[7.3]='apcu-stable'
	[7.4]='apcu-stable'
)

declare -A xdebug_version
xdebug_version=(
	[5.6]='xdebug-2.5.5'
	[7.0]='xdebug-stable'
	[7.1]='xdebug-stable'
	[7.2]='xdebug-stable'
	[7.3]='xdebug-stable'
	[7.4]='xdebug-stable'
)

declare -A extensions_dir
extensions_dir=(
	[5.6]='no-debug-non-zts-20131226'
	[7.0]='no-debug-non-zts-20151012'
	[7.1]='no-debug-non-zts-20160303'
	[7.2]='no-debug-non-zts-20170718'
	[7.3]='no-debug-non-zts-20180731'
	[7.4]='no-debug-non-zts-20190902'
)
declare -A dependencies
dependencies=(
    [5.6]='apt-get install -y git libpq-dev libmcrypt-dev zlib1g-dev libicu-dev libzip-dev g++ graphviz'
    [7.0]='apt-get install -y git libpq-dev libmcrypt-dev zlib1g-dev libicu-dev libzip-dev g++ graphviz'
    [7.1]='apt-get install -y git libpq-dev libmcrypt-dev zlib1g-dev libicu-dev libzip-dev g++ graphviz'
    [7.2]='apt-get install -y git libpq-dev libmcrypt-dev zlib1g-dev libicu-dev libzip-dev g++ graphviz'
    [7.3]='apt-get install -y git libpq-dev libmcrypt-dev zlib1g-dev libicu-dev libzip-dev g++ graphviz'
    [7.4]='apt-get install -y git libpq-dev libmcrypt-dev zlib1g-dev libicu-dev libzip-dev g++ graphviz libonig-dev'
)

for version in $@; do
  mkdir -p "${version}"
  dockerfile=${version}/Dockerfile
  echo "FROM php:${version}-apache" > ${dockerfile}
  echo >> ${dockerfile}

  cat Dockerfile \
    | sed "s/#APCU_VERSION#/${apcu_version[${version}]}/g" \
    | sed "s/#XDEBUG_VERSION#/${xdebug_version[${version}]}/g" \
    | sed "s/#EXTENSION_DIR#/${extensions_dir[${version}]}/g" \
    | sed "s/#DEPENDENCIES#/${dependencies[${version}]}/g" \
    >> ${dockerfile}
done
