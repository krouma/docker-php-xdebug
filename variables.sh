#!/usr/bin/env bash

declare -A extensions_dir
extensions_dir=(
	[5.6]='no-debug-non-zts-20131226'
	[7.0]='no-debug-non-zts-20151012'
	[7.1]='no-debug-non-zts-20160303'
	[7.2]='no-debug-non-zts-20170718'
	[7.3]='no-debug-non-zts-20180731'
	[7.4]='no-debug-non-zts-20190902'
        [8.0-rc]='no-debug-non-zts-20200804'
)
declare -A dependencies
dependencies=(
    [5.6]='apt-get install -y git libpq-dev libmcrypt-dev zlib1g-dev libicu-dev libzip-dev g++ graphviz'
    [7.0]='apt-get install -y git libpq-dev libmcrypt-dev zlib1g-dev libicu-dev libzip-dev g++ graphviz'
    [7.1]='apt-get install -y git libpq-dev libmcrypt-dev zlib1g-dev libicu-dev libzip-dev g++ graphviz'
    [7.2]='apt-get install -y git libpq-dev libmcrypt-dev zlib1g-dev libicu-dev libzip-dev g++ graphviz'
    [7.3]='apt-get install -y git libpq-dev libmcrypt-dev zlib1g-dev libicu-dev libzip-dev g++ graphviz'
    [7.4]='apt-get install -y git libpq-dev libmcrypt-dev zlib1g-dev libicu-dev libzip-dev g++ graphviz libonig-dev'
    [8.0-rc]='httpd wget'
)
