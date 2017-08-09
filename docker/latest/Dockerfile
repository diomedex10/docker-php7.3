FROM amazonlinux:latest

RUN yum -y update && yum -y install \
    nginx \
    php70-fpm \
    php70-dom \
    php70-curl \
    php70-xml \
    php70-intl \
    php70-pdo \
    php70-mysqlnd \
    php70-pdo_mysql \
    php70-phar \
    php70-json \
    php70-posix \
    php70-iconv \
    php70-opcache \
    php70-mbstring \
    php70-mcrypt \
    php70-soap \
    php70-yaml


COPY php.conf.d/ /usr/local/etc/php/conf.d/

COPY config/*.sh /tmp
RUN chmod +x /tmp/runservices.sh

ADD config/nginx.conf /etc/nginx/nginx.conf
ADD config/php-fpm.conf /etc/php-fpm.d/www.conf

#copiando virtualhosts
COPY vhost/ /etc/nginx/sites-enabled/

EXPOSE 80 443

RUN mkdir -p /apps
WORKDIR /apps
VOLUME /apps

ENTRYPOINT /tmp/runservices.sh