ARG PHP_VERSION
FROM php:${PHP_VERSION}

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git zip

COPY --from=composer /usr/bin/composer /usr/bin/composer
