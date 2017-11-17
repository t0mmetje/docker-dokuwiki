# Debian Jessie
# Apache
# PHP 7.1.11
# DokuWiki 2017-02-19e

FROM php:7.1.11-apache-jessie
MAINTAINER Tom Marcoen <tom@azmei.org>

RUN curl -O -L "https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz"


EXPOSE 80
#CMD ["apache2-foreground"]
