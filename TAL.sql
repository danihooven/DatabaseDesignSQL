/* *****************************

    CLASS LAB 3

****************************** */

-- create table
CREATE TABLE REP
(
  REP_NUM CHAR(2) PRIMARY KEY,
  LAST_NAME CHAR(15) NOT NULL,
  FIRST_NAME CHAR(15) NOT NULL,
  STREET CHAR(15),
  CITY CHAR(15),
  STATE CHAR(2),
  POSTAL_CODE CHAR(5),
  COMMISSION DECIMAL(7,2),
  RATE DECIMAL(3,2)
);

-- add record
INSERT INTO REP
VALUES
('15', 'Campos', 'Rafael', '724 Vinca Dr.', 'Grove', 'CA', '90092', 23457.50, '0.06');

-- add record w/ limited fields
INSERT INTO REP (REP_NUM, LAST_NAME, FIRST_NAME)
VALUES
('75', 'Perry', 'Annabel');

-- to see all records
-- increase rows selector to view more rows
SELECT *
FROM REP;

-- to see description
describe rep;

-- to drop table
drop table rep;

-- update fields
UPDATE REP
SET LAST_NAME='Parry'
WHERE REP_NUM='75';

-- delete record
DELETE
FROM REP
WHERE REP_NUM = '75';

CREATE TABLE CUSTOMER
(
  CUSTOMER_NUM CHAR(3) PRIMARY KEY,
  CUSTOMER_NAME CHAR(35) NOT NULL,
  STREET CHAR(20),
  CITY CHAR(15),
  STATE CHAR(2),
  POSTAL_CODE CHAR(5),
  BALANCE DECIMAL(8,2),
  CREDIT_LIMIT DECIMAL(8,2),
  REP_NUM CHAR(2)
);

CREATE TABLE ORDERS
(
  ORDER_NUM CHAR(5) PRIMARY KEY,
  ORDER_DATE DATE,
  CUSTOMER_NUM CHAR(3)
);

CREATE TABLE ITEM
(
  ITEM_NUM CHAR(4) PRIMARY KEY,
  DESCRIPTION CHAR(30),
  ON_HAND DECIMAL(4,0),
  CATEGORY CHAR(3),
  STOREHOUSE CHAR(1),
);

CREATE TABLE ORDER_LINE
(
  ORDER_NUM CHAR(5),
  ITEM_NUM CHAR(4),
  NUM_ORDERED DECIMAL(3,0),
  QUOTED_PRICE DECIMAL(6,2),
  PRIMARY KEY(ORDER_NUM, ITEM_NUM)
);

/* ***********************************

    CLASS LAB 4

*********************************** */

-- RETRIEVAL
-- 1. List the number, name, and balance for all customers.

SELECT CUSTOMER_NUM, CUSTOMER_NAME, BALANCE
FROM CUSTOMER;


-- RETRIEVE USING *
-- 2. List the complete item table.

SELECT *
FROM ITEM;


-- WHERE CLAUSE
-- 3. What is the name of the customer with customer number 126?

SELECT CUSTOMER_NAME, CUSTOMER_NUM
FROM CUSTOMER
WHERE CUSTOMER_NUM = '126';


/* COMPARISON OPERATORS *******
    = Equal to
    < Less than
    > Greater than
    <= Less than or equal to
    >= Greater than or equal to
    <> Not equal to */


-- WHERE CLAUSE
-- 4. Find the name of each customer located in the city of Grove.

SELECT CUSTOMER_NAME
FROM CUSTOMER
WHERE CITY = 'Grove';


-- Find the name, balance, and credit limit for all customers with balances that exceed their credit limits.

SELECT CUSTOMER_NAME, BALANCE, CREDIT_LIMIT
FROM CUSTOMER
WHERE BALANCE > CREDIT_LIMIT;


/* COMPOUND CONDITIONS *********
    AND: all simple conditions are true
    OR: any simple condition is true
    NOT: reverses the truth of the original condition */

-- AND CONDITION
-- 5. List the descriptions of all items that are located in storehouse 3 and for which there are more than 25 units on hand.

-- **** Add "WHERE" conditions one at a time to check for errors ****

SELECT DESCRIPTION, STOREHOUSE, ON_HAND
FROM ITEM
WHERE STOREHOUSE = '3'
AND ON_HAND > 25;


-- OR CONDITION
-- 6. List the descriptions of all items that are located in storehouse 3 OR for which there are more than 25 units on hand.

SELECT DESCRIPTION
FROM ITEM
WHERE STOREHOUSE = '3'
OR ON_HAND > 25;


-- NOT OPERATOR
-- 7. List the descriptions of all items that are not in storehouse 3.

