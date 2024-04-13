--grant usage on schema public to public;
--grant create on schema public to public;

CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SCHEMA IF NOTE EXISTS node1_schema;

DROP TABLE IF EXISTS temperatures, temps_2023, temps_2022, temps_2021, temps_default;

-- create master partitioned table
CREATE TABLE IF NOT EXISTS temperatures (
    reading_date date,
    city VARCHAR(100),
    temp DECIMAL
) PARTITION BY RANGE (reading_date);

CREATE TABLE temps_default 
   PARTITION OF temperatures DEFAULT;
   
-- create servers 
CREATE SERVER IF NOT EXISTS node2 FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'postgres_node2', dbname 'shard2');

CREATE SERVER IF NOT EXISTS node3 FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'postgres_node3', dbname 'shard3');
	
-- create user mappings
CREATE USER MAPPING IF NOT EXISTS FOR user1 SERVER node2
    OPTIONS (user 'user2', password 'password2');

CREATE USER MAPPING IF NOT EXISTS FOR user1 SERVER node3
    OPTIONS (user 'user3', password 'password3');


IMPORT FOREIGN SCHEMA node2_schema LIMIT TO (temps_2023)
    FROM SERVER node2 INTO node1_schema;

IMPORT FOREIGN SCHEMA node2_schema LIMIT TO (temps_2021)
    FROM SERVER node2 INTO node1_schema;

IMPORT FOREIGN SCHEMA node3_schema LIMIT TO (temps_2022)
    FROM SERVER node3 INTO node1_schema;

-- attach partitions
ALTER TABLE temperatures ATTACH PARTITION temps_2023
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

ALTER TABLE temperatures ATTACH PARTITION temps_2022
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

ALTER TABLE temperatures ATTACH PARTITION temps_2021
    FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

--DROP TABLE IF EXISTS locations;
--CREATE TABLE locations (
--    ID SERIAL PRIMARY KEY,
--    reading_date date FOREIGN KEY REFERENCES temperatures(reading_date),
--    city VARCHAR(100),
--    node VARCHAR(100)
--);

