DROP TABLE IF EXISTS temperatures, temps_2023, temps_2022, temps_2021;

CREATE TABLE temperatures (
    reading_date date PRIMARY KEY,
    city VARCHAR(100),
    temp DECIMAL
) PARTITION BY RANGE (reading_date);

CREATE TABLE temps_2023
   PARTITION OF temperatures FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE temps_2022 
   PARTITION OF temperatures FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE temps_2021 
   PARTITION OF temperatures FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

CREATE TABLE temps_default 
   PARTITION OF temperatures DEFAULT;
   
INSERT INTO temperatures (reading_date, city, temp) VALUES ('2021-06-15', 'Tampa', 80);
INSERT INTO temperatures (reading_date, city, temp) VALUES ('2022-06-15', 'Tampa', 85);
INSERT INTO temperatures (reading_date, city, temp) VALUES ('2023-06-15', 'Tampa', 82);
INSERT INTO temperatures (reading_date, city, temp) VALUES ('2021-07-15', 'Tampa', 90);
INSERT INTO temperatures (reading_date, city, temp) VALUES ('2022-07-15', 'Tampa', 88);
INSERT INTO temperatures (reading_date, city, temp) VALUES ('2023-07-15', 'Tampa', 83);

-- uncomment one, as later selects will overwrite the screen output
--SELECT * FROM temperatures WHERE reading_date BETWEEN '2023-01-01' AND '2023-12-31';
--SELECT * FROM temperatures WHERE reading_date BETWEEN '2022-01-01' AND '2022-12-31';
--SELECT * FROM temperatures WHERE reading_date BETWEEN '2021-01-01' AND '2021-12-31';

-- in this example, postgres will seamlessly collect data across the partitions
--SELECT * FROM temperatures WHERE reading_date BETWEEN '2021-01-01' AND '2023-12-31';
