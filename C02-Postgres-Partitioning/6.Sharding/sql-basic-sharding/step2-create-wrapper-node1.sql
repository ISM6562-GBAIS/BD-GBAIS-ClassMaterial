-- before running this script, create table foo on postgres_node2

--Uncomment the following line to enable postgres_fdw. you only need to do this once
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SCHEMA node1_schema;

CREATE SERVER IF NOT EXISTS node2 FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'postgres_node2', dbname 'shard2');

CREATE USER MAPPING IF NOT EXISTS FOR user1 SERVER node2
    OPTIONS (user 'user2', password 'password2');
	
IMPORT FOREIGN SCHEMA node2_schema LIMIT TO (foo)
    FROM SERVER node2 INTO node1_schema;