SELECT DESCRIPTION
FROM ITEM
WHERE NOT (STOREHOUSE = '3');

-- or

SELECT DESCRIPTION
FROM ITEM
WHERE STOREHOUSE <> '3';


-- BETWEEN OPERATOR *****
/* BETWEEN: specify range of vaules */


-- BETWEEN OPERATOR
-- 8. List the number, name, and balance of all customers with balances greater than or equal to $2,000 and less than or equal to $5,000 (SELECT command with an AND condition for a single column).

SELECT CUSTOMER_NUM, CUSTOMER_NAME, BALANCE
FROM CUSTOMER
WHERE BALANCE >= 2000
AND BALANCE <=5000;


-- BETWEEN OPERATOR
-- 9. List the number, name, and balance of all customers with balances greater than or equal to $2,000 and less than or equal to $5,000.

(SELECT command with the BETWEEN operator)*/
SELECT CUSTOMER_NUM, CUSTOMER_NAME, BALANCE
FROM CUSTOMER
WHERE BALANCE BETWEEN 2000 AND 5000;


/* COMPUTED COLUMNS *******
  + for addtion
  - for subtraction
  * for mulitiplication
  / for division    */


-- COMPUTED COLUMNS
-- 10. Find the number, name, and available credit (the credit limit minus the balance) for each customer.

SELECT CUSTOMER_NUM, CUSTOMER_NAME, CREDIT_LIMIT - BALANCE
FROM CUSTOMER;


-- AS CLAUSE
-- 11. Find the number, name, and available credit for each customer with at least $5,000 of available credit.

SELECT CUSTOMER_NUM, CUSTOMER_NAME, CREDIT_LIMIT - BALANCE AS AVAILABLE_CREDIT
FROM CUSTOMER
WHERE (CREDIT_LIMIT - BALANCE) >= 5000;


/* LIKE OPERATOR ********
  LIKE: used for pattern matching
  %Columbus%
    "123 Columbus" or "Columbusia"
  Underscore (_) : represents a single character
    "T_M" for TIM or TOM or T3M */


-- LIKE OPERATOR
-- 12. List the number, name, and complete address of each customer located on a street that contains the letter “Columbus.”

SELECT CUSTOMER_NUM, CUSTOMER_NAME, STREET, CITY, STATE, POSTAL_CODE
FROM CUSTOMER
WHERE STREET LIKE '%Columbus%';


/* IN OPERATOR ***********
  IN Clause: IN operator followed by a collection of values */


-- IN OPERATOR
-- 13. List the number, name, and credit limit for each customer with a credit limit of $5,000, $10,000, or $15,000.

SELECT CUSTOMER_NUM, CUSTOMER_NAME, CREDIT_LIMIT
FROM CUSTOMER
WHERE CREDIT_LIMIT IN (5000, 10000, 15000);


/* SORTING *******************
  ORDER BY clause: list data in specific order
  Sort key or key: column on which to sort data
  Major sort key and minor sort key
  List sort keys in order of importance in the ORDER BY clause
  Ascending is default sort order, use DESC for descending */


-- SORTING OPTIONS
-- 14. List the number, name, and balance of each customer. Order (sort) the output in ascending (increasing) order by balance.

SELECT CUSTOMER_NUM, CUSTOMER_NAME, BALANCE, CITY
FROM CUSTOMER
ORDER BY CITY, BALANCE;


-- SORTING OPTIONS
-- 15. List the number, name, and credit limit of each customer. Order the customers by name within descending credit limit. (Sort first by credit limit descending order, then by customer).

SELECT CUSTOMER_NUM, CUSTOMER_NAME, CREDIT_LIMIT
FROM CUSTOMER
ORDER BY CREDIT_LIMIT DESC, CUSTOMER_NAME;


/* USING FUNCITONS ********************
  Aggregate Functions
  AVG calculates average value in a column
  COUNT number of rows in a table
  MAX maximum value in a column
  MIN: minimum value in a column
  SUM: calculates a total of the values in a column */


-- COUNT FUNCTION
-- 16. How many items are in category GME?

SELECT COUNT(*)
FROM ITEM
WHERE CATEGORY = 'GME';


-- COUNT FUNCTION
-- 17. Find the total number of TAL Distributors customers and the total of their balances.

SELECT COUNT(*), SUM(BALANCE)
FROM CUSTOMER;


/* USING THE SUM FUNCTION ************
  Used to calculate totals of COLUMNS
  The column must be specified and it must be numeric
    Null values are ignored */


-- USING THE AVD, MAX, AND MIN FUNCTIONS
-- 18. Find the sum of all balances, the average balance, the maximum balance, and the minimum balance of all TAL Distributors customers.

