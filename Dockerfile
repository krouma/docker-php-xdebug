RUN dnf update -y && \
    dnf install -y #DEPENDENCIES# && \
    dnf clean all

RUN echo "xdebug.mode=debug" >> /etc/php.d/15-xdebug.ini && \
    echo "realpath_cache_size=4096k" > /etc/php.d/tuning.ini && \
    echo "realpath_cache_ttl=300" >> /etc/php.d/tuning.ini && \
    echo "date.timezone = \"UTC\"" >> /etc/php.d/timezone.ini

RUN mkdir /var/www/html/log; \
    mkdir /run/php-fpm; \
    mkdir -p /var/www/html/temp/cache; \
    chmod 777 -R /var/www/html/log /var/www/html/temp

ADD ./root /

EXPOSE 80
CMD ["/usr/local/bin/run-httpd"]
