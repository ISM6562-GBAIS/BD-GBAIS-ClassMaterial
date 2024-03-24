-- create a schema for our project
CREATE SCHEMA IF NOT EXISTS node3_schema;
SET search_path TO node3_schema;

DROP TABLE IF EXISTS temps_2022;

CREATE TABLE IF NOT EXISTS temps_2022 (
    reading_date date PRIMARY KEY,
    city VARCHAR(100),
    temp DECIMAL
);

