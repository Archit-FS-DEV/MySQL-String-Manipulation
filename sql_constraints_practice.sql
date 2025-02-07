-- Create table 'p' with constraints
CREATE TABLE p (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR(10) NOT NULL,
    phone VARCHAR(11) NOT NULL UNIQUE,
    age INT,
    CONSTRAINT age_over_18 CHECK (age >= 18)  -- Only works in MySQL 8.0.16+
);

-- Drop and re-add the CHECK constraint
ALTER TABLE p DROP CONSTRAINT age_over_18;
ALTER TABLE p ADD CONSTRAINT age_over_18 CHECK (age >= 18);

-- Insert sample data
INSERT INTO p (name, phone, age) VALUES 
('Alice', '12345678901', 18),
('Bob', '98765432100', 19),
('Charlie', '56789012345', 30);

-- View data in 'p'
SELECT * FROM p;

-- Drop table 'p'
DROP TABLE p;

-- This insert will fail due to CHECK constraint
INSERT INTO p (name, phone, age) VALUES ('Archit', '324345', 13);

-------------------------------------------------------

-- Create table 'companies' with a unique constraint on (phone, address)
CREATE TABLE companies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(10) NOT NULL UNIQUE,
    phone VARCHAR(10) NOT NULL,
    address VARCHAR(10) NOT NULL,
    CONSTRAINT name_Address UNIQUE(phone, address)
);

-- View data in 'companies'
SELECT * FROM companies;

-- Add a new column 'city'
ALTER TABLE companies ADD COLUMN city VARCHAR(10);

-- Remove the 'city' column
ALTER TABLE companies DROP COLUMN city;

-- Rename table 'companies' to 'q'
RENAME TABLE companies TO q;

-- View tables in the database
SHOW TABLES;

-- Rename column 'phone' to 'mobile'
ALTER TABLE q RENAME COLUMN phone TO mobile;

-- Modify the 'name' column to have a max length of 7
ALTER TABLE q MODIFY name VARCHAR(7);

-- Rename column 'name' to 'fame' and set VARCHAR(10)
ALTER TABLE q CHANGE name fame VARCHAR(10);

-- Describe table 'q'
DESC q;
