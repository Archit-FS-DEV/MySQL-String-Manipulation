CREATE TABLE books 
(
    book_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100),
    author_fname VARCHAR(100),
    author_lname VARCHAR(100),
    released_year INT,
    stock_quantity INT,
    pages INT,
    PRIMARY KEY(book_id)
);

-- Inserting sample book records
INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman', 2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465);

-- Aggregate Query: Grouping books by release year with count and average pages
SELECT released_year, COUNT(*) AS '# books', AVG(pages) AS 'avg pages' 
FROM books 
GROUP BY released_year 
ORDER BY released_year ASC;

-- Counting total books
SELECT COUNT(title) AS total_books FROM books;

-- Finding the author with the book containing the maximum number of pages
SELECT CONCAT(author_lname, ', ', author_fname) AS author, title, pages 
FROM books 
WHERE pages = (SELECT MAX(pages) FROM books);

-- Listing books for each author using JSON aggregation
SELECT author_lname, JSON_ARRAYAGG(title) AS titles FROM books GROUP BY author_lname;

-- Finding the earliest and latest release year for each author
SELECT CONCAT(author_lname, ', ', author_fname) AS author, 
       MIN(released_year) AS min_year, 
       MAX(released_year) AS max_year, 
       COUNT(*) AS number_of_books 
FROM books 
GROUP BY author;

-- Finding books with the earliest release year
SELECT title, released_year FROM books 
WHERE released_year = (SELECT MIN(released_year) FROM books);

-- Fetching books where author's last name contains a space (e.g., double last names)
SELECT title, author_lname FROM books WHERE author_lname LIKE "% %";

-- Formatting book summary with substring and release year
SELECT CONCAT(SUBSTRING(title,1,20), ' - ', released_year) AS summary 
FROM books ORDER BY released_year DESC LIMIT 3;

-- Fetching books with "Stories" in the title
SELECT title FROM books WHERE title LIKE '%Stories%';

-- Finding books where author's first name is exactly four letters
SELECT * FROM books WHERE LOWER(author_fname) LIKE '____';

-- Formatting author's full name in uppercase
SELECT UPPER(CONCAT(author_fname, ' ', author_lname)) AS full_name_caps FROM books;

-- Replacing release year for books with stock quantity less than 300
SELECT REPLACE(released_year, '2003', '1999') FROM books WHERE stock_quantity < 300;

CREATE TABLE people (
	name VARCHAR(100),
    birthdate DATE,
    birthtime TIME,
    birthdt DATETIME
);
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Elton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00');
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Lulu', '1985-04-11', '9:45:10', '1985-04-11 9:45:10');
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Juan', '2020-08-15', '23:59:00', '2020-08-15 23:59:00');

-- Working with date functions
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %D') AS formatted_date FROM people;
SELECT birthdt, DATE_FORMAT(birthdt, 'BORN ON: %r') AS birth_time FROM people;

-- Creating a table with timestamp defaults
CREATE TABLE hello (
    text VARCHAR(100),
    current_time_now TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_timestamp TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Fetching current day name
SELECT DAYNAME(NOW());

-- Formatting current date
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');
SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i');



-- Add 25 days to a date
SELECT DATE_ADD('2025-02-10', INTERVAL 25 DAY);

-- Add 1 month to a date
SELECT DATE_ADD('2025-02-10', INTERVAL 1 MONTH);

-- Select people 21 years or older
SELECT 
    name, 
    birthdate, 
    YEAR(birthdate + INTERVAL 21 YEAR) AS man 
FROM people 
WHERE birthdate <= NOW() - INTERVAL 21 YEAR;

-- Extract various date components
SELECT 
    birthdate,
    DAY(birthdate),
    DAYOFWEEK(birthdate),
    DAYOFYEAR(birthdate), 
    MINUTE(birthdt),
    HOUR(birthdt),
    SECOND(birthdt)
FROM people;

-- Format date as Month Day Year
SELECT CONCAT(MONTHNAME(birthdate), ' ', DAY(birthdate), ' ', YEAR(birthdate)) AS formatted_Date 
FROM people;

-- Format date with abbreviated day, month, and ordinal day
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %D') 
FROM people;

-- Format time in HH:MM
SELECT birthdt, DATE_FORMAT(birthdt, '%H:%i') 
FROM people;

-- Format with "BORN ON:" prefix
SELECT birthdt, DATE_FORMAT(birthdt, 'BORN ON: %r') 
FROM people;

-- Create table with timestamp columns
CREATE TABLE hello (
    text VARCHAR(100),
    current_time_now TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_timestamp TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Get current day name
SELECT DAYNAME(NOW());

-- Alternative day name format
SELECT DATE_FORMAT(NOW(), '%W');

-- Current date in MM/DD/YYYY
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');

-- Formatted date and time
SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i') AS formatted_datetime;
