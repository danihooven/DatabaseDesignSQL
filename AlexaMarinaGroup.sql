/* ********************************************

      CHF 7 GROUP PROJECT

******************************************* */

-- 1.a

CREATE VIEW LARGE_SLIP AS
SELECT MARINA_NUM, SLIP_NUM, RENTAL_FEE, BOAT_NAME, OWNER_NUM
FROM SLIP
WHERE LENGTH = 40;


-- 1.b

SELECT *
FROM LARGE_SLIP
WHERE RENTAL_FEE>=3800;


-- 1.c

-- 1.d
-- Yes, you can add in this view because contains primary key. Only pulls from one table.

-- 2.a

SELECT MARINA_NUM, SLIP_NUM, RENTAL_FEE, LAST_NAME
FROM MARINA_SLIP, OWNER
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND BOAT_TYPE = 'Ray4025';


-- 2.b

SELECT *
FROM RAY_4025

GRANT INSERT ON MARINA_SLIP TO CRANDALL, PEREZ;

GRANT UPDATE(RENTAL_FEE)ON MARINA_SLIP TO JOHNSON, KLEIN;

GRANT SELECT (LENGTH, BOAT_NAME, OWNER_NUM) ON MARINA_SLIP TO PUBLIC;

GRANT INSERT, DELETE ON SERVICE_CATEGORY TO KLEIN;

GRANT INDEX ON SERVICE_REQUEST TO ADAMS;
-- INDEX BEHIND SCENES KEEPS ORDER LIST

GRANT ALTER ON MARINA_SLIP TO ADAMS, KLEIN;

GRANT ALL ON MARINA_SLIP TO KLEIN;

REVOKE ALL PRIVILEGES, GRANT OPTION FROM ADAMS;

CREATE INDEX BOAT_INDEX1 ON MARINA_SLIP(OWNER_NUM);

CREATE INDEX BOAT_INDEX1 ON MARINA_SLIP(LENGTH DESC, BOAT_NAME);


/* ***********************************************

      CH 6 GROUP PROJECT

*********************************************** */

-- 1. Create a LARGE_SLIP table with the structure shown (see worksheet).

CREATE TABLE LARGE_SLIP
(
  MARINA_NUM CHAR(4) NOT NULL,
  SLIP_NUM CHAR(4) NOT NULL,
  RENTAL_FEE DECIMAL (8,2),
  BOAT_NAME CHAR(50),
  OWNER_NUM CHAR(4),
  PRIMARY KEY (MARINA_NUM, SLIP_NUM)
);

DESCRIBE LARGE_SLIP;

-- 2. Insert existing data from MARINA_SLIP where LENGTH = 40

INSERT INTO LARGE_SLIP
SELECT MARINA_NUM, SLIP_NUM, RENTAL_FEE, BOAT_NAME, OWNER_NUM
FROM MARINA_SLIP
WHERE LENGTH = 40;

SELECT *
FROM LARGE_SLIP;

-- 3. Increase rental fee by $150

UPDATE LARGE_SLIP
SET RENTAL_FEE = RENTAL_FEE +150;

SELECT *
FROM LARGE_SLIP;

-- 4. Decrease rental fee by 1% WHERE FEE > 4000

UPDATE LARGE_SLIP
SET RENTAL_FEE = RENTAL_FEE *.99
WHERE RENTAL_FEE > 4000;

SELECT *
FROM LARGE_SLIP;

-- 5. Insert new row.

INSERT INTO LARGE_SLIP
VALUES
('1', 'A4', 3900, 'Bilmore', 'FE82');

SELECT *
FROM LARGE_SLIP;

-- 6. Delete all slips with owner TR72

DELETE FROM LARGE_SLIP
WHERE OWNER_NUM = 'TR72';

SELECT *
FROM LARGE_SLIP;

-- 7. CHANGE MARINA 1 SLIP A1 BOAT_NAME TO NULL

UPDATE LARGE_SLIP
SET BOAT_NAME = NULL
WHERE MARINA_NUM = '1'
AND SLIP_NUM = 'A1';

SELECT *
FROM LARGE_SLIP;

-- 8. Add new CHAR column. Set value 'N'

ALTER TABLE LARGE_SLIP
ADD CHARTER CHAR(1);

UPDATE LARGE_SLIP
SET CHARTER = 'N';

