-- NOTE: If you are rerunning this SQL script, and node1_schema exists on node one you must first drop that
-- schema on node1. Failure to do this will result in the following script seemingly runs OK, but the
-- tables will not be created. 


-- create a schema for our project
DROP SCHEMA IF EXISTS sharding_schema CASCADE;
CREATE SCHEMA sharding_schema;
SET search_path = sharding_schema;

CREATE TABLE temps_2023 (
    reading_date date,
    city VARCHAR(100),
    temperature DECIMAL
);

CREATE TABLE temps_2021 (
    reading_date date,
    city VARCHAR(100),
    temperature DECIMAL
);