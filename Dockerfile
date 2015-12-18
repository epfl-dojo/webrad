FROM php:5.6-apache
MAINTAINER epfl-dojo

ENV DEBIAN_FRONTEND noninteractive

RUN rm /etc/apache2/mods-available/php5.load
RUN apt-get update && apt-get -y install \
        php5-mcrypt php5-mysql \
        libapache2-mod-php5
