CREATE TABLE GUIDE
(GUIDE_NUM CHAR(4) PRIMARY KEY,
LAST_NAME CHAR(15),
FIRST_NAME CHAR(15),
ADDRESS CHAR(25),
CITY CHAR(25),
STATE CHAR(2),
POSTAL_CODE CHAR(5),
PHONE_NUM CHAR(12),
HIRE_DATE DATE );

CREATE TABLE CUSTOMER
(CUSTOMER_NUM CHAR(4) PRIMARY KEY,
LAST_NAME CHAR(30) NOT NULL,
FIRST_NAME CHAR (30),
ADDRESS CHAR(35),
CITY CHAR(35),
STATE CHAR(2),
POSTAL_CODE CHAR(5),
PHONE CHAR(12) );

CREATE TABLE RESERVATION
(RESERVATION_ID CHAR(7) PRIMARY KEY,
TRIP_ID DECIMAL(3,0),
TRIP_DATE DATE,
NUM_PERSONS DECIMAL(3,0),
TRIP_PRICE DECIMAL(6,2),
OTHER_FEES DECIMAL(6,2),
CUSTOMER_NUM CHAR(4) );

CREATE TABLE TRIP
(TRIP_ID DECIMAL(3,0) PRIMARY KEY,
TRIP_NAME CHAR(75),
START_LOCATION CHAR(50),
STATE CHAR(2),
DISTANCE DECIMAL(4,0),
MAX_GRP_SIZE DECIMAL(4,0),
TYPE CHAR(20),
SEASON CHAR(20) );

CREATE TABLE TRIP_GUIDES
(TRIP_ID DECIMAL(3,0),
GUIDE_NUM CHAR(4),
PRIMARY KEY (TRIP_ID, GUIDE_NUM) );

/* ******************************************

      CH 3 SQL CASE

****************************************** */

-- 1. Create a table named ADVENTURE_TRIP. The table should have the same sctructure as the TRIP table shown on page 91 Figure 3-39 except the TRIP_NAME column should use the VARCHAR data type and the DISTANCE and MAX_GRP_SIZE columns should use the number data type. Execute the commands in Oracle to describe the layout and characteristics of the ADVENTURE_TRIP table and post them in your answer

CREATE TABLE ADVENTURE_TRIP
(
  TRIP_ID DECIMAL(3,0) PRIMARY KEY,
  TRIP_NAME VARCHAR (75),
  START_LOCATION CHAR(50),
  STATE CHAR(2),
  DISTANCE DECIMAL(4,0),
  MAX_GRP_SIZE DECIMAL (4,0),
  TYPE CHAR(20),
  SEASON CHAR(20)
);

-- 2. Create a table named ADVENTURE_TRIP. The table has the same structure as the TRIP table shown in Figure 3-39 except the TRIP_NAME column should use the VARCHAR data type and the DISTANCE and MAX_GRP_SIZE column should use the NUMBER data type. Execute the command in Access to describe the layout and characteristics of the ADVENTURE_TRIP table and then post a copy of it in the answer here

CREATE TABLE ADVENTURE_TRIP
(
  TRIP_ID DECIMAL(3,0) PRIMARY KEY,
  TRIP_NAME VARCHAR (75),
  START_LOCATION CHAR(50),
  STATE CHAR(2),
  DISTANCE NUMBER(4,0),
  MAX_GRP_SIZE NUMBER (4,0),
  TYPE CHAR(20),
  SEASON CHAR(20)
);

CREATE TABLE AdventureTrip
(
  Trip_ID NUMBER PRIMARY KEY,
  Trip_Name CHAR (75),
  Start_Location CHAR(50),
  State CHAR(2),
  Distance NUMBER,
  Max_Group_Size NUMBER,
  Type CHAR(20),
  Season CHAR(20)
);

-- 3. Add the following row to the ADVENTURE_TRIP table: trip ID: 45; trip name: Jay Peak; start location: Jay; state: VT; distance: 8; maximum group size: 8; type: Hiking and season: Summer.

INSERT INTO ADVENTURE_TRIP
VALUES
(45, 'Jay Peak', 'Jay', 'VT', 8, 8, 'Hiking', 'Summer');

-- 4. How would you confirm that you have created your tables correctly (you want to view both the layout and characteristics) by describing each table in BOTH Oracle and Access?  (I want you to tell me what command you would use.)

describe ADVENTURE_TRIP;

In Access, use the Documenter tool. Click the DATABASE TOOLS tab, click the Database Documenter button in the Analyze group. In the Documenter dialog box, click the Tables tab, select the tables that you want to describe by putting a check mark in the check box next to their names, and then click the OK button.


