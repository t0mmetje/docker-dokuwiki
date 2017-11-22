# Debian 8.9
# Apache 2.4.10
# PHP 7.1.11
# DokuWiki 2017-02-19e
# Bootstrap3 with Cerulean theme

FROM php:7.1.11-apache-jessie
LABEL maintainer="tom@azmei.org"

RUN apt-get update \
    && apt-get upgrade -y

# Copy the Apache configuration file
COPY dokuwiki-apache.conf /etc/apache2/sites-available/dokuwiki.conf

# Copy the three configuration files created by install.php
COPY acl.auth.php /var/www/html/conf/
COPY local.php /var/www/html/conf/
COPY users.auth.php /var/www/html/conf/

# Download and setup DokuWiki
RUN curl -O -L "https://download.dokuwiki.org/src/dokuwiki/dokuwiki-2017-02-19e.tgz" \
    && tar -xzf dokuwiki-2017-02-19e.tgz --strip 1 \
    && rm dokuwiki-2017-02-19e.tgz \
    && rm /var/www/html/install.php \
    && rm /etc/apache2/sites-enabled/000-default.conf \
    && chown -R www-data:www-data /var/www/html \
    && a2ensite dokuwiki.conf \
    && a2enmod rewrite

# Download and install the Bootstrap3 template and additional plugins
RUN apt-get install unzip \
    && curl -o bootstrap3.zip https://codeload.github.com/LotarProject/dokuwiki-template-bootstrap3/legacy.zip/master \
    && unzip bootstrap3.zip -d lib/tpl/ \
    && mv lib/tpl/LotarProject-dokuwiki-template-bootstrap3-*/ lib/tpl/bootstrap3 \
    && rm bootstrap3.zip \
    && curl -o bootstrap-wrapper.zip https://codeload.github.com/LotarProject/dokuwiki-plugin-bootswrapper/legacy.zip/master \
    && unzip bootstrap-wrapper.zip -d lib/plugins/ \
    && mv lib/plugins/LotarProject-dokuwiki-plugin-bootswrapper-*/ lib/plugins/bootswrapper \
    && rm bootstrap-wrapper.zip \
    && curl -o icons.zip https://codeload.github.com/LotarProject/dokuwiki-plugin-icons/legacy.zip/master \
    && unzip icons.zip -d lib/plugins/ \
    && mv lib/plugins/LotarProject-dokuwiki-plugin-icons-*/ lib/plugins/icons \
    && rm icons.zip \
    && rm -rf lib/plugins/authmysql \
    && rm -rf lib/plugins/authpgsql \
    && chown -R www-data:www-data /var/www/html

# Enable volumes for the data/ directory as well as the plugins/ and tpl/ directories.
VOLUME ["/var/www/html/data/", \
        "/var/www/html/lib/plugins/", \
        "/var/www/html/lib/tpl/", \
        "/var/www/html/conf/"]