SELECT SUM(BALANCE), AVG(BALANCE), MAX(BALANCE), MIN(BALANCE)
FROM CUSTOMER;


/* USING THE DISTINCT OPERATOR *******************
  use DISTINCT in conjuction with COUNT: eliminates duplicate values */


-- DISTINCT OPERATOR
-- 19. Find the number of each customer that currently has an open order (that is, an order currently in the ORDERS table).

SELECT CUSTOMER_NUM
FROM ORDERS
ORDER BY CUSTOMER_NUM;


-- DISTINCT OPERATOR
-- 20. Find the number of each customer that currently has an open order. List each customer only once.

SELECT DISTINCT(CUSTOMER_NUM)
FROM ORDERS
ORDER BY CUSTOMER_NUM;


-- DISTINCT OPERATORS
-- 21. Count the number of customers that currently have open orders.

SELECT COUNT(DISTINCT(CUSTOMER_NUM))
FROM ORDERS;


/* NESTING QUERIES **********************************************
  NESTING Query: results that require two or more steps.
  Subquery: inner query placed inside another query.
    Subquery is evaluated first.
  Outer query: uses the subquery results. */


-- NESTING QUERIES
-- 22. List the number of each item in category PZL.

SELECT ITEM_NUM
FROM ITEM
WHERE CATEGORY = 'PZL';


-- NESTING QUERIES
-- 23. List the order numbers that contain an order line for an item in category PZL.

SELECT ORDER_NUM
FROM ORDER_LINE
WHERE ITEM_NUM IN ('DR67', 'FH24', 'KD34', 'MT03');


-- NESTING QUERIES
--24. Find the answer to Examples 22 and 23 in ONE step.

SELECT ORDER_NUM
FROM ORDER_LINE
WHERE ITEM_NUM IN
(SELECT ITEM_NUM
FROM ITEM
WHERE CATEGORY = 'PZL');


-- NESTING QUERIES
-- 25. List the number, name, and balance for each customer whose balance exceeds the average balance of all customers.

SELECT CUSTOMER_NUM, CUSTOMER_NAME, BALANCE
FROM CUSTOMER
WHERE BALANCE >
(SELECT AVG(BALANCE)
FROM CUSTOMER);


/* GROUPING ***********************
  Creates groups of rows that share common characteristics
  Any calculations in the SELECT command are performed for the entire group */


/* GROUP BY clause *****************
  Group data on a particular column such as REP_NUM
  calculates statistic when desired. */


-- GROUP BY clause
-- 26. For each sales rep, list the rep number and the average balance of the rep’s customers. */

SELECT REP_NUM, AVG(BALANCE)
FROM CUSTOMER
GROUP BY REP_NUM
ORDER BY REP_NUM;


/* HAVING CLAUSE ******************************
  Used to restrict groups that will be included */

-- HAVING Clause
-- 27. Repeat the previous example, but list only those reps whose customers have an average balance greater than $1,500.

SELECT REP_NUM, AVG(BALANCE)
FROM CUSTOMER
GROUP BY REP_NUM
HAVING AVG(BALANCE) > 1500
ORDER BY REP_NUM;


/* HAVING vs. WHERE **************************
      WHERE: limit rows
      HAVING: limit groups  */


-- 28. List each credit limit and the number of customers having each credit limit.

SELECT CREDIT_LIMIT, COUNT(*)
FROM CUSTOMER
GROUP BY CREDIT_LIMIT
ORDER BY CREDIT_LIMIT;


-- 29. Repeat Example 28, but list only those credit limits held by more than two customers.

SELECT CREDIT_LIMIT, COUNT(*)
FROM CUSTOMER
GROUP BY CREDIT_LIMIT
HAVING COUNT(*) >2
ORDER BY CREDIT_LIMIT;


-- 30. List each credit limit and the number of customers of sales rep 15 that have this limit.

SELECT CREDIT_LIMIT, COUNT(*)
FROM CUSTOMER
WHERE REP_NUM = '15'
GROUP BY CREDIT_LIMIT
ORDER BY CREDIT_LIMIT;


-- 31. Repeat Example 30, but list only those credit limits held by fewer than two customers.

SELECT CREDIT_LIMIT, COUNT(*)
FROM CUSTOMER
WHERE REP_NUM = '15'
GROUP BY CREDIT_LIMIT
HAVING COUNT(*) < 2
ORDER BY CREDIT_LIMIT;


/* NULLS: Condition that involves a column that can be null **********
    IS NULL
    IS NOT NULL */

-- 32. List the number and name of each customer with a null (unknown) street value.

SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE STREET IS NULL;


/* ****************************

    CLASS LAB CH 5

**************************** */

