# docker build -t epfl-dojo/php .
FROM php:5.6-apache
MAINTAINER epfl-dojo

ENV DEBIAN_FRONTEND noninteractive

RUN rm /etc/apache2/mods-available/php5.load
RUN apt-get update && apt-get -y install \
        php5-mcrypt php5-mysql \
        libapache2-mod-php5 \
        git

RUN a2enmod php5

WORKDIR /var/www/html
RUN git clone https://github.com/nuSoftware/nuBuilderPro.git
## http://localhost:8080/nuBuilderPro/nuinstall.php

#COPY nuBuilder-vhost.conf /etc/apache2/sites-available/000-default.conf
RUN chown -R www-data:www-data nuBuilderPro/
RUN chmod a+x -R  nuBuilderPro/
WORKDIR /var/www/html/nuBuilderPro
COPY config.php config.php
RUN apache2ctl graceful
