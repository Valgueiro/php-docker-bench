#!/usr/bin/with-contenv sh
set -eou;

# Start PHP-FPM
/usr/sbin/php-fpm${PHP_VERSION} -R --nodaemonize
