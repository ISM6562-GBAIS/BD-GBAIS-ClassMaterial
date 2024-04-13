// This is CQL for Cassandra
DROP KEYSPACE w04;

// Create keyspace for a single node
CREATE KEYSPACE w04 WITH REPLICATION = { 
		  'class' : 'SimpleStrategy', 
		  'replication_factor' : 3 
}; 

// create a student table for testing
CREATE TABLE IF NOT EXISTS w04.student ( 
    student_id INT, 
    f_name TEXT, 
    l_name TEXT, 
    course TEXT,
    grade FLOAT, 
    PRIMARY KEY(course, grade, student_id)
);

// insert values into student table
INSERT INTO w04.student (student_id, f_name, l_name, course, grade)     
    VALUES (200,'Tim', 'Smith', 'ISM6564', 95);
INSERT INTO w04.student (student_id, f_name, l_name, course, grade)     
    VALUES (200,'Frank', 'Smith', 'ISM6564', 91);
INSERT INTO w04.student (student_id, f_name, l_name, course, grade)     
    VALUES (201,'John', 'Jones', 'ISM6562', 97);
INSERT INTO w04.student (student_id, f_name, l_name, course, grade)     
    VALUES (202,'Jane', 'Williams', 'ISM6562', 81);
INSERT INTO w04.student (student_id, f_name, l_name, course, grade)     
    VALUES (202,'Sandy', 'Williams', 'ISM6136', 86);
INSERT INTO w04.student (student_id, f_name, l_name, course, grade)     
    VALUES (202,'Jane', 'Hollister', 'ISM6562', 78)
INSERT INTO w04.student (student_id, f_name, l_name, course, grade)     
    VALUES (202,'Susan', 'Sanders', 'ISM6562', 93);

// query the student table
SELECT * from w04.student;

// select students in a course with a grade above 95
SELECT * from w04.student where course = 'ISM6562' and grade > 95;

// select students with a grade above 95
SELECT * from w04.student where grade > 95;

// The above query will generate and error. You can make this work by allowing filtering, but this is not a good idea.
SELECT * from w04.student where grade > 95 ALLOW FILTERING;

// For small datasets, this is not a problem, but for large datasets, this is a problem. When we specify the 
// course = 'ISM6562', this is used to find the partition, then the grade > 95 processing can remain within one
// node. In the case where we only have grade > 95, then this is requiring cassandra to look across all node. 
// Doing this results in network traffic, and can slow the database considerable if you have very large datasets. 
// This is a problem with Cassandra, and you need to be aware of this. Unless you have a 'big data' problem, then
// you should be fine to ALLOW FILTERING. If you have a big data problem, then you need to think about how to
// structure your data to avoid this problem.

/// NOTE: You can add an index on the grade column, and this will allow you to search for equality
CREATE INDEX ON w04.student(grade); // create index on column

SELECT * from w04.student where grade = 97; // now this works without having to use ALLOW FILTER

// BUT, you still cannot do a range query on the grade column without ALLOW FILTERING.
SELECT * from w04.student where grade > 95; // will not work unless you ALLOW FILTERING


// Clean things up
DROP KEYSPACE w04;

// exit cql
exit
