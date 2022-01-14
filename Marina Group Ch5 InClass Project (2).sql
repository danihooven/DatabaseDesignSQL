Q1-For every boat, list the marina number, slip number, boat name, owner number, owner’s first name, and owner’s last name.

SELECT MARINA_NUM, SLIP_NUM, BOAT_NAME, MARINA_SLIP.OWNER_NUM, FIRST_NAME, LAST_NAME
FROM MARINA_SLIP, OWNER
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM;


Q2-For every completed or open service request for routine engine maintenance, list the slip ID, description, and status.

SELECT SLIP_ID, DESCRIPTION, STATUS
FROM SERVICE_REQUEST, SERVICE_CATEGORY
WHERE SERVICE_REQUEST.CATEGORY_NUM = SERVICE_CATEGORY.CATEGORY_NUM
AND CATEGORY_DESCRIPTION = 'Routine engine maintenance';


Q3-For every service request for routine engine maintenance, list the slip ID, marina number, slip number, estimated hours, spent hours, owner number, and owner’s last name.

SELECT SERVICE_REQUEST.SLIP_ID, MARINA_NUM, SLIP_NUM, EST_HOURS, SPENT_HOURS, MARINA_SLIP.OWNER_NUM, LAST_NAME
FROM SERVICE_REQUEST, SERVICE_CATEGORY, MARINA_SLIP, OWNER
WHERE SERVICE_REQUEST.CATEGORY_NUM = SERVICE_CATEGORY.CATEGORY_NUM
AND SERVICE_REQUEST.SLIP_ID = MARINA_SLIP.SLIP_ID
AND MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND CATEGORY_DESCRIPTION = 'Routine engine maintenance';


Q4-List the first and last names of all owners who have a boat in a 30-foot slip. Use the IN operator in your query.

SELECT FIRST_NAME, LAST_NAME
FROM OWNER
WHERE OWNER_NUM IN
(SELECT OWNER_NUM
FROM MARINA_SLIP
WHERE LENGTH = 30);


Q5-List the first and last names of all owners who have a boat in a 30-foot slip. Use the EXISTS operator in your query.

SELECT FIRST_NAME, LAST_NAME
FROM OWNER
WHERE EXISTS
(SELECT *
FROM MARINA_SLIP
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND LENGTH = 30);


Q6-List the names of any pair of boats that have the same type. For example, one pair would be Anderson II and Escape, because the boat type for both boats is Sprite 4000. The first name listed should be the major sort key and the second name should be the minor sort key.

SELECT F.BOAT_NAME, S.BOAT_NAME, F.BOAT_TYPE
FROM MARINA_SLIP F, MARINA_SLIP S
WHERE F.BOAT_TYPE = S.BOAT_TYPE
AND F.BOAT_NAME < S.BOAT_NAME;


Q7-List the boat name, owner number, owner last name, and owner first name for each boat in marina 1.

SELECT BOAT_NAME, MARINA_SLIP.OWNER_NUM, LAST_NAME, FIRST_NAME
FROM MARINA_SLIP, OWNER
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND MARINA_NUM = '1';


Q8-List the boat name, owner number, owner last name, and owner first name for each boat in marina 1 in 40-foot slips.

SELECT BOAT_NAME, MARINA_SLIP.OWNER_NUM, LAST_NAME, FIRST_NAME
FROM MARINA_SLIP, OWNER
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND MARINA_NUM = '1'
AND LENGTH = 40;


Q9-List the marina number, slip number, and boat name for boats whose owners live in Glander Bay OR whose type is Sprite 4000.

SELECT MARINA_NUM, SLIP_NUM, BOAT_NAME
FROM MARINA_SLIP, OWNER
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND CITY = 'Glander Bay'
UNION
SELECT MARINA_NUM, SLIP_NUM, BOAT_NAME
FROM MARINA_SLIP
WHERE BOAT_TYPE = 'Sprite 4000';


Q10-List the marina number, slip number, and boat name for boats whose owners live in Glander Bay AND whose type is Sprite 4000.

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

Q11-List the marina number, slip number, and boat name for boats whose owners live in Glander Bay but whose type is NOT Sprite 4000.

SELECT MARINA_NUM, SLIP_NUM, BOAT_NAME
FROM MARINA_SLIP, OWNER
WHERE MARINA_SLIP.OWNER_NUM = OWNER.OWNER_NUM
AND CITY = 'Glander Bay'
AND BOAT_TYPE NOT IN
(SELECT BOAT_TYPE
FROM MARINA_SLIP
WHERE BOAT_TYPE = 'Sprite 4000');


Q12-Find the service ID and slip ID for each service request whose estimated hours is greater than the number of estimated hours of at least one service request on which the category number is 3.

SELECT SERVICE_ID, SLIP_ID
FROM SERVICE_REQUEST
WHERE EST_HOURS > ANY
(SELECT EST_HOURS
FROM SERVICE_REQUEST
WHERE CATEGORY_NUM = '3');


Q13-Find the service ID and slip ID for each service request whose estimated hours is greater than the number of estimated hours on every service request on which the category number is 3.

SELECT SERVICE_ID, SLIP_ID
FROM SERVICE_REQUEST
WHERE EST_HOURS > ALL
(SELECT EST_HOURS
FROM SERVICE_REQUEST
WHERE CATEGORY_NUM = '3');


Q14-List the slip ID, boat name, owner number, service ID, number of estimated hours, and number of spent hours for each service request on which the category number is 2.

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


Q15-List the slip ID, boat name, owner number, service ID, number of estimated hours, and number of spent hours for each service request on which the category number is 2. Be sure each slip is included regardless of whether the boat in the slip currently has any service requests for category 2.

SELECT MARINA_SLIP.SLIP_ID, BOAT_NAME, OWNER_NUM, SERVICE_ID, EST_HOURS, SPENT_HOURS
FROM MARINA_SLIP
LEFT JOIN SERVICE_REQUEST
ON MARINA_SLIP.SLIP_ID = SERVICE_REQUEST.SLIP_ID
AND CATEGORY_NUM = '2';