-- JOINING TWO TABLES
-- 1. List the number and name of each customer, together with the number, last name and first name of the sales rep who represents the customer.

SELECT CUSTOMER_NUM, CUSTOMER_NAME, REP.REP_NUM, LAST_NAME, FIRST_NAME
FROM CUSTOMER, REP
WHERE CUSTOMER.REP_NUM = REP.REP_NUM;


-- RESTRICTING JOINS
-- 2. List the number and name of each customer whose credit limit is $7,500, together with the number, last name, and first name of the sales rep who represents the customer.

SELECT CUSTOMER_NUM, CUSTOMER_NAME, REP.REP_NUM, LAST_NAME, FIRST_NAME
FROM CUSTOMER, REP
WHERE CUSTOMER.REP_NUM = REP.REP_NUM
AND CREDIT_LIMIT = 7500;


-- JOINING TWO TABLES
-- 3. For every item on order, list the order number, item number, description, number of units ordered, quoted price, and unit price.

SELECT ORDER_NUM, ORDER_LINE.ITEM_NUM, DESCRIPTION, NUM_ORDERED, QUOTED_PRICE, PRICE
FROM ORDER_LINE, ITEM
WHERE ORDER_LINE.ITEM_NUM = ITEM.ITEM_NUM;


-- RESTRICTING ROWS
-- 4.a. Find the description of each item included in order number 51623.

SELECT DESCRIPTION
FROM ORDER_LINE, ITEM
WHERE ORDER_LINE.ITEM_NUM = ITEM.ITEM_NUM
AND ORDER_NUM = '51623';


-- 4.b. Same as above, but use the IN operator with a subquery

SELECT DESCRIPTION
FROM ITEM
WHERE ITEM_NUM
IN (
  SELECT ITEM_NUM
  FROM ORDER_LINE
  WHERE ORDER_NUM = '51623'
);


-- USING THE EXISTS OPERATOR
-- 5. Find the order number and order date for each order that contains item number FD11. (Using the IN operator to select order information)

SELECT ORDER_NUM, ORDER_DATE
FROM ORDERS
WHERE
EXISTS (
  SELECT *
  FROM ORDER_LINE
  WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
  AND ITEM_NUM = 'FD11'
);


-- Find the order number and order date for each order that contains item number FD11. (Using the EXISTS operator to select order information)

SELECT ORDER_NUM, ORDER_DATE
FROM ORDERS
WHERE
EXISTS (
  SELECT *
  FROM ORDER_LINE
  WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
  AND ITEM_NUM = 'FD11'
);


-- USING A SUBQUERY WITHIN A SUBQUERY
-- 6. Find the order number and order date for each order that includes an item located in storehouse3. (Nested subqueries)

SELECT ORDER_NUM, ORDER_DATE
FROM ORDERS
WHERE ORDER_NUM
IN (
  SELECT ORDER_NUM
  FROM ORDER_LINE
  WHERE ITEM_NUM
  IN (
    SELECT ITEM_NUM
    FROM ITEM
    WHERE STOREHOUSE = '3'
  )
);


-- Find the order number and order date for each order that includes an item located in storehouse3. (Joining three tables)

SELECT ORDERS.ORDER_NUM, ORDER_DATE
FROM ORDER_LINE, ORDERS, ITEM
WHERE ORDER_LINE.ORDER_NUM = ORDERS.ORDER_NUM
AND ORDER_LINE.ITEM_NUM = ITEM.ITEM_NUM
AND STOREHOUSE = '3';


-- A COMPREHENSIVE EXAMPLE
-- 7. List the customer number, order number, order date, and order total for each order with a total that exceeds $500. Assign the column name ORDER_TOTAL to the column that displays order totals and then order the results by order number.

SELECT CUSTOMER_NUM, ORDERS.ORDER_NUM, ORDER_DATE,
SUM(NUM_ORDERED * QUOTED_PRICE) AS ORDER_TOTAL
FROM ORDERS, ORDER_LINE
WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
GROUP BY ORDERS.ORDER_NUM, CUSTOMER_NUM, ORDER_DATE
HAVING SUM(NUM_ORDERED * QUOTED_PRICE) > 500
ORDER BY ORDERS.ORDER_NUM;


-- USING ALIASES IN QUERIES
-- 8. List the number, last name, and first name for each sales rep together with the number and name for each customer the sales rep represents.

SELECT R.REP_NUM, LAST_NAME, FIRST_NAME, C.CUSTOMER_NUM, CUSTOMER_NAME
FROM REP R, CUSTOMER C
WHERE R.REP_NUM = C.REP_NUM;


-- JOINING A TABLE TO ITSELF
-- 9. For each pair of customers located in the same city, display the customer number, c¬ustomer name and city.

