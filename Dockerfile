FROM debian:12

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y \
    && apt install -y php8.2 php8.2-apcu php8.2-bcmath php8.2-bz2 php8.2-cgi php8.2-cli \
        php8.2-common php8.2-curl php8.2-fpm php8.2-gd php8.2-gmp php8.2-gnupg php8.2-http php8.2-imagick php8.2-imap \
        php8.2-intl php8.2-maxminddb php8.2-mbstring php8.2-mcrypt php8.2-memcache php8.2-memcached php8.2-mongodb \
        php8.2-msgpack php8.2-mysql php8.2-opcache php8.2-pgsql php8.2-redis php8.2-solr php8.2-zip \
        python3 libexpat1 apache2-utils ssl-cert libapache2-mod-php8.2 libapache2-mod-wsgi-py3 libapache2-mod-uwsgi \
        python3-webpy python3-peewee python3-jinja2 python3-requests \
    && rm -rf /var/lib/apt/lists/*

# TODO: make composer
# RUN cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
# RUN composer --working-dir=/var/www/html update

# TODO: make migrate
# RUN wget https://github.com/golang-migrate/migrate/releases/download/v4.15.2/migrate.linux-amd64.deb && \
#     dpkg -i migrate.linux-amd64.deb \
#     && rm -rf migrate.linux-amd64.deb

COPY ./apache2.conf /etc/apache2/sites-enabled/000-default.conf
COPY ./apache-foreground.sh /usr/local/bin/

# for stdout
RUN ln -sf /dev/stdout /var/log/apache2/access.log
RUN ln -sf /dev/stderr /var/log/apache2/error.log

CMD ["apache-foreground.sh"]