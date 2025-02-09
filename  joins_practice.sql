CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
 
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    foreign key(customer_id) references customers(id) ON DELETE cascade
    
);

 
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
select * from customers c join orders o on c.id = o.customer_id;

SELECT concat( first_name,' ', last_name) as name ,email,amount
FROM customers 
JOIN orders USING (id);




select concat( first_name,' ', last_name) as name, IFNULL(sum(amount),0) as amount from customers c 
left join orders o 
on c.id=o.customer_id 
group by first_name,last_name
order by amount asc;


-- left join
select concat( first_name,' ', last_name) as name, email, amount as amount from customers c 
left join orders o 
on c.id=o.customer_id;

-- right join
select concat( first_name,' ', last_name) as name, email,amount as amount from customers c 
right join orders o 
on c.id=o.customer_id;


delete from customers where last_name = 'George';

select * from orders;




-- 1️⃣ Create Students Table
CREATE TABLE students (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    f_name VARCHAR(20)
);

-- 2️⃣ Create Papers Table with Foreign Key (ON DELETE CASCADE)
CREATE TABLE papers (
    title VARCHAR(40),
    grade INT,
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- 3️⃣ Insert Sample Data into Students Table
INSERT INTO students (f_name) VALUES 
    ('Caleb'), 
    ('Samantha'), 
    ('Raj'), 
    ('Carlos'), 
    ('Lisa');

-- 4️⃣ Insert Sample Data into Papers Table
INSERT INTO papers (student_id, title, grade) VALUES
    (1, 'My First Book Report', 60),
    (1, 'My Second Book Report', 75),
    (2, 'Russian Lit Through The Ages', 94),
    (2, 'De Montaigne and The Art of The Essay', 98),
    (4, 'Borges and Magical Realism', 89);

-- 5️⃣ Get all students with their papers (Even if no papers exist)
SELECT 
    s.f_name, 
    p.title, 
    p.grade 
FROM students s 
LEFT JOIN papers p ON s.id = p.student_id 
ORDER BY p.grade DESC;

-- 6️⃣ Replace NULL values with "MISSING" for title and 0 for grade
SELECT 
    s.f_name, 
    IFNULL(p.title, 'MISSING') AS title, 
    IFNULL(p.grade, 0) AS grade 
FROM students s 
LEFT JOIN papers p ON s.id = p.student_id;

-- 7️⃣ Get Average Grade per Student
SELECT 
    s.f_name, 
    AVG(p.grade) AS avg_grade 
FROM students s 
LEFT JOIN papers p ON s.id = p.student_id 
GROUP BY s.f_name 
ORDER BY avg_grade DESC;

-- 8️⃣ Determine Passing Status Based on Average Grade
SELECT 
    s.f_name, 
    AVG(p.grade) AS avg_grade,
    CASE 
        WHEN AVG(p.grade) > 70 THEN 'Passing'
        ELSE 'Failing' 
    END AS passing_status
FROM students s 
LEFT JOIN papers p ON s.id = p.student_id 
GROUP BY s.f_name 
ORDER BY avg_grade DESC;
