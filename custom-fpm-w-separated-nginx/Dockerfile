FROM ubuntu:focal

# Disable frontend dialogs
ENV DEBIAN_FRONTEND noninteractive
# ENV PHP_VERSION=7.2
ARG PHP_VERSION
ENV PHP_VERSION=${PHP_VERSION:-7.2}

# Add ppa, curl and syslogd
RUN apt-get update && apt-get install -y software-properties-common curl inetutils-syslogd && \
    LC_ALL=C.UTF-8 apt-add-repository ppa:ondrej/php -y && \
    apt-get update && apt-get install -y \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-zip \
    zip \
    unzip && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir -p /run/php && chmod -R 755 /run/php

COPY update-config-files.sh /tmp/update-config-files.sh
RUN chmod +x /tmp/update-config-files.sh && \
    ./tmp/update-config-files.sh

# Copy PHP-FPM service script
COPY start-fpm.sh /etc/services.d/php_fpm/run
RUN chmod 755 /etc/services.d/php_fpm/run


ENTRYPOINT ["./etc/services.d/php_fpm/run"]
CMD []
