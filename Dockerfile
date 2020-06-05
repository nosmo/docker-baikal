FROM ubuntu:18.04
MAINTAINER nosmo@nosmo.me

ENV HOSTNAME my.dav.example.com

ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && apt-get install -y apache2 libapache2-mod-php php-sqlite3 curl sqlite3 php php-symfony-yaml php-twig php-sabre-dav composer php-zip

WORKDIR /var/www
COPY config/baikal.conf /etc/apache2/sites-available
COPY config/ports.conf /etc/apache2/
RUN sed -i "s/BK_HOSTNAME/$HOSTNAME/g" /etc/apache2/sites-available/baikal.conf
RUN a2enmod rewrite expires
RUN a2ensite baikal

RUN useradd -ms /bin/false baikal
RUN chown -R baikal /var/www/ /var/log/apache2 /var/run/apache2/
USER baikal
RUN curl https://codeload.github.com/sabre-io/Baikal/tar.gz/0.6.1 -o baikal.tar.gz && tar xzvf baikal.tar.gz && mv Baikal-0.6.1 baikal
COPY bin/apache2.sh /usr/local/bin/
WORKDIR /var/www/baikal
RUN composer install

ENTRYPOINT ["/usr/local/bin/apache2.sh"]
