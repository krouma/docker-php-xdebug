FROM fedora:33
LABEL maintainer "Matyas Kroupa <kroupa.matyas@gmail.com>"

RUN dnf install -y https://rpms.remirepo.net/fedora/remi-release-33.rpm \
        dnf-plugins-core && \
    dnf config-manager --set-enabled remi && \
    dnf config-manager --set-enabled remi-modular && \
    dnf module install -y php:remi-8.0 && \
    dnf install -y php-opcache php-pecl-xdebug3 php-pecl-zip

RUN dnf update -y && \
    dnf install -y httpd wget && \
    dnf clean all

RUN echo "xdebug.mode=debug" >> /etc/php.d/15-xdebug.ini && \
    echo "realpath_cache_size=4096k" > /etc/php.d/tuning.ini && \
    echo "realpath_cache_ttl=300" >> /etc/php.d/tuning.ini && \
    echo "date.timezone = \"UTC\"" >> /etc/php.d/timezone.ini

RUN mkdir /var/www/html/log; \
    mkdir -p /var/www/html/temp/cache; \
    chmod 777 -R /var/www/html/log /var/www/html/temp

ADD ./root /

EXPOSE 80
CMD ["/usr/local/bin/run-httpd"]
