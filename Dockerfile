FROM php:7.4-fpm AS basis
WORKDIR /app

RUN apt update && \
    apt install -y \
    libicu-dev=67.1-7 \
    libgd-dev=2.3.0-2 \
    libonig-dev=6.9.6-1.1 \
    unzip=6.0-26 && \
    apt purge -y --auto-remove

RUN docker-php-ext-install \
    exif \
    gd \
    intl \
    mbstring \
    sockets

FROM composer:2.1.11 AS construct
WORKDIR /app

COPY composer.json .
COPY composer.lock .
RUN composer install --no-dev --no-scripts --ignore-platform-reqs

COPY . .
RUN composer dumpautoload --optimize

FROM basis AS final

COPY --from=construct /app /app
