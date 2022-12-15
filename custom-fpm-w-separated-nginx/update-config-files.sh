sed -i 's|.*listen =.*|listen=9000|g' /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
sed -i 's|.*error_log =.*|error_log=/proc/self/fd/2|g' /etc/php/${PHP_VERSION}/fpm/php-fpm.conf && \
sed -i 's|.*access.log =.*|access.log=/proc/self/fd/2|g' /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
sed -i 's|.*user =.*|user=root|g' /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
sed -i 's|.*group =.*|group=root|g' /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
sed -i 's#.*variables_order.*#variables_order=EGPCS#g' /etc/php/${PHP_VERSION}/fpm/php.ini && \
sed -i 's#.*date.timezone.*#date.timezone=UTC#g' /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
sed -i 's#.*clear_env.*#clear_env=no#g' /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
