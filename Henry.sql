-- 7. Create the table BRANCH using the structure information.

CREATE TABLE BRANCH
(
  BRANCH_NUM DECIMAL(2,0) PRIMARY KEY,
  BRANCH_NAME CHAR(50),
  BRANCH_LOCATION CHAR (50),
  NUM_EMPLOYEES DECIMAL(2,0)
);


-- 8. Describe the BRANCH table.

DESCRIBE BRANCH;


-- 9. Create the table PUBLISHER using the structure information.

CREATE TABLE PUBLISHER
(
  PUBLISHER_CODE CHAR(3) PRIMARY KEY,
  PUBLISHER_NAME CHAR(25),
  CITY CHAR(20)
);


-- 10. Describe the PUBLISHER table.

DESCRIBE PUBLISHER;


-- 11. Create the table AUTHOR using the structure information.

CREATE TABLE AUTHOR
(
  AUTHOR_NUM DECIMAL(2,0) PRIMARY KEY,
  AUTHOR_LAST CHAR(12),
  AUTHOR_FIRST CHAR(10)
);


-- 12. Describe the AUTHOR table.

DESCRIBE AUTHOR;


-- 13. Create the table BOOK using the structure information.

CREATE TABLE BOOK
(
  BOOK_CODE CHAR(4) PRIMARY KEY,
  TITLE CHAR(40),
  PUBLISHER_CODE CHAR(3),
  TYPE CHAR(3),
  PRICE DECIMAL(4,2),
  PAPERBACK CHAR(1)
);


-- 14. Describe the BOOK table.

DESCRIBE BOOK;


-- 15. Create the table WROTE using the structure information. (be sure to notice that two fields make up the primary key, therefore your code will be slightly different from other tables)

CREATE TABLE WROTE
(
  BOOK_CODE CHAR(4),
  AUTHOR_NUM DECIMAL(2,0),
  SEQUENCE DECIMAL(1,0),
  PRIMARY KEY (BOOK_CODE, AUTHOR_NUM)
);


-- 16. Describe the WROTE table.

DESCRIBE WROTE;


-- 17. Create the table INVENTORY using the structure information.

CREATE TABLE INVENTORY
(
  BOOK_CODE CHAR(4),
  BRANCH_NUM DECIMAL(2,0),
  ON_HAND DECIMAL(2,0),
  PRIMARY KEY (BOOK_CODE, BRANCH_NUM)
);


-- 18. Describe the INVENTORY table.

DESCRIBE INVENTORY;


-- 19. SQL command to add Branch 1.

INSERT INTO BRANCH
VALUES
(1, 'Henry Downtown', '16 Riverview', 10);


-- 20. SQL command to add Author 1.

INSERT INTO AUTHOR
VALUES
(1, 'Morrison', 'Toni');


-- 21. SQL command to add the first Book, book code 0180.

INSERT INTO BOOK
VALUES
( '0180', 'A Deepness in the Sky', 'TB', 'SFI', 7.19, 'Y');


-- 22. List all data in the BRANCH table.

SELECT *
FROM BRANCH;


-- 23. List the name of each publisher located in Boston

SELECT PUBLISHER_NAME
FROM PUBLISHER
WHERE CITY = 'Boston';


-- 24. List the name of each publisher NOT located in New York.

SELECT PUBLISHER_NAME
FROM PUBLISHER
WHERE NOT (CITY = 'New York');


-- 25. List the book code and book title of each book that has the type HOR and is in paperback.

SELECT BOOK_CODE, TITLE
FROM BOOK
WHERE TYPE = 'HOR'
AND PAPERBACK = 'Y';


-- 26. List the book code, book title, and price of each book with a price between $15 and $25.

SELECT BOOK_CODE, TITLE, PRICE
FROM BOOK
WHERE PRICE >= 15
AND PRICE <= 25;


-- 27. Customers who are part of a special program get a 10 percent discount off regular book prices. List the book code, book title, price, and discounted price of each book. Use DISCOUNTED_PRICE as the name for the computed column, which should calculate 90 percent of the current price (100 percent less a 10 percent discount).

SELECT BOOK_CODE, TITLE, PRICE, PRICE * .90 AS DISCOUNTED_PRICE
FROM BOOK;


-- 28. List the book code, book title, and price of each book that has the type SFI, MYS, or HOR. Use the IN operator in your command. Sort the books in descending order by price. Within a group of books having the same price, further order the books by title

SELECT BOOK_CODE, TITLE, PRICE
FROM BOOK
WHERE TYPE IN ('SFI', 'MYS', 'HOR')
ORDER BY PRICE DESC, TITLE;


