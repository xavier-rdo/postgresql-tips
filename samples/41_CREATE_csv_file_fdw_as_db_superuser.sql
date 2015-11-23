-- FOREIGN DATA WRAPPER EXAMPLE
-- As an example, save the following data in a customer.csv in your home directory :

/*
1, Dostoievski, Fedeor, Saint-Petersbourg
2, Barbusse, Henri, Asnières
3, Cendrars, Blaise, Genève
 */

-- Update the path in the OPTIONS of the CREATE FOREIGN TABLE command (see below)
-- according to your settings
-- Run this script as a superuser
-- Run the following SQL command : SELECT * FROM external.customer

CREATE EXTENSION file_fdw;

CREATE SCHEMA external;

CREATE SERVER external_customer_data FOREIGN DATA WRAPPER file_fdw;

CREATE FOREIGN TABLE external.customer (
    id INT,
    lastname VARCHAR(100),
    firstname VARCHAR(100),
    city VARCHAR(100)
) SERVER external_customer_data
OPTIONS ( filename '/home/xavier/customer.csv', format 'csv');

-- Only a superuser can create an extension, a server or a foreign table
-- => grant all privileges to role 'xavier' on the foreign table :
GRANT ALL PRIVILEGES ON external.customer TO xavier;
GRANT USAGE ON SCHEMA external TO xavier;
