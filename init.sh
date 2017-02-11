# #!/bin/bash
# export DEBIAN_FRONTEND=noninteractive
# export COMPOSER_ALLOW_SUPERUSER=1
# #export ZEPHIRDIR=/usr/share/zephir
# export LANGUAGE=en_US.UTF-8
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

VAGRANT_PHP_VERSION=$(echo "$1")
VAGRANT_MYSQL_ROOT_PWD=$(echo "$2")

echo "============= INIT ============="


#
# Add Swap
#
sudo dd if=/dev/zero of=/swapspace bs=1M count=2048
sudo mkswap /swapspace
sudo swapon /swapspace
echo "/swapspace none swap defaults 0 0" >> /etc/fstab

#
# Setup locales
#
echo -e "LC_CTYPE=en_US.UTF-8\nLC_ALL=en_US.UTF-8\nLANG=en_US.UTF-8\nLANGUAGE=en_US.UTF-8" | tee -a /etc/environment &>/dev/null
locale-gen en_US en_US.UTF-8
dpkg-reconfigure locales

#
# Add php repository
#
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update

#
# Base system
#
sudo apt-get install -y htop \
  aptitude \
  mc \
  curl \
  git \
  memcached \
  unzip

#
# Base nginx
#
sudo apt-get install -y nginx

#
# Base PHP
#
sudo apt-get install -y --no-install-recommends \
  php${VAGRANT_PHP_VERSION} \
  php${VAGRANT_PHP_VERSION}-fpm \
  php${VAGRANT_PHP_VERSION}-apcu \
  php${VAGRANT_PHP_VERSION}-bcmath \
  php${VAGRANT_PHP_VERSION}-bz2 \
  php${VAGRANT_PHP_VERSION}-cli \
  php${VAGRANT_PHP_VERSION}-curl \
  php${VAGRANT_PHP_VERSION}-dba \
  php${VAGRANT_PHP_VERSION}-dev \
  php${VAGRANT_PHP_VERSION}-dom \
  php${VAGRANT_PHP_VERSION}-gd \
  php-pear \
  php${VAGRANT_PHP_VERSION}-igbinary \
  php${VAGRANT_PHP_VERSION}-intl \
  php${VAGRANT_PHP_VERSION}-imagick \
  php${VAGRANT_PHP_VERSION}-imap \
  php${VAGRANT_PHP_VERSION}-mbstring \
  php${VAGRANT_PHP_VERSION}-mcrypt \
  php${VAGRANT_PHP_VERSION}-memcached \
  php${VAGRANT_PHP_VERSION}-memcache \
  php${VAGRANT_PHP_VERSION}-mongo \
  php${VAGRANT_PHP_VERSION}-mongodb \
  php${VAGRANT_PHP_VERSION}-mysqli \
  php${VAGRANT_PHP_VERSION}-pdo \
  php${VAGRANT_PHP_VERSION}-pgsql \
  php${VAGRANT_PHP_VERSION}-soap \
  php${VAGRANT_PHP_VERSION}-xdebug \
  php${VAGRANT_PHP_VERSION}-xsl \
  php${VAGRANT_PHP_VERSION}-xml \
  php${VAGRANT_PHP_VERSION}-zip

#
# MySQL
#
debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password password ${VAGRANT_MYSQL_ROOT_PWD}"
debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password_again password ${VAGRANT_MYSQL_ROOT_PWD}"
apt-get -y install mysql-server-5.7

#
# NodeJS
#
sudo apt-get -y install nodejs
sudo apt-get -y install npm

#
# Bower
#
sudo npm install -g bower
