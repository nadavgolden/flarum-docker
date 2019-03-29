FROM ubuntu:16.04
# install requirements
RUN apt update
RUN apt install -y nginx vim curl git software-properties-common unzip mariadb-client mariadb-server

# install mysql
RUN apt -y install expect
COPY mysql_install.sh /home/
RUN chmod 774 /home/mysql_install.sh
RUN /home/mysql_install.sh

# install php7.2 with extensions
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt update
RUN apt install -y php7.2-fpm php7.2-common php7.2-mbstring php7.2-xmlrpc php7.2-soap php7.2-mysql php7.2-gd php7.2-xml php7.2-cli php7.2-zip php7.2-curl

#install composer
RUN curl -sS https://getcomposer.org/installer |  php -- --install-dir=/usr/local/bin --filename=composer

# install flarum
WORKDIR /var/www/flarum
RUN composer create-project flarum/flarum . --stability=beta
RUN chmod -R 775 .
RUN chown -R www-data:www-data .

# setup nginx for flarum
RUN rm /etc/nginx/sites-enabled/default
COPY ./flarum.conf /etc/nginx/sites-available/flarum.conf
RUN ln -s /etc/nginx/sites-available/flarum.conf /etc/nginx/sites-enabled/

# copy some extra scripts
WORKDIR /home/
COPY start-flarum.sh /home/
RUN chmod 774 /home/*

EXPOSE 80

CMD /home/start-flarum.sh && tail -f /dev/null

