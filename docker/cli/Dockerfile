FROM php:7.1-cli
MAINTAINER Cesar Casanova <cesar.casanovab92@gmail.com>

ENV DOCKER_USER="neoauto"
ENV BASE_DIR=/apps

RUN addgroup $DOCKER_USER && \
    adduser --gecos "" --shell /bin/sh --disabled-password --ingroup $DOCKER_USER $DOCKER_USER

#instalando buil-essential
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    build-essential

#instalando librerias externas
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    git \
    unzip \
  && rm -r /var/lib/apt/lists/*

ENV COMPOSER_HOME /composer
ENV PATH /composer/vendor/bin:$PATH

COPY phpconf.d/ /usr/local/etc/php/conf.d/

RUN curl -s http://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer


#copiando llave
RUN mkdir -p /home/$DOCKER_USER/.ssh
RUN ssh-keyscan -H bitbucket.org >> /home/$DOCKER_USER/.ssh/known_hosts

COPY composer.json ./
RUN composer install

RUN chown -R $DOCKER_USER:$DOCKER_USER ./vendor

COPY codesniffer/ /

VOLUME $BASE_DIR
WORKDIR $BASE_DIR

ADD entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh
ENTRYPOINT ["/root/entrypoint.sh"]
