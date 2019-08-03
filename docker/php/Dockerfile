FROM php:7.3-fpm

RUN apt-get update && apt-get install -y \
        libyaml-dev \
         libxml2-dev \
         git\
         zip

RUN  docker-php-source extract \
       pecl install yaml-2.0.4 \
       && docker-php-ext-enable yaml \
        && docker-php-source delete 


COPY php.conf.d/ /etc/php-7.3.d/

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    && mv composer /usr/local/bin/composer

RUN mkdir -p /apps
WORKDIR /apps

RUN PATH=$PATH:/usr/src/apps/vendor/bin:bin