SELECT F.CUSTOMER_NUM, F.CUSTOMER_NAME, S.CUSTOMER_NUM, S.CUSTOMER_NAME, F.CITY
FROM CUSTOMER F, CUSTOMER S
WHERE F.CITY = S.CITY
AND F.CUSTOMER_NUM < S.CUSTOMER_NUM
ORDER BY F.CUSTOMER_NUM, S.CUSTOMER_NUM;


-- JOING SEVERAL TABLES
-- 10. For each item on order, list the item number, number ordered, order number, order date, customer number, and customer name, along with the last name and the sales rep who represented each customer.

SELECT ITEM_NUM, NUM_ORDERED, ORDER_LINE.ORDER_NUM, ORDER_DATE, CUSTOMER.CUSTOMER_NUM, CUSTOMER_NAME, LAST_NAME
FROM ORDER_LINE, ORDERS, CUSTOMER, REP
WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
AND CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM
AND REP.REP_NUM = CUSTOMER.REP_NUM
ORDER BY ITEM_NUM, ORDER_LINE.ORDER_NUM;


-- SET OPERATIONS
-- 11. List the number and name of each customer that is either represented by sales rep 15 or currently has orders on file, or both.

SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE REP_NUM = '15'
UNION
SELECT CUSTOMER.CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM;


-- INTERSECT OPERATOR
-- 12. List the number and name of each customer that is represented by sales rep 15 and that currently has orders on file.

SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE REP_NUM = '15'
INTERSECT
SELECT CUSTOMER.CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM;

--or

SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE REP_NUM = '15'
AND CUSTOMER_NUM
IN(
  SELECT CUSTOMER_NUM
  FROM ORDERS
);


-- MINUS OPERATOR
-- 13. List the number and name of each customer that is represented by sales rep 15 but that does not have orders currently in the file.

SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE REP_NUM = '15'
MINUS
SELECT CUSTOMER.CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM;

-- or

SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE REP_NUM = '15'
AND CUSTOMER_NUM
NOT IN(
  SELECT CUSTOMER_NUM
  FROM ORDERS
);


-- ALL OPERATOR
-- 14. Find the customer number, name, current balance and rep number of each customer whose balance exceeds the maximum balance of all customers represented by sales rep 30.

SELECT CUSTOMER_NUM, CUSTOMER_NAME, BALANCE, REP_NUM
FROM CUSTOMER
WHERE BALANCE > ALL
(
  SELECT BALANCE
  FROM CUSTOMER
  WHERE REP_NUM = '30'
);


-- ANY OPERATOR
-- 15. Find the customer number, name, current balance, and rep number of each customer whose balance is greater than the balance of at least one customer of sales rep 30.

SELECT CUSTOMER_NUM, CUSTOMER_NAME, BALANCE, REP_NUM
FROM CUSTOMER
WHERE BALANCE > ANY
(
  SELECT BALANCE
  FROM CUSTOMER
  WHERE REP_NUM = '30'
);

-- INNER JOIN
-- 16. Display the customer number, customer name, order number, and order date for each order. Sort the results by customer number.

SELECT CUSTOMER.CUSTOMER_NUM, CUSTOMER_NAME, ORDER_NUM, ORDER_DATE
FROM CUSTOMER
INNER JOIN ORDERS
ON CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM
ORDER BY CUSTOMER.CUSTOMER_NUM;


-- LEFT JOIN
-- 17. Display the customer number, customer name, order number, and order date for all orders.  Include all customers in the results.  For customers that do not have orders, omit the order number and order date.

SELECT CUSTOMER.CUSTOMER_NUM, CUSTOMER_NAME, ORDER_NUM, ORDER_DATE
FROM CUSTOMER
LEFT JOIN ORDERS
ON CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM
ORDER BY CUSTOMER.CUSTOMER_NUM;


-- PRODUCT
-- 18. Form the product of the CUSTOMER and ORDERS tables. Display the customer number and name from the CUSTOMER table, along with the order number and order date from the ORDERS table.

SELECT CUSTOMER.CUSTOMER_NUM, CUSTOMER_NAME, ORDER_NUM, ORDER_DATE
FROM CUSTOMER, ORDERS;




/* *****************************

    CLASS LAB CH 6

****************************** */

-- 1. Create a new table named LEVEL1_CUSTOMER that contains the following columns from the CUSTOMER table: CUSTOMER_NUM, CUSTOMER_NAME, BALANCE, CREDIT_LIMIT, and REP_NUM. The columns in the new LEVEL1_CUSTOMER table should have the same characteristics as the corresponding columns in the CUSTOMER table.

