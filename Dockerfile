FROM httpd:2.4

COPY apache/app.conf /usr/local/apache2/conf/conf.d/app.conf
