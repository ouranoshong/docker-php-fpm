FROM laradock/php-fpm:2.2-7.2

LABEL maintainer="hong <ouranoshong@outlook.com>" 

RUN pecl install APCu && \
    docker-php-ext-enable apcu

RUN pecl install mongodb && \
    docker-php-ext-enable mongodb

RUN docker-php-ext-install zip

RUN docker-php-ext-install opcache \
    docker-php-ext-enable opcache

USER root
ARG INSTALL_IMAGEMAGICK=false
RUN apt-get update -y && \
    apt-get install -y libmagickwand-dev imagemagick && \
    apt-get clean && \
    pecl install imagick && \
    docker-php-ext-enable imagick

RUN usermod -u 1000 www-data

WORKDIR /var/www/slim

CMD ["php-fpm"]

EXPOSE 9000
