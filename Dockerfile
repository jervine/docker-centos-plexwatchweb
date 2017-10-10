# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jonathan Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates, and install plexWatchWeb
RUN yum install -y http://mirror.pnl.gov/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum update -y; yum clean all
RUN yum install -y install perl\(LWP::UserAgent\) perl-LWP-Protocol-https perl\(XML::Simple\) perl\(Pod::Usage\) perl\(JSON\) perl\(DBI\) perl\(Time::Duration\) perl\(Time::ParseDate\) perl\(DBD::SQLite\) httpd php unzip cronie supervisor php-pdo logrotate

RUN curl -L https://github.com/ecleese/plexWatchWeb/archive/master.zip -o /var/www/html/plexwatchweb.zip
RUN cd /var/www/html; unzip plexwatchweb.zip; rm -f plexwatchweb.zip; mv plexWatchWeb-master plexWatch; chown -R apache:apache /var/www/html/plexWatch; ln -s plexWatch pw

ADD crontab /var/spool/cron/root
ADD start.sh /sbin/start.sh
ADD supervisord.conf /etc/supervisord.conf
ADD crond.ini /etc/supervisord.d/crond.ini
ADD apache.ini /etc/supervisord.d/apache.ini
RUN chmod 755 /sbin/start.sh

VOLUME /opt/plexWatch

EXPOSE 80 9003

ENTRYPOINT ["/sbin/start.sh"]