-- 5. Display the contents of the ADVENTURE_TRIP table.

select *
FROM ADVENTURE_TRIP;

-- 6. Describe how you would delete the ADVENTURE_TRIP table.

drop table ADVENTURE_TRIP;


/* *******************************************

      CH 4 SQL CASE

******************************************* */

-- 1. How would you list the last name of each guide that does not live in Massachusetts (MA) in Oracle?  (Use SQL statements for your answer)

SELECT LAST_NAME
FROM GUIDE
WHERE NOT (STATE = 'MA');

-- 2. How would you list the trip name of each trip that has the season Summer?

SELECT TRIP_NAME
FROM TRIP
WHERE SEASON = 'Summer';

-- 3. How would you list how many trips originate in each state and then order them by state?

SELECT STATE, COUNT(*)
FROM TRIP
GROUP BY STATE;

-- 5. Colonial Adventure Tours calculates the total price of a trip by adding the trip price plus other fees and multiplying the result by the number of persons included in the reservation. How would you list the reservation ID, trip ID, customer number, and total price for all reservations where the number of persons is greater than four? *Use the column name TOTAL_PRICE for the calculated field.

SELECT RESERVATION_ID, TRIP_ID, CUSTOMER_NUM,
(TRIP_PRICE+OTHER_FEES)*NUM_PERSONS AS TOTAL_PRICE
FROM RESERVATION
WHERE NUM_PERSONS>4;

-- 6. How would you display the average distance and the average maximum group size for each type of trip?

SELECT TYPE, AVG(DISTANCE), AVG(MAX_GRP_SIZE)
FROM TRIP
GROUP BY TYPE;


/* **********************************

  CH 5 SQL CASE

********************************** */

-- 1. For each reservation, how would you list the reservation ID, trip ID, customer number, and customer last name as well as ordering the results by customer last name?

SELECT RESERVATION.RESERVATION_ID, RESERVATION.TRIP_ID, RESERVATION.CUSTOMER_NUM, CUSTOMER.LAST_NAME
FROM RESERVATION, CUSTOMER
WHERE RESERVATION.CUSTOMER_NUM = CUSTOMER.CUSTOMER_NUM
ORDER BY LAST_NAME;

-- 2. How would you list the trip name of each trip that has Miles Abrams as a guide?

SELECT TRIP_NAME
FROM TRIP, GUIDE
WHERE TRIP.STATE = GUIDE.STATE
AND GUIDE_NUM = 'AM01';

-- 3. How would you find the trip name of all reservations for hiking trips and sort the results by trip name in ascending order.

SELECT TRIP_NAME
FROM RESERVATION, TRIP
WHERE RESERVATION.TRIP_ID = TRIP.TRIP_ID
AND TYPE = 'Hiking';

-- 4. How would you list the reservation ID, trip ID, and trip date for reservations for a trip in Maine (ME). Use the IN operator in your query.

SELECT RESERVATION_ID, TRIP_ID, TRIP_DATE
FROM RESERVATION
WHERE TRIP_ID IN
(
  SELECT TRIP_ID
  FROM TRIP
  WHERE STATE = 'ME'
);

-- 5. How would you list the trip name of each trip that has the type Biking and that has Rita Boyers as a guide? (Note: You will need to pull from the tables: TRIP, GUIDE and TRIP_GUIDES and use the = to match data from two tables.)

SELECT TRIP_NAME
FROM TRIP
WHERE TYPE = 'Biking'
INTERSECT
SELECT TRIP.TRIP_NAME
FROM TRIP, GUIDE, TRIP_GUIDES
WHERE TRIP_GUIDES.TRIP_ID = TRIP.TRIP_ID
AND GUIDE.GUIDE_NUM = 'BR01';

-- 6. How would you list the number and name of each customer that either lives in the state of New Jersey (NJ) and that currently has a reservation or both? (Note: This will require a union)

SELECT CUSTOMER_NUM, LAST_NAME, FIRST_NAME
FROM CUSTOMER
WHERE STATE = 'NJ'
UNION
SELECT CUSTOMER.CUSTOMER_NUM, CUSTOMER.LAST_NAME, CUSTOMER.FIRST_NAME
FROM CUSTOMER, RESERVATION
WHERE RESERVATION.CUSTOMER_NUM = CUSTOMER.CUSTOMER_NUM;

-- 7. How would you display the trip ID, trip name, and reservation ID for all trips? All trips should be included in the result. For those trips that currenlty do not have reservations, the reservation ID should be left blank. Be sure to order the results by trip ID. (Note: This will include a left join)