SELECT *
FROM LARGE_SLIP;

-- 9. Change charter to Y for 'Our Toy'

UPDATE LARGE_SLIP
SET CHARTER = 'Y'
WHERE BOAT_NAME = 'Our Toy';

-- 10. Change BOAT_NAME to 60 characters

ALTER TABLE LARGE_SLIP
MODIFY BOAT_NAME CHAR(60);

DESCRIBE LARGE_SLIP;

-- 11. Change RENTAL_FEE to not null.

ALTER TABLE LARGE_SLIP
MODIFY RENTAL_FEE NOT NULL;

DESCRIBE LARGE_SLIP;

-- 12. Describe LARGE_SLIP

DESCRIBE LARGE_SLIP;

-- 13. Select all from LARGE_SLIP.

SELECT *
FROM LARGE_SLIP;

-- 14. Delete LARGE_SLIP.

DROP TABLE LARGE_SLIP;

/* ************************************************************

    CH 5 GROUP PROJECT

************************************************************ */

-- 1. For every boat, list the marina number, slip number, boat name, owner number, owner’s first name, and owner’s last name.

SELECT MARINA_NUM, SLIP_NUM, BOAT_NAME, MARINA_SLIP.OWNER_NUM, FIRST_NAME, LAST_NAME
FROM MARINA_SLIP, OWNER
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM;


-- 2. For every completed or open service request for routine engine maintenance, list the slip ID, description, and status.

SELECT SLIP_ID, DESCRIPTION, STATUS
FROM SERVICE_REQUEST, SERVICE_CATEGORY
WHERE SERVICE_REQUEST.CATEGORY_NUM = SERVICE_CATEGORY.CATEGORY_NUM
AND CATEGORY_DESCRIPTION = 'Routine engine maintenance';


-- 3. For every service request for routine engine maintenance, list the slip ID, marina number, slip number, estimated hours, spent hours, owner number, and owner’s last name.

SELECT SERVICE_REQUEST.SLIP_ID, MARINA_NUM, SLIP_NUM, EST_HOURS, SPENT_HOURS, MARINA_SLIP.OWNER_NUM, LAST_NAME
FROM SERVICE_REQUEST, SERVICE_CATEGORY, MARINA_SLIP, OWNER
WHERE SERVICE_REQUEST.CATEGORY_NUM = SERVICE_CATEGORY.CATEGORY_NUM
AND SERVICE_REQUEST.SLIP_ID = MARINA_SLIP.SLIP_ID
AND MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND CATEGORY_DESCRIPTION = 'Routine engine maintenance';


-- 4. List the first and last names of all owners who have a boat in a 30-foot slip. Use the IN operator in your query.

SELECT FIRST_NAME, LAST_NAME
FROM OWNER
WHERE OWNER_NUM IN
(SELECT OWNER_NUM
FROM MARINA_SLIP
WHERE LENGTH = 30);


-- 5. List the first and last names of all owners who have a boat in a 30-foot slip. Use the EXISTS operator in your query.

SELECT FIRST_NAME, LAST_NAME
FROM OWNER
WHERE EXISTS
(SELECT *
FROM MARINA_SLIP
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND LENGTH = 30);


-- 6. List the names of any pair of boats that have the same type. For example, one pair would be Anderson II and Escape, because the boat type for both boats is Sprite 4000. The first name listed should be the major sort key and the second name should be the minor sort key.

SELECT F.BOAT_NAME, S.BOAT_NAME, F.BOAT_TYPE
FROM MARINA_SLIP F, MARINA_SLIP S
WHERE F.BOAT_TYPE = S.BOAT_TYPE
AND F.BOAT_NAME < S.BOAT_NAME;


-- 7. List the boat name, owner number, owner last name, and owner first name for each boat in marina 1.

SELECT BOAT_NAME, MARINA_SLIP.OWNER_NUM, LAST_NAME, FIRST_NAME
FROM MARINA_SLIP, OWNER
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND MARINA_NUM = '1';


-- 8. List the boat name, owner number, owner last name, and owner first name for each boat in marina 1 in 40-foot slips.

SELECT BOAT_NAME, MARINA_SLIP.OWNER_NUM, LAST_NAME, FIRST_NAME
FROM MARINA_SLIP, OWNER
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND MARINA_NUM = '1'
AND LENGTH = 40;


