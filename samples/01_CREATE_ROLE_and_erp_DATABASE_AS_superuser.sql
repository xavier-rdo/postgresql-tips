-- SQL Commands to be executed as a superuser : psql -U postgres -h 127.O.O.1
CREATE ROLE xavier LOGIN PASSWORD 'xavier';
CREATE DATABASE erp;
ALTER DATABASE erp OWNER TO xavier;

-- USAGE : psql -U xavier -h 127.0.0.1 erp
-- (in order to access the newly created database as xavier
-- Password : see above ...)
