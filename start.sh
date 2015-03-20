#!/bin/bash
##
## Start up script for plexWatch/Web on CentOS docker container
##

## Initialise any variables being called:
# Set the correct timezone for PHP
PHP_TZ=${TZ:-UTC}
PHP_TZ_CONT=`echo $PHP_TZ | awk 'BEGIN { FS="/" } { print $1 }'`
PHP_TZ_CITY=`echo $PHP_TZ | awk 'BEGIN { FS="/" } { print $2 }'`

# Configure the PHP timezone correctly:
if [ "$PHP_TZ_CITY" = "" ]; then
  sed -i "s/;date.timezone =/date.timezone = ${PHP_TZ_CONT}/" /etc/php.ini
else
  sed -i "s/;date.timezone =/date.timezone = ${PHP_TZ_CONT}\/${PHP_TZ_CITY}/" /etc/php.ini
fi
mv /etc/localtime /etc/localtime.orig
cp /usr/share/zoneinfo/$PHP_TZ /etc/localtime

## Start up icinga2 and apache web server daemons via supervisord
/usr/bin/supervisord -n -c /etc/supervisord.conf