CREATE TABLE LEVEL1_CUSTOMER
(
  CUSTOMER_NUM CHAR(3) PRIMARY KEY,
  CUSTOMER_NAME CHAR(35),
  BALANCE DECIMAL (8,2),
  CREDIT_LIMIT DECIMAL(8,2),
  REP_NUM CHAR(2)
);

-- 2. Insert into the LEVEL1_CUSTOMER table the customer number, customer name, balance, credit limit, and rep number for customers with credit limits of $7,500.

INSERT INTO LEVEL1_CUSTOMER
SELECT CUSTOMER_NUM, CUSTOMER_NAME, BALANCE, CREDIT_LIMIT, REP_NUM
FROM CUSTOMER
WHERE CREDIT_LIMIT = 7500;

-- 3. Change the name of customer 796 in the LEVEL1_CUSTOMER table to “Unique Gifts and Toys¬¬.”

UPDATE LEVEL1_CUSTOMER
SET CUSTOMER_NAME = 'Unique Gifts and Toys'
WHERE CUSTOMER_NUM = '796';

-- 4. For each customer in the LEVEL1_CUSTOMER table that is represented by sales rep 45 and has a balance over $2,000, increase the customer’s credit limit to $8,000.

UPDATE LEVEL1_CUSTOMER
SET CREDIT_LIMIT = 8000
WHERE REP_NUM = '45'
AND BALANCE > 2000;

-- 5. Add customer number 907 to the LEVEL1_CUSTOMER table. The name is Glenn’s British Toys, the balance is zero, the credit limit is $7,500, and the rep number is 45.

INSERT INTO LEVEL1_CUSTOMER
VALUES
('907', 'Glenn''s British Toys', 0, 7500, '45');

-- 6. In the LEVEL1_CUSTOMER table, change the name of customer 665 to “Cricket Toy Shop,” and then delete customer 893.

-- *** DESELECT "AUTOCOMMIT" ***

UPDATE LEVEL1_CUSTOMER
SET CUSTOMER_NAME = 'Cricket Toy Shop'
WHERE CUSTOMER_NUM = '665';

DELETE FROM LEVEL1_CUSTOMER
WHERE CUSTOMER_NUM = '893';

-- 7. Execute a rollback and then display the data in the LEVEL1_CUSTOMER table.

ROLLBACK;

-- 8. Change the balance of customer 665 in the LEVEL1_CUSTOMER table to null.

UPDATE LEVEL1_CUSTOMER
SET BALANCE = NULL
WHERE CUSTOMER_NUM = '665';

-- 9. TAL Distributors decides to maintain a customer type for each customer in the database. These types are R for regular customers, D for distributors, and S for special customers. Add this information in a new column named CUSTOMER_TYPE in the LEVEL1_CUSTOMER table.

ALTER TABLE LEVEL1_CUSTOMER
ADD CUSTOMER_TYPE CHAR(1);

UPDATE LEVEL1_CUSTOMER
SET CUSTOMER_TYPE = 'R';

-- 10. Two customers in the LEVEL1_CUSTOMER table have a type other than R. Change the types for customers 334 and 386 to S and D, respectively.

UPDATE LEVEL1_CUSTOMER
SET CUSTOMER_TYPE = 'S'
WHERE CUSTOMER_NUM = '334';

UPDATE LEVEL1_CUSTOMER
SET CUSTOMER_TYPE = 'D'
WHERE CUSTOMER_NUM = '386';

DESCRIBE LEVEL1_CUSTOMER;

-- 11. The length of the CUSTOMER_NAME column in the LEVEL1_CUSTOMER table is too short. Increase its length to 50 characters. In addition, change the CREDIT_LIMIT column so it cannot accept nulls.

ALTER TABLE LEVEL1_CUSTOMER
MODIFY CUSTOMER_NAME CHAR(50);

ALTER TABLE LEVEL1_CUSTOMER
MODIFY CREDIT_LIMIT NOT NULL;

DESCRIBE LEVEL1_CUSTOMER;

-- 12. Delete the LEVEL1_CUSTOMER table because it is no longer needed in the TAL Distributors database.

DROP TABLE LEVEL1_CUSTOMER;


/* ***************************************

      CLASS LAB CH 7

*************************************** */

-- CREATING AND USING VIEWS
-- 1. Create a view named TOYS that consists of the item number, description, units on hand, and unit price of each item in category TOY.

CREATE VIEW TOYS AS
SELECT ITEM_NUM, DESCRIPTION, ON_HAND, PRICE
FROM ITEM
WHERE CATEGORY = 'TOY';


-- RENAME COLUMNS
-- 2. Create a view named TYS that consists of the item number, description, units on hand, and unit price of all items in category TOY. In this view, change the names of the ITEM_NUM, DESCRIPTION, ON_HAND, and PRICE columns to INUM, DSC, OH, and PRCE, respectively.

