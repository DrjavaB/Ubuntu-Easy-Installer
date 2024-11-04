#!/bin/bash

php_list=$(sudo update-alternatives --list php)
for php in $php_list; do
    version=${php: -3}
    extension_dir=$($php -ini | grep extension_dir | cut -d '>' -f3)
    file=ioncube/ioncube_loader_lin_$version.so
    if [ -f $file ]; then
        sudo cp $file $extension_dir/ioncube.so
        sudo touch /etc/php/$version/mods-available/ioncube.ini
        sudo bash -c "cat <<EOF >>/etc/php/$version/mods-available/ioncube.ini
; configuration for php ioncube loader module
; priority=00
zend_extension=ioncube.so
EOF"
    fi
done

sudo phpenmod ioncube
for php in $php_list; do
    php=$(echo $php | cut -d '/' -f4 | cut -f3)
    version=${php:3}
    sudo systemctl restart php$version-fpm
done
