-- ORION DATA SYSTEMS WORKFORCE ANALYTICS
-- CAPSTONE PROJECT SOLUTION 

USE Capstone;

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM countries;
SELECT * FROM jobs;

-- 1. Workforce Distribution
-- Shows employee count per department and sorts by highest headcount
SELECT d.department_name, COUNT(e.employee_id) AS headcount
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY headcount DESC;


-- 2. Salary Comparison
-- Calculates average salary per department and identifies highest/lowest
SELECT d.department_name, AVG(e.salary) AS average_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY average_salary DESC;


-- 3. Salary Bands for Employees
-- Classifies employees into Low, Medium, and High bands
SELECT emp_name, salary,
    CASE 
        WHEN salary < 5000 THEN 'Low'
        WHEN salary BETWEEN 5000 AND 10000 THEN 'Medium'
        ELSE 'High'
    END AS salary_band
FROM employees;

-- Total count for each band (Part of Question 3)
SELECT 
    CASE 
        WHEN salary < 5000 THEN 'Low'
        WHEN salary BETWEEN 5000 AND 10000 THEN 'Medium'
        ELSE 'High'
    END AS salary_band,
    COUNT(*) AS employee_count
FROM employees
GROUP BY salary_band;


-- 4. Country-Level Analysis
-- Shows the number of departments located in each country
SELECT c.country_name, COUNT(d.department_id) AS number_of_departments
FROM countries c
JOIN departments d ON c.location_id = d.location_id
GROUP BY c.country_name;


-- 5. High Earners
-- Finds employees earning more than the company-wide average
SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);


-- 6. Job Role Analysis
-- Identifies job titles where average salary is above 12,000 using a CTE
WITH JobAvg AS (
    SELECT j.job_title, AVG(e.salary) AS avg_salary
    FROM jobs j
    JOIN employees e ON j.job_id = e.job_id
    GROUP BY j.job_title
)
SELECT job_title, avg_salary
FROM JobAvg
WHERE avg_salary > 12000;


-- 7. Salary Growth Trend
-- Total salaries paid in each country, ordered highest to lowest
SELECT c.country_name, SUM(e.salary) AS total_salary_cost
FROM countries c
JOIN employees e ON c.country_id = e.country_id
GROUP BY c.country_name
ORDER BY total_salary_cost DESC;


-- 8. Workforce Gaps
-- Identifies job roles that currently have no employees assigned
SELECT j.job_title
FROM jobs j
LEFT JOIN employees e ON j.job_id = e.job_id
WHERE e.employee_id IS NULL;