-- 9. List the marina number, slip number, and boat name for boats whose owners live in Glander Bay OR whose type is Sprite 4000.

SELECT MARINA_NUM, SLIP_NUM, BOAT_NAME
FROM MARINA_SLIP, OWNER
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND CITY = 'Glander Bay'
UNION
SELECT MARINA_NUM, SLIP_NUM, BOAT_NAME
FROM MARINA_SLIP
WHERE BOAT_TYPE = 'Sprite 4000';


-- 10. List the marina number, slip number, and boat name for boats whose owners live in Glander Bay AND whose type is Sprite 4000.

SELECT MARINA_NUM, SLIP_NUM, BOAT_NAME
FROM MARINA_SLIP, OWNER
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND CITY = 'Glander Bay'
AND MARINA_NUM IN
(SELECT MARINA_NUM
FROM MARINA_SLIP
WHERE BOAT_TYPE = 'Sprite 4000');

-----OR-----

select marina_num, slip_num, boat_name
from marina_slip, owner
where marina_slip.owner_num = owner.owner_num
and city = 'Glander Bay'
and boat_type = 'Sprite 4000'
;

-- 11. List the marina number, slip number, and boat name for boats whose owners live in Glander Bay but whose type is NOT Sprite 4000.

SELECT MARINA_NUM, SLIP_NUM, BOAT_NAME
FROM MARINA_SLIP, OWNER
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND CITY = 'Glander Bay'
AND BOAT_TYPE NOT IN
(SELECT BOAT_TYPE
FROM MARINA_SLIP
WHERE BOAT_TYPE = 'Sprite 4000');


-- 12. Find the service ID and slip ID for each service request whose estimated hours is greater than the number of estimated hours of at least one service request on which the category number is 3.

SELECT SERVICE_ID, SLIP_ID
FROM SERVICE_REQUEST
WHERE EST_HOURS > ANY
(SELECT EST_HOURS
FROM SERVICE_REQUEST
WHERE CATEGORY_NUM = '3');


-- 13. Find the service ID and slip ID for each service request whose estimated hours is greater than the number of estimated hours on every service request on which the category number is 3.

SELECT SERVICE_ID, SLIP_ID
FROM SERVICE_REQUEST
WHERE EST_HOURS > ALL
(SELECT EST_HOURS
FROM SERVICE_REQUEST
WHERE CATEGORY_NUM = '3');


-- 14. List the slip ID, boat name, owner number, service ID, number of estimated hours, and number of spent hours for each service request on which the category number is 2.

SELECT MARINA_SLIP.SLIP_ID, BOAT_NAME, OWNER_NUM, SERVICE_ID, EST_HOURS, SPENT_HOURS
FROM MARINA_SLIP
INNER JOIN SERVICE_REQUEST
ON MARINA_SLIP.SLIP_ID = SERVICE_REQUEST.SLIP_ID
WHERE CATEGORY_NUM = '2'
;

-----OR-----

SELECT MARINA_SLIP.SLIP_ID, BOAT_NAME, OWNER_NUM, SERVICE_ID, EST_HOURS, SPENT_HOURS
FROM MARINA_SLIP, SERVICE_REQUEST
WHERE MARINA_SLIP.SLIP_ID = SERVICE_REQUEST.SLIP_ID
AND CATEGORY_NUM = '2';


-- 15. List the slip ID, boat name, owner number, service ID, number of estimated hours, and number of spent hours for each service request on which the category number is 2. Be sure each slip is included regardless of whether the boat in the slip currently has any service requests for category 2.

SELECT MARINA_SLIP.SLIP_ID, BOAT_NAME, OWNER_NUM, SERVICE_ID, EST_HOURS, SPENT_HOURS
FROM MARINA_SLIP
LEFT JOIN SERVICE_REQUEST
ON MARINA_SLIP.SLIP_ID = SERVICE_REQUEST.SLIP_ID
AND CATEGORY_NUM = '2';


/* ***********************************************

    ALEXA MARINA GROUP SCRIPT

************************************************ */

CREATE TABLE MARINA
(MARINA_NUM CHAR(4) PRIMARY KEY,
NAME CHAR(20),
ADDRESS CHAR(15),
CITY CHAR(15),
STATE CHAR(2),
ZIP CHAR(5) );

