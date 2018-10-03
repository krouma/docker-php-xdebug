#!/usr/bin/env bash

declare -A apcu_version
apcu_version=(
	[5.6]='apcu-4.0.11'
	[7.0]='apcu-stable'
	[7.1]='apcu-stable'
	[7.1-nette]='apcu-stable'
	[7.2]='apcu-stable'
	[7.2-nette]='apcu-stable'
)

declare -A xdebug_version
xdebug_version=(
	[5.6]='xdebug-stable'
	[7.0]='xdebug-stable'
	[7.1]='xdebug-stable'
	[7.1-nette]='xdebug-stable'
	[7.2]='xdebug-stable'
	[7.2-nette]='xdebug-stable'
)

declare -A extensions_dir
extensions_dir=(
	[5.6]='no-debug-non-zts-20131226'
	[7.0]='no-debug-non-zts-20151012'
	[7.1]='no-debug-non-zts-20160303'
	[7.1-nette]='no-debug-non-zts-20160303'
	[7.2]='no-debug-non-zts-20170718'
	[7.2-nette]='no-debug-non-zts-20170718'
)

for version in 5.6 7.0 7.1 7.1-nette 7.2 7.2-nette; do
  mkdir -p "${version}"
  dockerfile=${version}/Dockerfile
  echo "FROM php:${version}-apache" > ${dockerfile}
  echo >> ${dockerfile}

  cat Dockerfile \
    | sed "s/#APCU_VERSION#/${apcu_version[${version}]}/g" \
    | sed "s/#XDEBUG_VERSION#/${xdebug_version[${version}]}/g" \
    | sed "s/#EXTENSION_DIR#/${extensions_dir[${version}]}/g" \
    >> ${dockerfile}
done
