-- Creating a table to demonstrate various string functions
CREATE TABLE string_functions_demo (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

-- Inserting sample data
INSERT INTO string_functions_demo (id, name, description) VALUES
(1, 'John', 'A string with name of a person'),
(2, 'Jane', 'Another name of a person'),
(3, 'Alice', 'A name from Wonderland'),
(4, 'Bob', 'Short name of a person'),
(5, '456', 'A numeric string'),
(6, 'hello world', 'A simple string with words'),
(7, '12345', 'A number as a string'),
(8, 'abc123xyz', 'Alphanumeric string with letters and numbers'),
(9, 'The quick brown fox jumps over the lazy dog', 'A famous pangram'),
(10, 'A quick brown fox', 'Another string for testing');

-- Display all data
SELECT * FROM string_functions_demo;

-- ASCII value of the first character in each name
SELECT name, ASCII(SUBSTRING(name, 1, 1)) AS first_char_ascii
FROM string_functions_demo;

-- Convert ID to binary representation
SELECT id, BIN(id) AS binary_representation
FROM string_functions_demo;

-- Calculate bit length of each name
SELECT name, BIT_LENGTH(name) AS bit_length
FROM string_functions_demo;

-- Convert ID to character representation
SELECT id, CHAR(id) AS char_representation
FROM string_functions_demo;

-- Length of names using CHAR_LENGTH and CHARACTER_LENGTH (both are equivalent)
SELECT name, CHAR_LENGTH(name) AS name_length
FROM string_functions_demo;

SELECT name, CHARACTER_LENGTH(name) AS name_character_length
FROM string_functions_demo;

-- Concatenation functions
SELECT CONCAT('My', ' S', ' QL');
SELECT CONCAT(name, ' is a student') AS description
FROM string_functions_demo;

-- Creating a second table to explore additional string functions
CREATE TABLE string_functions_demo2 (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    category VARCHAR(50),
    binary_value INT,
    description TEXT,
    mail VARCHAR(50)
);

-- Inserting data
INSERT INTO string_functions_demo2 (name, category, binary_value, description, mail) VALUES
('John Doe', 'Employee', 5, 'A team leader', 'archit@gmail.com'),
('Jane Smith', 'Manager', 10, 'Handles operations', 'archit@email.com'),
('Alice Brown', 'Developer', 7, 'Backend specialist', 'archit@hotmail.com'),
('Bob White', 'Intern', 3, 'Assisting with tasks', 'archit@gmail.com'),
('Charlie Black', 'CEO', 15, 'Company founder', 'archit@yahoo.com');

-- Extract domain from email
SELECT name, SUBSTRING_INDEX(mail, '@', -1) AS domain
FROM string_functions_demo2;

-- Binary representation using EXPORT_SET
SELECT name, EXPORT_SET(binary_value, 'Yes', 'No', ',', 4) AS bit_representation
FROM string_functions_demo2;

-- Field ranking based on category
SELECT name, FIELD(category, 'Intern', 'Developer', 'Manager', 'CEO', 'Employee') AS position
FROM string_functions_demo2;

-- Sorting by category
SELECT name, category
FROM string_functions_demo2
ORDER BY category;

-- Names starting with 'J'
SELECT name
FROM string_functions_demo2
WHERE name LIKE 'J%';

-- Extract the last 3 characters from each name
SELECT name, RIGHT(name, 3) AS short_name
FROM string_functions_demo2;

-- Convert names to lowercase
SELECT LOWER(name)
FROM string_functions_demo2;

-- Reverse the name string
SELECT REVERSE(name)
FROM string_functions_demo2;

-- Searching for names similar to 'John' using SOUNDEX
SELECT * FROM string_functions_demo2 WHERE LOWER(name) LIKE '%john%';

-- Customer Data Table
CREATE TABLE customer_data1 (
    customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255),
    notes TEXT
);

-- Inserting customer data
INSERT INTO customer_data1 (full_name, email, phone, address, notes) VALUES
('John Doe', 'john.doe@email.com', '1234567890', '123 Main St', 'VIP customer'),
('Jane Smith', 'jane.smith@email.com', '9876543210', '456 Elm St', 'Prefers email'),
('Alice Johnson', 'alice.j@email.com', '5556667777', '789 Oak St', 'Frequent buyer');

-- Find phonetic matches for 'John Doe'
SELECT full_name FROM customer_data1 WHERE SOUNDEX(full_name) = SOUNDEX('Jon Doe');

-- Format names with padding
SELECT RPAD(full_name, 20, '.') AS formatted_name FROM customer_data1;

-- Extract domain from email
SELECT SUBSTRING_INDEX(email, '@', -1) AS domain FROM customer_data1;

-- Formatting phone numbers with a space after the third digit
SELECT full_name, INSERT(phone, 4, 0, ' ') FROM customer_data1;

-- Formatting phone numbers with country code
SELECT full_name, CONCAT(INSERT(phone, 1, 0, '+61'), '', INSERT(phone, 4, 0, ' ')) AS formatted_phone FROM customer_data1;

-- Replace spaces in book titles with '->'
SELECT REPLACE(title, ' ', '->') AS title FROM books;
