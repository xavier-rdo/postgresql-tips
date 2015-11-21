# Commands to be executed as a superuser :
CREATE ROLE xavier LOGIN PASSWORD 'xavier';
CREATE DATABASE erp;
ALTER DATABASE erp OWNER TO xavier;
