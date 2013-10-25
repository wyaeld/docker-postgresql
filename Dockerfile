FROM ubuntu:12.04
MAINTAINER Ben Firshman "ben@orchardup.com"

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

#Instructions as per https://wiki.postgresql.org/wiki/Apt
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >  /etc/apt/sources.list.d/pgdg.list

RUN wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

RUN apt-get -qq update
RUN locale-gen en_US.UTF-8

RUN LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive apt-get install -y -q postgresql-9.3 postgresql-contrib-9.3 postgresql-9.3-postgis libpq-dev sudo

# /etc/ssl/private can't be accessed from within container for some reason
# (@andrewgodwin says it's something AUFS related)
RUN mkdir /etc/ssl/private-copy; mv /etc/ssl/private/* /etc/ssl/private-copy/; rm -r /etc/ssl/private; mv /etc/ssl/private-copy /etc/ssl/private; chmod -R 0700 /etc/ssl/private; chown -R postgres /etc/ssl/private

ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

VOLUME ["/var/lib/postgresql"]
EXPOSE 5432
CMD ["/usr/local/bin/run"]

