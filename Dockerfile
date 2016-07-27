FROM ubuntu:16.10
MAINTAINER Alec Papierniak <alec@papierniak.net>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Copy config files and scripts
ADD ./start.sh /start.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD ./supervisord.conf /etc/supervisord.conf
ADD https://download.moodle.org/download.php/direct/stable31/moodle-3.1.1.tgz /var/www/moodle-latest.tgz


# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl && \
	ln -sf /bin/true /sbin/initctl && \
	apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y mysql-server-5.7 mysql-client-5.7 pwgen python-setuptools curl unzip apache2-bin apache2-data apache2-utils cpio dh-python fontconfig-config fonts-dejavu-core libapache2-mod-php7.0 libapr1 libaprutil1 libaprutil1-dbd-sqlite3 libaprutil1-ldap libcurl3 libfontconfig1 libfreetype6 libgd3 libgpm2 libicu57 libjbig0 libjpeg-turbo8 libjpeg8 liblua5.1-0 libmpdec2 libpng16-16 libpython3-stdlib libpython3.5 libpython3.5-minimal libpython3.5-stdlib libtiff5 libwebp5 libxml2 libxmlrpc-epi0 libxpm4 libxslt1.1 php-common php7.0 php7.0-cli php7.0-common php7.0-curl php7.0-gd php7.0-intl php7.0-json php7.0-mysql php7.0-opcache php7.0-readline php7.0-xml php7.0-xmlrpc python-meld3 python3 python3-minimal python3.5 python3.5-minimal sgml-base ssl-cert ucf xml-core php7.0-zip php7.0-mbstring php7.0-soap less supervisor && \
	sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf && \
	easy_install supervisor && \
	cd /var/www; rm -rf html/*; tar zxvf moodle-latest.tgz; mv /var/www/moodle/* /var/www/html; rm -rf /var/www/moodle && \
	chown -R www-data:www-data /var/www/html && \
	mkdir /var/moodledata && \
	chown -R www-data:www-data /var/moodledata; chmod 777 /var/moodledata && \
	chmod 755 /start.sh /etc/apache2/foreground.sh

EXPOSE 22 80