CREATE VIEW TYS (INUM, DSC, OH, PRCE) AS
SELECT ITEM_NUM, DESCRIPTION, ON_HAND, PRICE
FROM ITEM
WHERE CATEGORY = 'TOY';


-- COMBINING TABLES
-- 3. Create a view named REP_CUST consisting of the sales rep number (named RNUM), sales rep last name (named RLAST), sales rep first name (named RFIRST), customer number (named CNUM), and customer name (named CNAME) for all sales reps and matching customers in the REP and CUSTOMER tables. Sort the records by rep number and customer number

CREATE VIEW REP_CUST (RNUM, RLAST, RFIRST, CNUM, CNAME) AS
SELECT REP.REP_NUM, LAST_NAME, FIRST_NAME, CUSTOMER_NUM, CUSTOMER_NAME
FROM REP, CUSTOMER
WHERE REP.REP_NUM = CUSTOMER.REP_NUM
ORDER BY REP.REP_NUM, CUSTOMER_NUM;


-- STATISTICS IN VIEWS
-- 4. Create a view named CRED_CUST that consists of each credit limit (CREDIT_LIMIT) and the number of customers having this credit limit (NUM_CUSTOMERS). Sort the credit limits in ascending order.

CREATE VIEW CRED_CUST (CREDIT_LIMIT, NUM_CUSTOMERS) AS
SELECT CREDIT_LIMIT, COUNT(*)
FROM CUSTOMER
GROUP BY CREDIT_LIMIT
ORDER BY CREDIT_LIMIT;


-- DROPPING A VIEW
-- 5. The TYS view is no longer necessary, so delete it.

DROP VIEW TYS;


-- GRANTING PERMISSION
-- 6. User Johnson must be able to retrieve data from the REP table.

GRANT SELECT ON REP TO JOHNSON;


-- GRANTING PERMISSION
-- 7. Users Smith and Brown must be able to add new items to the ITEM table.

GRANT INSERT ON ITEM TO SMITH, BROWN;


-- GRANTING PERMISSION
-- 8. User Anderson must be able to change the name and street address of customers.

GRANT UPDATE (CUSTOMER_NAME, STREET) ON CUSTOMER TO ANDERSON;


-- GRANTING PERMISSION
-- 9. User Thompson must be able to delete order lines.

GRANT SELECT ON ORDER_LINE TO THOMPSON;


-- GRANTING PERMISSION
-- 10. Every user must be able to retrieve item numbers, descriptions, and categories.

GRANT SELECT (ITEM_NUM, DESCRIPTION, CATEGORY) ON ITEM TO PUBLIC;


-- GRANTING PERMISSION
-- 11. User Roberts must be able to create an index on the REP table.

GRANT INDEX ON REP TO ROBERTS;


-- GRANTING PERMISSION
-- 12. User Thomas must be able to change the structure of the CUSTOMER table.

GRANT ALTER ON CUSTOMER TO THOMAS;


-- GRANTING PERMISSION
-- 13. User Wilson must have all privileges for the REP table.

GRANT ALL ON REP TO WILSON;


-- REMOVING SECURITY
-- 14. User Johnson is no longer allowed to retrieve data from the REP table.

REVOKE SELECT ON REP FROM JOHNSON;


-- CREATING AN INDEX
-- 15. Create an index named BALIND on the BALANCE column in the CUSTOMER table. Create an index named REP_NAME on the combination of the LAST_NAME and FIRST_NAME columns in the REP table. Create an index named CRED_NAME on the combination of the CREDIT_LIMIT and CUSTOMER_NAME columns in the CUSTOMER table, with the credit limits listed in descending order.

CREATE INDEX BALIND ON CUSTOMER (BALANCE);

CREATE INDEX REP_NAME ON REP(LAST_NAME, FIRST_NAME);

CREATE INDEX CRED_NAME ON CUSTOMER(CREDIT_LIMIT DESC, CUSTOMER_NAME);

-- INTEGRITY CONSTRAINTS
-- 20. Specify the CUSTOMER_NUM column in the ORDERS table as a foreign key that must match the CUSTOMER table.

ALTER TABLE ORDERS
ADD FOREIGN KEY (CUSTOMER_NUM) REFERENCES CUSTOMER;


-- LEGAL VALUES INTEGRITY CONSTRAINTS
-- 21. Specify the valid categories for the ITEM table as GME, PZL, and TOY.

ALTER TABLE ITEM
ADD CHECK (CATEGORY IN ('GME', 'PZL', 'TOY'));

/* ************************************

    CLASS LAB CH 8

************************************* */

