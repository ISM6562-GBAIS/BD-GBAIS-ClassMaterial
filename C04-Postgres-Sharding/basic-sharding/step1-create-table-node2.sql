-- create a schema for our project
DROP SCHEMA node2_schema CASCADE;
CREATE SCHEMA node2_schema;

-- for information purposes only, show all schemas
SHOW search_path;

-- set the search path to node2_schema 
SET search_path TO node2_schema;

-- create table foo. This table will be created in the node2_schema
CREATE TABLE foo (
    a int PRIMARY KEY,
    b VARCHAR(100)
);

-- The following will drop the schema. You may want to do
-- this after testing to 'clean things up'
-- DROP SCHEMA node2_schema CASCADE;