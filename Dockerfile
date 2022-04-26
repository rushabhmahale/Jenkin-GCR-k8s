FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install apache2 -y
RUN apt-get install apache2-utils -y
RUN echo 'ServerName 127.0.0.1' >> /etc/apache2/apache2.conf
COPY /website /var/www/html
EXPOSE 80
CMD ["apache2ctl","-D","FOREGROUND"]
