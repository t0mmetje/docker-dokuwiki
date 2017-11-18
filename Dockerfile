# Debian 8.9
# Apache 2.4.10
# PHP 7.1.11
# DokuWiki 2017-02-19e

FROM php:7.1.11-apache-jessie
MAINTAINER Tom Marcoen <tom@azmei.org>

ADD dokuwiki-apache.conf /etc/apache2/sites-available/dokuwiki.conf

RUN curl -O -L "https://download.dokuwiki.org/src/dokuwiki/dokuwiki-2017-02-19e.tgz" \
    && tar -xzf dokuwiki-2017-02-19e.tgz --strip 1 \
    && rm dokuwiki-2017-02-19e.tgz \
    && rm /etc/apache2/sites-enabled/000-default.conf \
    && chown -R www-data:www-data /var/www/html \
    && a2ensite dokuwiki.conf
