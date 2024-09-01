/*
Q1. There are two tables. 
•	Customers: name, address, age, customer_id, 
•	Transactions: transaction_id, amount, customer_id, transaction_date, transaction_mode, bank_name 
Write a query to fetch the first transaction of the day for each customer?
*/

CREATE TABLE Customers (
    name VARCHAR(100),
    address VARCHAR(255),
    age INT,
    customer_id INT PRIMARY KEY
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    amount DECIMAL(10, 2),
    customer_id INT,
    transaction_date TIMESTAMP,
    transaction_mode VARCHAR(50),
    bank_name VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert into Customers
INSERT INTO Customers (name, address, age, customer_id) VALUES
('Nagesh', 'Bhimavaram', 25, 1),
('Siva', 'Vishakapatnam', 25, 2),
('Gopi', 'Ganapavaram', 24, 3),
('Damodar','Vempalli',25,4);

-- Insert into Transactions with timestamp
INSERT INTO Transactions (transaction_id, amount, customer_id, transaction_date, transaction_mode, bank_name) VALUES
(1, 100.00, 1,  '2024-09-01 09:15:00', 'Credit', 'SBI'),
(2, 200.00, 1,  '2024-09-01 16:30:00', 'Credit', 'SBI'),
(3, 75.00,  2,  '2024-09-01 10:00:00', 'Debit',  'UBI'),
(4, 50.00,  2,  '2024-09-01 11:30:00', 'Credit', 'UBI'),
(5, 120.00, 2,  '2024-09-01 14:00:00', 'Debit',  'UBI'),
(6, 300.00, 3,  '2024-09-01 08:00:00', 'Debit',  'PNB'),
(7, 75.00,  3,  '2024-09-01 14:00:00', 'Debit',  'PNB'),
(8, 250.00, 4, '2024-09-01 10:27:51', 'Debit',  'HDFC'),
(9, 1000.00,4, '2024-09-01 11:45:25', 'Credit', 'HDFC'),
(10, 500.00, 4, '2024-09-01 13:00:00', 'Debit',  'HDFC'),
(11, 200.00, 3,  '2024-09-01 16:45:00', 'Credit', 'PNB'),
(12, 300.00, 4, '2024-09-01 15:30:00', 'Credit', 'HDFC'),
(13, 150.00, 1,  '2024-09-01 13:45:00', 'Debit',  'SBI'),
(14, 80.00,  4, '2024-09-01 16:00:00', 'Debit',  'HDFC'),
(15, 90.00,  4, '2024-09-01 17:00:00', 'Credit', 'HDFC'),
(16, 120.00, 1,  '2024-08-31 08:15:00', 'Credit', 'SBI'),
(17, 200.00, 1,  '2024-08-31 11:45:00', 'Debit',  'SBI'),
(18, 80.00,  1,  '2024-08-31 14:30:00', 'Credit', 'SBI'),
(19, 60.00,  2,  '2024-08-31 09:00:00', 'Debit',  'UBI'),
(20, 100.00, 2,  '2024-08-31 12:00:00', 'Credit', 'UBI'),
(21, 150.00, 2,  '2024-08-31 15:15:00', 'Debit',  'UBI'),
(22, 250.00, 3,  '2024-08-31 07:30:00', 'Debit',  'PNB'),
(23, 100.00, 3,  '2024-08-31 10:00:00', 'Credit', 'PNB'),
(24, 50.00,  3,  '2024-08-31 13:45:00', 'Debit',  'PNB'),
(25, 300.00, 4, '2024-08-31 09:15:00', 'Debit',  'HDFC'),
(26, 600.00, 4, '2024-08-31 11:30:00', 'Credit', 'HDFC'),
(27, 150.00, 4, '2024-08-31 14:00:00', 'Debit',  'HDFC'),
(28, 200.00, 4, '2024-08-31 15:45:00', 'Credit', 'HDFC'),
(29, 90.00,  4, '2024-08-31 16:30:00', 'Debit',  'HDFC'),
(30, 110.00, 4, '2024-08-31 17:15:00', 'Credit', 'HDFC');

SELECT 
    customer_id, name, amount, transaction_date, transaction_mode, bank_name
FROM (
    SELECT
        C.customer_id, C.name,
        T.amount, T.transaction_date, T.transaction_mode, T.bank_name,
        ROW_NUMBER() OVER (PARTITION BY C.customer_id, CAST(T.transaction_date AS DATE) ORDER BY T.transaction_date) AS rn
    FROM Customers C
    JOIN Transactions T ON C.customer_id = T.customer_id 
    ) AS tmp
WHERE rn = 1 -- Filter to include only the first transaction of each day per customer
-- AND transaction_date BETWEEN '2024-08-31 00:00:00' AND '2024-08-31 23:59:59' -- Uncomment the line above to filter results to a specific date range
ORDER BY customer_id ASC, transaction_date;

/*
Q4: There is a table: 
Company: company_id, user_id, language 
Write a query to find the company_id for at least 2 users who can speak both English and German. 
*/

CREATE TABLE Company (
    company_id INT,
    user_id INT,
    language VARCHAR(50)
);

INSERT INTO Company (company_id, user_id, language) VALUES
(1, 1, 'English'),
(1, 1, 'Spanish'),
(1, 2, 'German'),
(1, 2, 'English'),
(2, 1, 'Spanish'),
(2, 1, 'German'),
(2, 2, 'English'),
(2, 2, 'French'),
(3, 1, 'German'),
(3, 1, 'English'),
(3, 2, 'Spanish'),
(3, 2, 'English'),
(3, 3, 'German'),
(3, 3, 'English'),
(4, 1, 'Spanish'),
(4, 2, 'German'),
(4, 2, 'English'),
(4, 3, 'German'),
(4, 3, 'English'),
(5, 1, 'English'),
(5, 1, 'German'),
(5, 2, 'Spanish'),
(5, 2, 'German'),
(5, 3, 'German');

SELECT  company_id, user_id, language
FROM(
    SELECT  company_id, user_id, 
        GROUP_CONCAT(language SEPARATOR ',') AS language  
    FROM Company 
    WHERE language IN ('English','German') 
    GROUP BY company_id, user_id 
    HAVING COUNT(DISTINCT language) = 2
    ) AS tmp
GROUP BY company_id
HAVING COUNT(user_id) >= 2;

/*
Q6: Two tables: t1 : 1 1 2 1 3 4 t2 : 1 1 2 3 5 null What is the result of a Left Join? 
*/

CREATE TABLE t1 (
    value INT
);

CREATE TABLE t2 (
    value INT
);

-- For t1
INSERT INTO t1 (value) VALUES (1);
INSERT INTO t1 (value) VALUES (1);
INSERT INTO t1 (value) VALUES (2);
INSERT INTO t1 (value) VALUES (1);
INSERT INTO t1 (value) VALUES (3);
INSERT INTO t1 (value) VALUES (4);

-- For t2
INSERT INTO t2 (value) VALUES (1);
INSERT INTO t2 (value) VALUES (1);
INSERT INTO t2 (value) VALUES (2);
INSERT INTO t2 (value) VALUES (3);
INSERT INTO t2 (value) VALUES (5);
INSERT INTO t2 (value) VALUES (NULL);

SELECT t1.value, t2.value FROM t1 LEFT JOIN t2 USING(value);
+-------+-------+
| value | value |
+-------+-------+
|     1 |     1 |
|     1 |     1 |
|     1 |     1 |
|     1 |     1 |
|     1 |     1 |
|     1 |     1 |
|     2 |     2 |
|     3 |     3 |
|     4 |  NULL |
+-------+-------+

/* 
Q3. SQL order of execution.
*/

SELECT column1, column2
FROM table1
JOIN table2 ON table1.id = table2.id
WHERE table1.column3 = 'value'
GROUP BY column1
HAVING COUNT(column2) > 5
ORDER BY column1
LIMIT 5;

FROM and JOIN are processed first, combining data from table1 and table2.
ON specifies the condition for the join.
WHERE filters the rows before grouping.
GROUP BY organizes rows into groups.
HAVING filters these groups.
SELECT specifies which columns to show in the final result.
DISTINCT (if used) would remove duplicates at this stage.
ORDER BY sorts the resulting rows.
LIMIT restricts the number of rows returned.

/*
Q2: How would you optimize a sql query?
*/

Analyze Query Execution Plan : Use `EXPLAIN` in MySQL to see how a query runs and spot issues like missing indexes or slow joins. This helps you optimize the query for better performance.
Indexing : Ensure that appropriate indexes are created on columns. Indexes can significantly speed up query performance by reducing the amount of data that needs to be scanned.
Avoid SELECT * : Be specific about the columns required. Using SELECT * can cause unnecessary data to be fetched, which increases the amount of data processed and transferred.
Table Partitioning: For very large tables, partitioning can help by breaking the table into smaller, more manageable chunks based on certain criteria.

/*
Q5: What is Denormalization? When is it used? 
*/

Denormalization is a technique used to make databases run faster by adding some extra, repetitive data. This can help speed up queries and reduce the need for complex data joins. However, it's important to note that denormalization doesn't replace normalization but works alongside it to boost performance when needed.

Pros of Denormalization:

•	Improved performance: Denormalization can lead to significant improvements in database query performance. The database can quickly process read operations by reducing the number of table joins required to retrieve data.
•	Simplified data model: Denormalization can simplify the data model by reducing the database's number of tables and relationships. This can make the database easier to understand and maintain.
•	Reduced complexity: With fewer tables and relationships to manage, database administrators can spend less on maintenance and more time optimizing performance.


Cons of Denormalization:

•	Increased data redundancy: Denormalization introduces redundancy into the database, which can lead to data inconsistencies and higher storage costs.
•	Reduced flexibility: Denormalization can make it more difficult to change the database schema in the future. Because data is duplicated across multiple tables, changing a single field may require updating multiple tables.
•	Higher maintenance costs: Denormalization can increase the database's complexity, making it more difficult to maintain and troubleshoot.

/*
Follow up Qn: What if you want to join the null values?
*/

SQL Join with Null Values:

Left Join/Right Join: If you’re joining tables and you have null values, a LEFT JOIN or RIGHT JOIN will include rows with null values on one side of the join. For instance, if you have a LEFT JOIN, it will include all rows from the left table, even if there Is no matching row in the right table (resulting in nulls for columns from the right table).
Full Outer Join: This will include all rows from both tables and can result in null values where there is no match between the two tables.