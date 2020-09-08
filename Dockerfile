FROM phusion/baseimage:0.11

MAINTAINER Adib Adipraditya "adhinepraditya@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
CMD ["/sbin/my_init"]

# Install nginx
RUN apt-get update && apt-get install -y nginx zip unzip

# Install php 7.3
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y php7.3-fpm php7.3-cli php7.3-mysql php7.3-gd php7.3-imagick php7.3-recode php7.3-tidy php7.3-xmlrpc php7.3-common php7.3-curl php7.3-mbstring php7.3-xml php7.3-bcmath php7.3-bz2 php7.3-intl php7.3-json php7.3-readline php7.3-zip

RUN mkdir -p /var/www/src
RUN chown -R $(whoami):$(whoami) /var/www/src/
RUN chmod -R 755 /var/www

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add nginx and php config
ADD default /etc/nginx/sites-available/default
ADD php.ini /etc/php/7.3/fpm/php.ini

# Install supervisor
RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor

# Supervisor conf
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /var/www/src/

# Create socker
RUN mkdir -p /run/php

# Ports: nginx
EXPOSE 8080
#443

CMD ["/usr/bin/supervisord"]