-- CHARACTER FUCNTIONS
-- 1. List the rep number and last name for each sales rep. Display the last name in uppercase letters.

SELECT REP_NUM, UPPER(LAST_NAME)
FROM REP;


-- NUMBER FUNCTIONS
-- 2. List the item number and price for all items. Round the price to the nearest whole dollar amount.

SELECT ITEM_NUM, ROUND(PRICE,0) AS ROUNDED_PRICE
FROM ITEM;


-- WORKING WITH MONTH
-- 3. For each order, list the order number and the date that is two months after the order date. Name this date FUTURE_DATE.

SELECT ORDER_NUM, ADD_MONTHS(ORDER_DATE,2) AS FUTURE_DATE
FROM ORDERS;


-- WORKING WITH DAYS
-- 4. For each order, list the order number and the date that is seven days after the order date. Name this date FUTURE_DATE.

SELECT ORDER_NUM, ORDER_DATE+7 AS FUTURE_DATE
FROM ORDERS;


-- WORKING WITH SYSDATE
-- 5. For each order, list the order number, today’s date, the order date, and the number of days between the order date and today’s date. Name today’s date TODAYS_DATE and name the number of days between the order date and today’s date DAYS_PAST.

SELECT ORDER_NUM, SYSDATE AS TODAYS_DATE, ORDER_DATE,
ROUND(SYSDATE - ORDER_DATE,2) AS DAYS_PAST
FROM ORDERS;


-- CONCATENATING COLUMNS
-- 6. List the number and name of each sales rep. Concatenate the FIRST_NAME and LAST_NAME columns into a single value, with a space separating the first and last names.

SELECT REP_NUM, RTRIM(FIRST_NAME)||' '||RTRIM(LAST_NAME) AS REP_NAME
FROM REP;


-- CREATING A STORED PROCEDURE
-- 7.1 Write a PL/SQL procedure that takes a rep number as input and displays the corresponding rep name.

CREATE OR REPLACE PROCEDURE DISP_REP_NAME (I_REP_NUM IN REP.REP_NUM%TYPE) AS
  I_LAST_NAME REP.LAST_NAME%TYPE;
  I_FIRST_NAME REP.FIRST_NAME%TYPE;

  BEGIN
  SELECT LAST_NAME, FIRST_NAME
  INTO I_LAST_NAME, I_FIRST_NAME
  FROM REP
  WHERE REP_NUM = I_REP_NUM;

  DBMS_OUTPUT.PUT_LINE(RTRIM(I_FIRST_NAME)||' '||RTRIM(I_LAST_NAME));
EXECEPTION
  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('No rep with this number: '||I_REP_NUM);

  END;
  /


-- USING A STORED PROCEDURE
-- 7.2

BEGIN
DISP_REP_NAME('30');
END;
/


-- CHANGING DATA WITH A PROCEDURE
-- 8.1 Change the name of the customer whose number is stored in I_CUSTOMER_NUM to the value currently stored in I_CUSTOMER_NAME.

CREATE OR REPLACE PROCEDURE CHG_CUST_NAME
  (I_CUSTOMER_NUM IN CUSTOMER.CUSTOMER_NUM%TYPE,
   I_CUSTOMER_NAME IN CUSTOMER.CUSTOMER_NAME%TYPE) AS

  BEGIN
  UPDATE CUSTOMER
  SET CUSTOMER_NAME = I_CUSTOMER_NAME
  WHERE CUSTOMER_NUM = I_CUSTOMER_NUM;

END;
/


-- 8.2 USING A PROCEDURE TO UPDATE A ROW

BEGIN
CHG_CUST_NAME('260', 'Brookings Family Store');
END;
/


-- DELETING DATA WITH A PROCEDURE
-- 9. Delete the order whose number is stored in I_ORDER_NUM from the ORDERS table, and also delete each order line for the order whose order number is currently stored in the variable from the ORDER_LINE table.

CREATE OR REPLACE PROCEDURE DEL_ORDER (I_ORDER_NUM IN ORDERS.ORDER_NUM%TYPE) AS

BEGIN
DELETE
FROM ORDER_LINE
WHERE ORDER_NUM = I_ORDER_NUM;

DELETE
FROM ORDERS
WHERE ORDER_NUM = I_ORDER_NUM;

END;
/

-- 9.2 PROCEDURE TO DELETE ROW & RELATED ROWS FROM MULTIPLE TABLES

BEGIN
DEL_ORDER('51610');
END;
/

-- WRITING A COMPLETE PROCEDURE USING A CURSOR
-- 10. Retrieve and list the number and name of each customer represented by the sales rep whose number is stored in the variable I_REP_NUM.
