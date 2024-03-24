-- create a schema for our project
CREATE SCHEMA IF NOT EXISTS node2_schema;
SET search_path TO node2_schema;

DROP TABLE IF EXISTS temps_2023, temps_2021;

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