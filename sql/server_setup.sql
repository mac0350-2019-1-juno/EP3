BEGIN;
DROP SERVER IF EXISTS juno_database_server CASCADE;
DROP ROLE IF EXISTS dba;


CREATE  ROLE dba
  WITH    SUPERUSER
          CREATEDB
          CREATEROLE
  LOGIN   ENCRYPTED PASSWORD 'dba1234'
  VALID   UNTIL '2019-07-01';

CREATE SERVER juno_database_server
  FOREIGN DATA WRAPPER postgres_fdw
  OPTIONS (host '127.0.0.1', dbname 'juno_people');

CREATE USER MAPPING for dba
  SERVER juno_database_server
  OPTIONS (user 'dba', password 'dba1234');

CREATE USER MAPPING for postgres
  SERVER juno_database_server
  OPTIONS (user 'dba', password 'dba1234');


GRANT USAGE ON FOREIGN DATA WRAPPER postgres_fdw TO postgres;
GRANT USAGE ON FOREIGN SERVER juno_database_server TO postgres;

DROP SCHEMA IF EXISTS app;
CREATE SCHEMA app;

COMMIT;
