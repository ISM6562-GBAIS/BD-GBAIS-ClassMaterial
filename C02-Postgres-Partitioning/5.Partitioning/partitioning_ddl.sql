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
   