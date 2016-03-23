
chown -Rf www-data.www-data /usr/share/nginx/html/

/usr/bin/supervisord -n -c /etc/supervisord.conf
