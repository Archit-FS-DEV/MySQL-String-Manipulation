-- Create employees table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);

-- Insert sample data
INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);

-- Check the current SQL modes
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;

-- Update session SQL mode
SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';

-- Example of a division by zero error (will fail)
-- SELECT 1 / 0;

-- Basic salary statistics across the company
SELECT 
    department, 
    salary,
    AVG(salary) OVER() AS avg_salary, 
    MIN(salary) OVER() AS min_salary, 
    MAX(salary) OVER() AS max_salary, 
    CASE
        WHEN AVG(salary) OVER() > 1 THEN (salary / AVG(salary) OVER()) * 100
        ELSE 1
    END AS percentage
FROM employees;

-- Average salary per department
SELECT 
    department, 
    salary, 
    AVG(salary) OVER(PARTITION BY department) AS avg_salary_per_department
FROM employees;

-- Salary expense at company and department levels with percentage contribution
SELECT 
    emp_no,
    department, 
    salary, 
    SUM(salary) OVER() AS company_expense,  -- Total salary expense across company
    SUM(salary) OVER(PARTITION BY department) AS dept_expense,  -- Total salary expense per department
    CONCAT(ROUND((salary / SUM(salary) OVER(PARTITION BY department)) * 100, 2), '%') AS salary_percentage_in_dept,  
    CONCAT(ROUND((salary / SUM(salary) OVER()) * 100, 2), '%') AS salary_percentage_in_company  
FROM employees;

-- Cumulative salary sum per department
SELECT 
    department, 
    salary, 
    SUM(salary) OVER(PARTITION BY department ORDER BY salary) AS cumulative_salary_in_department
FROM employees;

-- Minimum salary per department (descending order)
SELECT 
    department, 
    salary, 
    MIN(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS highest_salary_in_department
FROM employees;

-- 4th highest salary per department
SELECT 
    department, 
    salary, 
    NTH_VALUE(salary, 4) OVER(PARTITION BY department ORDER BY salary DESC) AS fourth_highest_salary_in_department
FROM employees;

-- First (highest) salary holder in the company and per department
SELECT 
    emp_no, 
    department, 
    salary, 
    FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC) AS company_highest_salary_holder,
    FIRST_VALUE(emp_no) OVER(PARTITION BY department ORDER BY salary DESC) AS department_highest_salary_holder
FROM employees;

-- Ranking employees by salary within departments and company-wide
SELECT 
    department, 
    salary, 
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rank_within_department,
    ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_number_global,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS dense_rank_global
FROM employees;

-- Divide salaries into 3 quartiles within departments
SELECT 
    emp_no, 
    department, 
    salary, 
    NTILE(3) OVER(PARTITION BY department ORDER BY salary) AS salary_quartile
FROM employees
ORDER BY salary_quartile;

-- Salary difference from the next highest salary within a department
SELECT 
    department, 
    salary, 
    salary - LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS salary_difference_with_previous
FROM employees;