SELECT TRIP.TRIP_ID, TRIP_NAME, RESERVATION_ID
FROM TRIP
LEFT JOIN RESERVATION
ON TRIP.TRIP_ID = RESERVATION.TRIP_ID
ORDER BY TRIP.TRIP_ID;

-- 8. How would you find the guide last name and first name of all guides who can lead a paddling trip? (The query results should include duplicate values) (Note: This will require an = between tables)

SELECT GUIDE.LAST_NAME, GUIDE.FIRST_NAME
FROM GUIDE, TRIP, TRIP_GUIDES
WHERE TRIP.TRIP_ID = TRIP_GUIDES.TRIP_ID
AND GUIDE.GUIDE_NUM = TRIP_GUIDES.GUIDE_NUM
AND TRIP.TYPE = 'Paddling';

/* ********************************************

CH 6 SQL CASE

********************************************** */

-- 1.1 Create a table in Oracle

CREATE TABLE PADDLING
(
  TRIP_ID DECIMAL(3) NOT NULL PRIMARY KEY,
  TRIP_NAME CHAR(75),
  STATE CHAR (2),
  DISTANCE DECIMAL(4,0),
  MAX_GRP_SIZE DECIMAL(4,0),
  SEASON CHAR(20)
);


-- 1.2 Create a table in Access

CREATE TABLE PADDLING
(
  TRIP_ID NUMBER(3) NOT NULL PRIMARY KEY,
  TRIP_NAME CHAR(75),
  STATE CHAR (2),
  DISTANCE NUMBER(4,0),
  MAX_GRP_SIZE NUMBER(4,0),
  SEASON CHAR(20)
);


-- 2. Show the commands for how you would insert into the PADDLING table the trip ID, trip name, state, distance, maximum group size and season from the trip table for only those trips having type PADDLING?

INSERT INTO PADDLING
SELECT Trip_ID, TRIP_NAME, STATE, DISTANCE, MAX_GRP_SIZE, SEASON
FROM TRIP
WHERE TYPE = 'Paddling';

SELECT *
FROM PADDLING;


-- 3. Show the commands for how you would increase the maximum group size by two for all trips located in Connecticut (CT)? Update the PADDLING table accordingly.

UPDATE PADDLING
SET MAX_GRP_SIZE = MAX_GRP_SIZE +2
WHERE STATE = 'CT';

SELECT *
FROM PADDLING;


-- 4. Show the commands you would use to delete the trip in the PADDLING table with the trip ID 23?

DELETE FROM PADDLING
WHERE Trip_ID = '23';

SELECT *
FROM PADDLING;


-- 5. Show the commands you would use to change the length of the SEASON column in the PADDLING table to 25 characters in Oracle?

ALTER TABLE PADDLING
MODIFY SEASON CHAR(25);

DESCRIBE PADDLING;


-- 6. Show the commands you would use to change the DIFFICULTY_LEVEL column in the PADDLING table to reject nulls in Oracle?

ALTER TABLE PADDLING
ADD DIFFICULTY_LEVEL CHAR(3);

ALTER TABLE PADDLING
MODIFY DIFFICULTY_LEVEL NOT NULL;


/* *************************************

    CH 7 SQL CASE

************************************* */

-- 1. Create a view named MAINE_TRIPS. It consists of the trip ID, trip name, start location, distance, maximum group size, type, and season for every trip located in Maine (ME). Write and execute the CREATE VIEW command to create this view.

CREATE VIEW MAINE_TRIPS AS
SELECT TRIP_ID, TRIP_NAME, START_LOCATION, DISTANCE, MAX_GRP_SIZE, TYPE, SEASON
FROM TRIP
WHERE STATE = 'ME';


-- 2. Write but do not execute the command to revoke all privileges from user Andrews.

REVOKE ALL ON MAINE_TRIPS FROM ANDREWS;


-- 3. Create an index named TRIP_INDEX1 on the TRIP_NAME column in the TRIP table.

CREATE INDEX TRIP_INDEX1 ON TRIP (TRIP_NAME);


-- 4. Ensure that the only legal values for the TYPE column in the TRIP table are Biking, Hiking, or Paddling.

ALTER TABLE TRIP
ADD CHECK (TYPE IN ('Biking', 'Hiking', 'Paddling'));


-- 5. Create a view named TRIP_INVENTORY. It consists of the state and the total number of trips for each state. Use UNITS as the column name for the total number of trips for each state. Group and order the rows by state. Write and execute the CREATE VIEW command to create the TRIP_INVENTORY view.

CREATE VIEW TRIP_INVENTORY (STATE, UNITS) AS
SELECT STATE, COUNT(*)
FROM TRIP
GROUP BY STATE
ORDER BY STATE;