-- 29. How many books have the type SFI?

SELECT COUNT(*)
FROM BOOK
WHERE TYPE = 'SFI';


-- 39. For each type of book, list the type and the average price.

SELECT TYPE, AVG(PRICE)
FROM BOOK
GROUP BY TYPE;


-- 31. How many employees does Henry Books have?

SELECT SUM(NUM_EMPLOYEES)
FROM BRANCH;


-- 32. For each book, list the book code, book title, publisher code, and publisher name. Order the results by publisher name.

SELECT BOOK_CODE, TITLE, BOOK.PUBLISHER_CODE, PUBLISHER.PUBLISHER_NAME
FROM BOOK, PUBLISHER
WHERE BOOK.PUBLISHER_CODE = PUBLISHER.PUBLISHER_CODE
ORDER BY PUBLISHER.PUBLISHER_NAME;


-- 33. List the book code, book title, and units on hand for each book in branch number 3.

SELECT BOOK.BOOK_CODE, TITLE, INVENTORY.ON_HAND
FROM BOOK, INVENTORY
WHERE BOOK.BOOK_CODE = INVENTORY.BOOK_CODE
AND INVENTORY.BRANCH_NUM = 3;


-- 34. Find the book title for each book written by author number 18. Use the IN operator in your query. Hint: you should use a subquery.

SELECT BOOK.TITLE
FROM BOOK
WHERE BOOK_CODE IN
( SELECT BOOK_CODE
  FROM WROTE
  WHERE WROTE.AUTHOR_NUM = 18 );


-- 35. Create a FICTION table with structure shown

CREATE TABLE FICTION
(
    BOOK_CODE CHAR(4) PRIMARY KEY,
    TITLE CHAR(40),
    PUBLISHER_CODE CHAR(3),
    PRICE DECIMAL(4,2)
);


-- 36. Insert into the FICTION table the book code, book title, publisher code, and price from the BOOK table for only those books having FIC.

INSERT INTO FICTION
SELECT BOOK_CODE, TITLE, PUBLISHER_CODE, PRICE
FROM BOOK
WHERE TYPE = 'FIC';


-- 37. Add to the FICTION table a new character column named BEST_SELLER that is one character in length.

ALTER TABLE FICTION
ADD BEST_SELLER CHAR(1);


-- 38. Describe the FICTION table.

DESCRIBE FICTION;


-- 39. In the FICTION table, set the default value for the BEST_SELLER column to N.

UPDATE FICTION
SET BEST_SELLER = 'N';


-- 40. Change the BEST_SELLER column in the FICTION table to Y for the book entitled Song of Solomon.

UPDATE FICTION
SET BEST_SELLER = 'Y'
WHERE TITLE = 'Song of Solomon';


-- 41. Create a view named NONPAPERBACK. It consists of the book code, title, publisher name, and price for every book that is not available in paperback.

CREATE VIEW NONPAPERBACK AS
SELECT BOOK_CODE, TITLE, PUBLISHER_NAME, PRICE
FROM BOOK, PUBLISHER
WHERE BOOK.PUBLISHER_CODE = PUBLISHER.PUBLISHER_CODE
AND PAPERBACK = 'N';


-- 42. Retrieve the book title, publisher name, and price for every book in the NONPAPERBACK view with a price of less than $20.

SELECT TITLE, PUBLISHER_NAME, PRICE
FROM NONPAPERBACK
WHERE PRICE < 20;


-- 43. Create an index named BOOK_INDEX1 on the TITLE column in the BOOK table.

CREATE INDEX BOOK_INDEX1 ON BOOK (TITLE);


-- 44. Add the PUBLISHER_CODE column as a foreign key in the BOOK table.

ALTER TABLE BOOK
ADD FOREIGN KEY (PUBLISHER_CODE) REFERENCES PUBLISHER;


-- 45. Ensure that the PAPERBACK column in the BOOK table can accept only values of Y or N.

ALTER TABLE BOOK
ADD CHECK (PAPERBACK IN ('Y', 'N'));


-- 46. List the author number, first name, and last name for all authors. The first name should appear in lowercase letters and the last name should appear in uppercase letters

SELECT AUTHOR_NUM, LOWER(AUTHOR_FIRST), UPPER(AUTHOR_LAST)
FROM AUTHOR;


-- 47. List the book code, title, and price for all books. The price should be rounded to the nearest dollar.

SELECT BOOK_CODE, TITLE, ROUND (PRICE,0) AS ROUNDED_PRICE
FROM BOOK;
