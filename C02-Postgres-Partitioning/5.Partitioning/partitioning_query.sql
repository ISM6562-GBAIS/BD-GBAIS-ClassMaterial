-- uncomment one, as later selects will overwrite the screen output
--SELECT * FROM temperatures WHERE reading_date BETWEEN '2023-01-01' AND '2023-12-31';
--SELECT * FROM temperatures WHERE reading_date BETWEEN '2022-01-01' AND '2022-12-31';
--SELECT * FROM temperatures WHERE reading_date BETWEEN '2021-01-01' AND '2021-12-31';

-- in this example, postgres will seamlessly collect data across the partitions
--SELECT * FROM temperatures WHERE reading_date BETWEEN '2021-01-01' AND '2023-12-31';
