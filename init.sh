# #!/bin/bash
mysql_root_pwd=1234
php_version=7.1
export DEBIAN_FRONTEND=noninteractive
export COMPOSER_ALLOW_SUPERUSER=1
#export ZEPHIRDIR=/usr/share/zephir
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

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
  php$php_version \
  php$php_version-apcu \
  php$php_version-bcmath \
  php$php_version-bz2 \
  php$php_version-cli \
  php$php_version-curl \
  php$php_version-dba \
  php$php_version-dev \
  php$php_version-dom \
  php$php_version-gd \
  php-pear \
  php$php_version-igbinary \
  php$php_version-intl \
  php$php_version-imagick \
  php$php_version-imap \
  php$php_version-mbstring \
  php$php_version-mcrypt \
  php$php_version-memcached \
  php$php_version-memcache \
  php$php_version-mongo \
  php$php_version-mongodb \
  php$php_version-mysqli \
  php$php_version-pdo \
  php$php_version-pgsql \
  php$php_version-soap \
  php$php_version-xdebug \
  php$php_version-xsl \
  php$php_version-xml \
  php$php_version-zip

#
# MySQL
#
debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password password ${mysql_root_pwd}"
debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password_again password ${mysql_root_pwd}"
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
