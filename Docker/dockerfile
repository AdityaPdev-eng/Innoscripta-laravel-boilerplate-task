FROM php:8.2-fpm-alpine

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

WORKDIR /var/www

RUN apk add --no-cache \
    bash \
    libzip-dev \
    unzip \
    oniguruma-dev \
    && docker-php-ext-install pdo pdo_mysql zip

COPY --chown=laravel:laravel . .

USER laravel

CMD ["php-fpm"]
