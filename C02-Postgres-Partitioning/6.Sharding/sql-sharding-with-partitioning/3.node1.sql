CREATE EXTENSION IF NOT EXISTS postgres_fdw;

DROP SCHEMA IF EXISTS sharding_schema CASCADE;
CREATE SCHEMA sharding_schema;
SET search_path = sharding_schema;

DROP TABLE IF EXISTS temperatures, temps_default;

-- create master partitioned table
CREATE TABLE temperatures (
    reading_date date,
    city VARCHAR(100),
    temperature DECIMAL
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


CREATE FOREIGN TABLE temps_2021
    PARTITION OF temperatures
    FOR VALUES FROM ('2021-01-01') TO ('2022-01-01')
    SERVER node2;

CREATE FOREIGN TABLE temps_2022
    PARTITION OF temperatures
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01')
    SERVER node3;

CREATE FOREIGN TABLE temps_2023
    PARTITION OF temperatures
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01')
    SERVER node2;