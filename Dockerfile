# Use the official centos as the base image
FROM centos:8

# Version
ENV MEDIAWIKI_MAJOR_VERSION 1.41
ENV MEDIAWIKI_VERSION 1.41.0

# Install required packages
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN dnf module reset php
RUN dnf module enable -y php:7.4
RUN dnf install -y wget \
                   httpd \
                   php \
                   php-mysqlnd \
                   php-gd php-xml \
                   mariadb \
                   php-mbstring \
                   php-json \
                   mod_ssl \
                   php-intl \
                   php-apcu \
                   openssl

# Copy the MediaWiki files to the Apache document root
RUN cd /var/www/html; \
    curl -fSL "https://releases.wikimedia.org/mediawiki/${MEDIAWIKI_MAJOR_VERSION}/mediawiki-${MEDIAWIKI_VERSION}.tar.gz" -o mediawiki.tar.gz; \
    curl -fSL "https://releases.wikimedia.org/mediawiki/${MEDIAWIKI_MAJOR_VERSION}/mediawiki-${MEDIAWIKI_VERSION}.tar.gz.sig" -o mediawiki.tar.gz.sig; \
    gpg --batch --keyserver keyserver.ubuntu.com --recv-keys \
                D7D6767D135A514BEB86E9BA75682B08E8A3FEC4 \
                441276E9CCD15F44F6D97D18C119E1A64D70938E \
                F7F780D82EBFB8A56556E7EE82403E59F9F8CD79 \
                1D98867E82982C8FE0ABC25F9B69B3109D3BB7B0 \
        ; \
    gpg --verify mediawiki.tar.gz.sig mediawiki.tar.gz; \
    tar --strip-components=1 -zxf mediawiki.tar.gz; \
    rm -f mediawiki.tar.gz.sig mediawiki.tar.gz; \
    chown -R apache:apache /var/www/html

# dummy cert
RUN openssl req -newkey rsa:2048 -nodes -keyout /etc/pki/tls/private/localhost.key -x509 -days 3650 -nodes \
                -subj "/C=US/ST=CA/L=CA/O=MW/OU=WIKI/CN=localhost" \
                -out /etc/pki/tls/certs/localhost.crt


RUN systemctl enable httpd

# Expose the Apache port
EXPOSE 80

# Start Apache
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]