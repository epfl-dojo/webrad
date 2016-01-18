# docker build -t epfl-dojo/php .
FROM php:5.6-apache
MAINTAINER epfl-dojo

ENV DEBIAN_FRONTEND noninteractive
# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

RUN rm /etc/apache2/mods-available/php5.load
RUN apt-get update && apt-get -y install \
        php5-mcrypt php5-common php5-mysql php5-mcrypt php5-curl\
        libapache2-mod-php5 \
        git \
	vim 

RUN a2enmod php5

WORKDIR /var/www
RUN git clone https://github.com/nuSoftware/nuBuilderPro.git
## http://localhost:8080/nuBuilderPro/nuinstall.php

COPY nuBuilder-vhost.conf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /var/www/nuBuilderPro
COPY config.php config.php
RUN chown -R www-data:www-data .
RUN chmod a+x -R .


RUN apache2ctl graceful
