#!/usr/bin/env bash

source ./variables.sh

php_version=$1
fedora_version=$2
repo=$3
php_mm_version=$(echo $1 | sed 's/^\([0-9]\)\.\([0-9]\)-rc/\1.\2/')

mkdir -p "${php_version}"
dockerfile=${php_version}/Dockerfile

echo "FROM fedora:${fedora_version}" > ${dockerfile}
echo 'LABEL maintainer "Matyas Kroupa <kroupa.matyas@gmail.com>"' >> ${dockerfile}
echo >> ${dockerfile}

if [ $repo = "remi" ]; then
    cat << EOF >> ${dockerfile}
RUN dnf install -y https://rpms.remirepo.net/fedora/remi-release-${fedora_version}.rpm \\
        dnf-plugins-core && \\
    dnf config-manager --set-enabled remi && \\
    dnf config-manager --set-enabled remi-modular && \\
    dnf module install -y php:remi-${php_mm_version} && \\
    dnf install -y php-opcache php-pecl-xdebug3 php-pecl-zip
EOF
fi
echo >> ${dockerfile}

cat Dockerfile \
    | sed "s/#EXTENSION_DIR#/${extensions_dir[${php_version}]}/g" \
    | sed "s/#DEPENDENCIES#/${dependencies[${php_version}]}/g" \
    >> ${dockerfile}
