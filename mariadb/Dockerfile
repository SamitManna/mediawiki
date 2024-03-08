# Use the official CentOS 8 image as the base
FROM centos:8

# Install required packages
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN dnf -y update \
    && dnf install -y \
    mariadb-server \
    mariadb \
    && dnf clean all

# Copy the configuration file
COPY my.cnf /etc/my.cnf

# Expose the MySQL port
EXPOSE 3306

# Create a database directory for persisting data
RUN mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql

# Set the root password for the first run
ENV MYSQL_ROOT_PASSWORD=your_root_password

# Start MariaDB service
CMD ["/usr/bin/mysqld_safe"]