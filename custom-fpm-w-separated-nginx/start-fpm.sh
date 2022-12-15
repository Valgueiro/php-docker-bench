#!/usr/bin/bash
set -eou;

echo "hellow"
# Start PHP-FPM
/usr/sbin/php-fpm${PHP_VERSION} -R --nodaemonize