CREATE TABLE MARINA_SLIP
(SLIP_ID DECIMAL(4,0) PRIMARY KEY,
MARINA_NUM CHAR(4),
SLIP_NUM CHAR(4),
LENGTH DECIMAL(4,0),
RENTAL_FEE DECIMAL(8,2),
BOAT_NAME CHAR(50),
BOAT_TYPE CHAR(50),
OWNER_NUM CHAR(4) );

CREATE TABLE OWNER
(OWNER_NUM CHAR(4) PRIMARY KEY,
LAST_NAME CHAR(50),
FIRST_NAME CHAR(20),
ADDRESS CHAR(15),
CITY CHAR(15),
STATE CHAR(2),
ZIP CHAR(5) );

CREATE TABLE SERVICE_CATEGORY
(CATEGORY_NUM DECIMAL(4,0) PRIMARY KEY,
CATEGORY_DESCRIPTION CHAR(255) );

CREATE TABLE SERVICE_REQUEST
(SERVICE_ID DECIMAL(4,0) PRIMARY KEY,
SLIP_ID DECIMAL(4,0),
CATEGORY_NUM DECIMAL(4,0),
DESCRIPTION CHAR(255),
STATUS CHAR(255),
EST_HOURS DECIMAL(4,2),
SPENT_HOURS DECIMAL(4,2),
NEXT_SERVICE_DATE DATE );

INSERT INTO MARINA
VALUES
('1','Alexamara East','108 2nd Ave.','Brinman','FL','32273');
INSERT INTO MARINA
VALUES
('2','Alexamara Central','283 Branston','W. Brinman','FL','32274');
INSERT INTO MARINA_SLIP
VALUES
(1,'1','A1',40,3800.00,'Anderson II','Sprite 4000','AN75');
INSERT INTO MARINA_SLIP
VALUES
(2,'1','A2',40,3800.00,'Our Toy','Ray 4025','EL25');
INSERT INTO MARINA_SLIP
VALUES
(3,'1','A3',40,3600.00,'Escape','Sprite 4000','KE22');
INSERT INTO MARINA_SLIP
VALUES
(4,'1','B1',30,2400.00,'Gypsy','Dolphin 28','JU92');
INSERT INTO MARINA_SLIP
VALUES
(5,'1','B2',30,2600.00,'Anderson III','Sprite 3000','AN75');
INSERT INTO MARINA_SLIP
VALUES
(6,'2','1',25,1800.00,'Bravo','Dolphin 25','AD57');
INSERT INTO MARINA_SLIP
VALUES
(7,'2','2',25,1800.00,'Chinook','Dolphin 22','FE82');
INSERT INTO MARINA_SLIP
VALUES
(8,'2','3',25,2000.00,'Listy','Dolphin 25','SM72');
INSERT INTO MARINA_SLIP
VALUES
(9,'2','4',30,2500.00,'Mermaid','Dolphin 28','BL72');
INSERT INTO MARINA_SLIP
VALUES
(10,'2','5',40,4200.00,'Axxon II','Dolphin 40','NO27');
INSERT INTO MARINA_SLIP
VALUES
(11,'2','6',40,4200.00,'Karvel','Ray 4025','TR72');

INSERT INTO OWNER
VALUES
('AD57','Adney','Bruce and Jean','208 Citrus','Bowton','FL','31313');
INSERT INTO OWNER
VALUES
('AN75','Anderson','Bill','18 Wilcox','Glander Bay','FL','31044');
INSERT INTO OWNER
VALUES
('BL72','Blake','Mary','2672 Commodore','Bowton','FL','31313');
INSERT INTO OWNER
VALUES
('EL25','Elend','Sandy and Bill','462 Riverside','Rivard','FL','31062');
INSERT INTO OWNER
VALUES
('FE82','Feenstra','Daniel','7822 Coventry','Kaleva','FL','32521');
INSERT INTO OWNER
VALUES
('JU92','Juarez','Maria','8922 Oak','Rivard','FL','31062');
INSERT INTO OWNER
VALUES
('KE22','Kelly','Alyssa','5271 Waters','Bowton','FL','31313');
INSERT INTO OWNER
VALUES
('NO27','Norton','Peter','2811 Lakewood','Lewiston','FL','32765');
INSERT INTO OWNER
VALUES
('SM72','Smeltz','Becky and Dave','922 Garland','Glander Bay','FL','31044');
INSERT INTO OWNER
VALUES
('TR72','Trent','Ashton','922 Crest','Bay Shores','FL','30992');

