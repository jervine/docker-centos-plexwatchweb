# docker-centos-plexwatchweb
## plexWatchWeb running on CentOS 7.4
### Build Number: 3
Date of Build: 10th October 2017

CentOS 7 container with Apache2, cron, plexWatch and plexWatchWeb installed. The EPEL repository is added for some perl requirements and the supervisor daemon.

The /opt/plexWatch volume should be imported from a host filesystem, as this contains the actual plexWatch data. The supervisor daemon is responsible for managing the httpd and crond processes and has a web based management utility exposed on port 9003 with a default username and password combination of admin:admin.

The container can be started as follows:

    docker run -d -h <hostname of container> -n <name of container> -e TZ="Europe/London" -v <location of plexWatch on host>:/opt/plexWatch -p 80:80 -p 9003:9003 jervine/docker-centos-plexwatchweb
  
The TZ variable if not set will default ot using UTC.
