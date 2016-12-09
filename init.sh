# #!/bin/bash
mysql_root_pwd=1234
export DEBIAN_FRONTEND=noninteractive
export COMPOSER_ALLOW_SUPERUSER=1
#export ZEPHIRDIR=/usr/share/zephir
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

echo "============= INIT ============="

#
# #
# # Add Swap
# #
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
  php5.6 \
  php5.6-apcu \
  php5.6-bcmath \
  php5.6-bz2 \
  php5.6-cli \
  php5.6-curl \
  php5.6-dba \
  php5.6-dev \
  php5.6-dom \
  php5.6-gd \
  php-pear \
  php5.6-igbinary \
  php5.6-intl \
  php5.6-imagick \
  php5.6-imap \
  php5.6-mbstring \
  php5.6-mcrypt \
  php5.6-memcached \
  php5.6-memcache \
  php5.6-mongo \
  php5.6-mongodb \
  php5.6-mysqli \
  php5.6-pgsql \
  php5.6-soap \
  php5.6-xdebug \
  php5.6-xsl \
  php5.6-xml \
  php5.6-zip

#
# MySQL
#
debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password password ${mysql_root_pwd}"
debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password_again password ${mysql_root_pwd}"
apt-get -y install mysql-server-5.6
