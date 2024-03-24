## Foreign Data Wrapper

The foreign data wrapper functionality has existed in Postgres for some time. PostgreSQL lets you access data stored in other servers and systems using this mechanism. What we’re interested in is “postgres_fdw”, which is what will allow us to access one Postgres server from another.

“postgres_fdw” is an extension present in the standard distribution, that can be installed with the regular `CREATE EXTENSION` command:

```sql
CREATE EXTENSION postgres_fdw;
```

Let’s assume you have another PostgreSQL server “box2” with a database called “box2db”. You can create a [“foreign server”](https://www.postgresql.org/docs/current/sql-createserver.html) for this:

```sql
CREATE SERVER box2 FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'box2', dbname 'box2db');
``` 

Let’s also map our user “alice” (the user you’re logged in as) to box2 user “box2alice”. This allows “alice” to be “box2alice” when accessing remote tables (see [`CREATE USER MAPPING`](https://www.postgresql.org/docs/16/sql-createusermapping.html)):

```sql
CREATE USER MAPPING FOR alice SERVER box2
    OPTIONS (user 'box2alice');
``` 

You can now access tables on box2. First, create a table on box2, and then a “foreign table” on your server. The foreign table does not hold any actual data, but serves as a proxy for accessing the table on box2.

```sql
-- on box2
CREATE TABLE foo (a int);
```

```sql
-- on your server
IMPORT FOREIGN SCHEMA public LIMIT TO (foo)
    FROM SERVER box2 INTO public;
``` 

The foreign table in your server (box1) can participate in transactions the same way as normal tables. Applications do not have to know that the tables it interacts with are local or foreign – although if your app runs a SELECT which might pull in lots of rows from a foreign table it might slow things down. In Postgres 10, improvements were made for pushing down joins and aggregates to the remote server.

## Combining Partitioning and FDW

In the scenerio below, we have box1 and box2. We will create a partitioned table on box1, and two partition tables on box2. We will use sharding to store partitioned data on box2. We will set the default partition on box1. Also, we organize these tables in schemas, box1_schema and box2_schema.

First, let’s create the physical partition table on box2 (create these in box2_schema):

```sql
-- on box2
CREATE TABLE temperatures_2016 (
    reading_date      DATE,
    city    VARCHAR(100),
    temp    DECIMAL,
);

CREATE TABLE temperatures_2017 (
    reading_date      DATE,
    city    VARCHAR(100),
    temp    DECIMAL,
);
``` 

Create your partitioned table on Box1 (create these on the box1_schema)

```sql
-- on box1
-- create master partitioned table
CREATE TABLE IF NOT EXISTS temperatures (
    reading_date      DATE,
    city    VARCHAR(100),
    temp    DECIMAL,
) PARTITION BY RANGE (reading_date);

CREATE TABLE temps_default 
   PARTITION OF temperatures DEFAULT;
```

Create your server and user mapping on box1

```sql
-- on box1
-- create servers 
CREATE SERVER IF NOT EXISTS box2 FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'postgres_node2', dbname 'shard2');

-- create user mappings
CREATE USER MAPPING IF NOT EXISTS FOR user1 SERVER box2
    OPTIONS (user 'user2', password 'password2');
```

And then create the partition on your server, as a foreign table:

```sql
IMPORT FOREIGN SCHEMA box2_schema LIMIT TO (temperatures_2016)
    FROM SERVER box2 INTO box1_schema;

IMPORT FOREIGN SCHEMA box2_schema LIMIT TO (temperatures_2017)
    FROM SERVER box2 INTO box1_schema;
```

Now, you need to alter the partition table to use the partitions on box2:

```sql
-- attach partitions
ALTER TABLE temperatures ATTACH PARTITION temperatures_2016
    FOR VALUES FROM ('2016-01-01') TO ('2017-01-01');

ALTER TABLE temperatures ATTACH PARTITION temperatures_2016
    FOR VALUES FROM ('2017-01-01') TO ('2018-01-01');
```


You can now insert and query from your own server:

```sql
temp=# INSERT INTO temperatures (reading_date, city, temp)
temp-#     VALUES ('2016-08-03', 'London', 63);
INSERT 0 1
```

And query the data:

```sql
temp=# SELECT * FROM temperatures ORDER BY at;
| reading_date |  city  | temp |
------------+--------+----------
 2016-08-03 | London |      63 |    
(3 rows)
```

There you have it! You can now have your data sharded logically (partitions) and physically (FDW).

## Data Management

Commands like VACUUM and ANALYZE work as you’d expect with partition master tables – all local child tables are subject to VACUUM and ANALYZE. Partitions can be detached, it’s data manipulated without the partition constraint, and then reattached. Partition child tables themselves can be partitioned.

Moving data around (“resharding”) can be done with regular SQL statements (insert, delete, copy etc.). Partition-local indexes and triggers can be created.


## Adding redundancy to your shards

Adding redundancy to your shards is achieved with logical or streaming replication.

see https://www.enterprisedb.com/postgres-tutorials/postgresql-replication-and-automatic-failover-tutorial


## Conclusion

We have seen how to set up partitioning and sharding in PostgreSQL. The combination of these two features allows you to scale out your database, and to manage large amounts of data in a more efficient way. The foreign data wrapper functionality allows you to access data stored in other servers and systems, and to combine partitioning and FDW to shard your data across multiple servers.