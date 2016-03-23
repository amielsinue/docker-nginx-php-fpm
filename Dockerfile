FROM ubuntu:14.04
MAINTAINER Amiel Yanez <amielsinue@gmail.com>

# there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
apt-get install -y software-properties-common && \
apt-get install -y python-software-properties && \
apt-get update && \
add-apt-repository ppa:brianmercer/php5

# Packages
BUILD_PACKAGES="supervisor mysql-server mysql-client bash-completion nginx php5 php5-cli php5-common php5-fpm php5-cgi php-pear php5-mysql php5-curl screen memcached php5-memcached expect expect-dev htop imagemagick php5-suhosin python-mechanize php5-mcrypt dialog tmux multitail unzip zipe xuberant-ctags"

apt-get update
apt-get install -y $BUILD_PACKAGES --fix-missing
apt-get remove --purgue -y software-properties-common && \
apt-get autoremove -y && \
apt-get clean && \
apt-get autoclean 

