docker-postgresql
=================

PostgreSQL for Docker.

$ docker run -d -p 5432:5432 -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker wyaeld/postgresql
    da809981545f
    $ createdb -h localhost -U docker test
    Password for user docker:
    $ psql -h localhost -U docker test
    Password for user docker:
    psql (9.1.9, server 9.1.3)
    Type "help" for help.

    test=#

(Example assumes PostgreSQL client is installed on Docker host.)

