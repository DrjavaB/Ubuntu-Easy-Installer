#!/bin/bash
VERSION=8.3
PHP=php$VERSION
sudo apt install -y lsb-release gnupg2 ca-certificates apt-transport-https software-properties-common
sudo add-apt-repository -y ppa:ondrej/php ppa:ondrej/apache2 ppa:ondrej/nginx
sudo apt update -y
sudo apt install -y $PHP $PHP-{common,mysql,xml,xmlrpc,curl,gd,cli,dev,imap,mbstring,opcache,soap,zip,intl,redis,pgsql,fpm,bcmath,swoole,xdebug,imagick}
sudo systemctl enable --now $PHP-fpm
sudo a2enmod proxy_fcgi setenvif
sudo a2enconf $PHP-fpm
./ioncube.sh

sudo systemctl restart $PHP-fpm
