-- create a schema for our project
DROP SCHEMA IF EXISTS node3_schema CASCADE;
CREATE SCHEMA node3_schema;
SET search_path TO node3_schema;

CREATE TABLE IF NOT EXISTS temps_2022 (
    reading_date date PRIMARY KEY,
    city VARCHAR(100),
    temp DECIMAL
);

