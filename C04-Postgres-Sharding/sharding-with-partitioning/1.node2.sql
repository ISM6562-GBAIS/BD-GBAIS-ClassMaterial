-- create a schema for our project
DROP SCHEMA IF EXISTS node2_schema CASCADE;
CREATE SCHEMA node2_schema;
SET search_path TO node2_schema;

CREATE TABLE IF NOT EXISTS temps_2023 (
    reading_date date PRIMARY KEY,
    city VARCHAR(100),
    temp DECIMAL
);

CREATE TABLE IF NOT EXISTS temps_2021 (
    reading_date date PRIMARY KEY,
    city VARCHAR(100),
    temp DECIMAL
);