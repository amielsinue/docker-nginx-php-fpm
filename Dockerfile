FROM ubuntu:14.04
MAINTAINER Amiel Yanez <amielsinue@gmail.com>

# there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN rm /var/lib/apt/lists/* -vRf && \
apt-get update && \
apt-get install -y software-properties-common && \
apt-get install -y python-software-properties 

RUN BUILD_PACKAGES="supervisor mysql-server mysql-client bash-completion nginx php5 php5-cli php5-common php5-fpm php5-cgi php-pear php5-mysql php5-curl screen memcached php5-memcached expect expect-dev htop imagemagick python-mechanize php5-mcrypt dialog tmux multitail unzip vim" && \
apt-get install -y $BUILD_PACKAGES --fix-missing

RUN apt-get remove --purge -y software-properties-common && \
apt-get autoremove -y && \
apt-get clean && \
apt-get autoclean 

# Supervisor Config
ADD config/supervisord.conf /etc/supervisord.conf

# Setup Volume
#VOLUME ["/usr/share/nginx/html"]

ADD scripts/start.sh /start.sh
RUN chmod 775 /start.sh

ADD src/ /var/www/
RUN chown -Rf www-data.www-data /var/www/
RUN rm -rf /etc/nginx/sites-available/* && rm -rf /etc/nginx/sites-enabled/*
ADD config/nginx/sites-available/default /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

EXPOSE 80
EXPOSE 443

CMD ["/bin/bash","/start.sh"]
