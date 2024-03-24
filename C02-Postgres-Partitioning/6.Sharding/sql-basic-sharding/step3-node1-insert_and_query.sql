-- set the search path to node2_schema 
SET search_path TO node2_schema;

-- run the following on postgres_node1
INSERT INTO foo (a) VALUES (1);
INSERT INTO foo (a) VALUES (2);
INSERT INTO foo (a) VALUES (3);
INSERT INTO foo (a) VALUES (4);
INSERT INTO foo (a) VALUES (5);
INSERT INTO foo (a) VALUES (6);

-- run the following on postgres_node1
SELECT * FROM node1_schema.foo;

-- run the following on postgres_node2
--SELECT * FROM node2_schema.foo;