INSERT INTO SERVICE_CATEGORY
VALUES
(1,'Routine engine maintenance');
INSERT INTO SERVICE_CATEGORY
VALUES
(2,'Engine repair');
INSERT INTO SERVICE_CATEGORY
VALUES
(3,'Air conditioning');
INSERT INTO SERVICE_CATEGORY
VALUES
(4,'Electrical systems');
INSERT INTO SERVICE_CATEGORY
VALUES
(5,'Fiberglass repair');
INSERT INTO SERVICE_CATEGORY
VALUES
(6,'Canvas installation');
INSERT INTO SERVICE_CATEGORY
VALUES
(7,'Canvas repair');
INSERT INTO SERVICE_CATEGORY
VALUES
(8,'Electronic systems (radar, GPS, autopilots, etc.)');

INSERT INTO SERVICE_REQUEST
VALUES
(1,1,3,'Air conditioner periodically stops with code indicating low coolant level. Diagnose and repair.','Technician has verified the problem. Air conditioning specialist has been called.','4','2','7-12-2010');
INSERT INTO SERVICE_REQUEST
VALUES
(2,5,4,'Fuse on port motor blown on two occasions. Diagnose and repair.','Open','2','0','7-12-2010');
INSERT INTO SERVICE_REQUEST
VALUES
(3,4,1,'Oil change and general routine maintenance (check fluid levels, clean sea strainers etc.).','Service call has been scheduled.','1','0','7-16-2010');
INSERT INTO SERVICE_REQUEST
VALUES
(4,1,2,'Engine oil level has been dropping drastically. Diagnose and repair.','Open','2','0','7-13-2010');
INSERT INTO SERVICE_REQUEST
VALUES
(5,3,5,'Open pockets at base of two stantions.','Technician has completed the initial filling of the open pockets. Will complete the job after the initial fill has had sufficient time to dry.','4','2','7-13-2010');
INSERT INTO SERVICE_REQUEST
VALUES
(6,11,4,'Electric-flush system periodically stops functioning. Diagnose and repair.','Open','3','0','12-13-2020');
INSERT INTO SERVICE_REQUEST
VALUES
(7,6,2,'Engine overheating. Loss of coolant. Diagnose and repair.','Open','2','0','7-13-2010');
INSERT INTO SERVICE_REQUEST
VALUES
(8,6,2,'Heat exchanger not operating correctly.','Technician has determined that the exchanger is faulty. New exchanger has been ordered.','4','1','7-17-2010');
INSERT INTO SERVICE_REQUEST
VALUES
(9,7,6,'Canvas severely damaged in windstorm. Order and install new canvas.','Open','8','0','7-16-2010');
INSERT INTO SERVICE_REQUEST
VALUES
(10,2,8,'Install new GPS and chart plotter','Scheduled','7','0','7-17-2010');
INSERT INTO SERVICE_REQUEST
VALUES
(11,2,3,'Air conditioning unit shuts down with HHH showing on the control panel.','Technician not able to replicate the problem. Air conditioning unit ran fine through multiple tests. Owner to notify technician if the problem recurs.','1','1','12-31-2020');
INSERT INTO SERVICE_REQUEST
VALUES
(12,4,8,'Both speed and depth readings on data unit are significantly less than the owner thinks they should be.','Technician has scheduled appointment with owner to attempt to verify the problem.','2','0','7-16-2010');
INSERT INTO SERVICE_REQUEST
VALUES
(13,8,2,'Customer describes engine as making a clattering sound.','Technician suspects problem with either propeller or shaft and has scheduled the boat to be pulled from the water for further investigation.','5','2','7-12-2010');
INSERT INTO SERVICE_REQUEST
VALUES
(14,7,5,'Owner accident caused damage to forward portion of port side.','Technician has scheduled repair.','6','0','7-13-2010');
INSERT INTO SERVICE_REQUEST
VALUES
(15,11,7,'Canvas leaks around zippers in heavy rain. Install overlap around zippers to prevent leaks.','Overlap has been created. Installation has been scheduled.','8','3','7-17-2010');
UPDATE SERVICE_REQUEST
SET NEXT_SERVICE_DATE = Null
WHERE NEXT_SERVICE_DATE = '12-31-2020';
