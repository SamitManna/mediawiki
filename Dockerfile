# Use the official centos as the base image
FROM centos:7

# Version
ENV MEDIAWIKI_MAJOR_VERSION 1.34
ENV MEDIAWIKI_VERSION 1.34.4

RUN yum install -y \
    --setopt=tsflags=nodocs \
    centos-release-scl \
    curl
RUN yum install -y \
    --setopt=tsflags=nodocs \
    httpd24-httpd \
    rh-php73-php \
    rh-php73-php \
    rh-php73-php-mbstring \
    rh-php73-php-mysqlnd \
    rh-php73-php-gd \
    rh-php73-php-xml \
    && yum clean all

WORKDIR /opt/rh/httpd24/root/var/www/html

RUN curl -fSL "https://releases.wikimedia.org/mediawiki/${MEDIAWIKI_MAJOR_VERSION}/mediawiki-${MEDIAWIKI_VERSION}.tar.gz" -o mediawiki.tar.gz; \
    curl -fSL "https://releases.wikimedia.org/mediawiki/${MEDIAWIKI_MAJOR_VERSION}/mediawiki-${MEDIAWIKI_VERSION}.tar.gz.sig" -o mediawiki.tar.gz.sig; \
    gpg --batch --keyserver keyserver.ubuntu.com --recv-keys \
                D7D6767D135A514BEB86E9BA75682B08E8A3FEC4 \
                441276E9CCD15F44F6D97D18C119E1A64D70938E \
                F7F780D82EBFB8A56556E7EE82403E59F9F8CD79 \
                1D98867E82982C8FE0ABC25F9B69B3109D3BB7B0 \
        ; \
    gpg --verify mediawiki.tar.gz.sig mediawiki.tar.gz; \
    tar -zxf mediawiki.tar.gz; \
    mv mediawiki-${MEDIAWIKI_VERSION} mediawiki; \
    rm -f mediawiki.tar.gz.sig mediawiki.tar.gz

RUN sed -i -e 's|^DocumentRoot "/opt/rh/httpd24/root/var/www/html"|DocumentRoot "/opt/rh/httpd24/root/var/www/html/mediawiki"|' \
    -e 's|    DirectoryIndex index.html|    DirectoryIndex index.html index.html.var index.php|' \
    -e 's|^<Directory "/opt/rh/httpd24/root/var/www/html">|<Directory "/opt/rh/httpd24/root/var/www/html/mediawiki">|' \
    # -e 's|#ServerName*|ServerName 127.0.0.1:80|' \
    /opt/rh/httpd24/root/etc/httpd/conf/httpd.conf
RUN chown -R apache:apache /opt/rh/httpd24/root/var/www/html/mediawiki
RUN chmod 755 /opt/rh/httpd24/root/var/www/html/mediawiki/
RUN sed -i 's|^LoadModule http2_module modules/mod_http2.so|#LoadModule http2_module modules/mod_http2.so|' \
    /opt/rh/httpd24/root/etc/httpd/conf.modules.d/00-base.conf

# COPY LocalSettings.php /opt/rh/httpd24/root/var/www/html/mediawiki/

CMD /opt/rh/httpd24/root/usr/sbin/apachectl -DFOREGROUND