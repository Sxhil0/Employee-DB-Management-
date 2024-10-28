create database emp_details;
use emp_details;

CREATE TABLE Departments (
    id INT AUTO_INCREMENT PRIMARY KEY,         
    D_name VARCHAR(100) NOT NULL,                
    location VARCHAR(100)                      
);
CREATE TABLE Employees (
    id INT AUTO_INCREMENT PRIMARY KEY,         
    first_name VARCHAR(50) NOT NULL,           
    last_name VARCHAR(50) NOT NULL,            
    email VARCHAR(100) NOT NULL UNIQUE,        
    phone_number VARCHAR(20),                  
    hire_date DATE NOT NULL,                   
    job_title VARCHAR(50) NOT NULL,            
    department_id INT,                         
    FOREIGN KEY (department_id) REFERENCES Departments(id)  
);
CREATE TABLE Projects (
    id INT AUTO_INCREMENT PRIMARY KEY,         
    P_name VARCHAR(100) NOT NULL,                
    P_Description TEXT,                          
    start_date DATE,                           
    end_date DATE,                             
    department_id INT,                        
    FOREIGN KEY (department_id) REFERENCES Departments(id) 
);

CREATE TABLE Timesheets (
    id INT AUTO_INCREMENT PRIMARY KEY,         
    employee_id INT,                           
    project_id INT,                            
    date_ts DATE NOT NULL,                        
    hours DECIMAL(5, 2) NOT NULL,              
    FOREIGN KEY (employee_id) REFERENCES Employees(id),   
    FOREIGN KEY (project_id) REFERENCES Projects(id)      
);

INSERT INTO Departments (D_name, location) VALUES
('HR', 'New York'),           -- D1
('Finance', 'Chicago'),       -- D2
('Engineering', 'San Francisco'), -- D3
('Marketing', 'Los Angeles'), -- D4
('Sales', 'Boston'),
('IT Support', 'San Diego'),  -- D6
('Legal', 'Seattle'),         -- D7
('Operations', 'Houston'),    -- D8
('Customer Service','Miami');

INSERT INTO Employees (first_name, last_name, email, phone_number, hire_date, job_title, department_id) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', '2022-01-15', 'Manager',1),
('Jane', 'Smith', 'jane.smith@example.com', '555-2345', '2021-06-22', 'Developer',3),
('Tom', 'Brown', 'tom.brown@example.com', '555-3456', '2020-09-12', 'Manager',2),
('Lucy', 'Davis', 'lucy.davis@example.com', '555-4567', '2019-11-02', 'Developer',4),
('Mark', 'Taylor', 'mark.taylor@example.com', '555-5678', '2018-08-30', 'Sales Rep',5),
('Emma', 'Watson', 'emma.watson@example.com', '555-8765', '2020-05-14', 'Manager',6),
('David', 'Miller', 'david.miller@example.com', '555-7654', '2019-04-20', 'Developer',6),
('Sophia', 'Wilson', 'sophia.wilson@example.com', '555-6543', '2018-12-01', 'Manager',7),
('Liam', 'Johnson', 'liam.johnson@example.com', '555-5432', '2021-07-17', 'Developer',7),
('Olivia', 'Martinez', 'olivia.martinez@example.com', '555-4321', '2022-09-09', 'HR Specialist',1),
('Lucas', 'Garcia', 'lucas.garcia@example.com', '555-3210', '2023-02-22', 'Marketing Analyst',4),
('Mia', 'Davis', 'mia.davis@example.com', '555-2109', '2023-03-15', 'Sales Rep',5),
('James', 'Brown', 'james.brown@example.com', '555-1098', '2021-10-11', 'Operations Manager',8),
('Isabella', 'Rodriguez', 'isabella.rodriguez@example.com', '555-0987', '2017-08-06', 'Customer Service Rep',9);

INSERT INTO Projects (P_name, P_Description, start_date, end_date, department_id) VALUES
('Project A', 'HR system overhaul', '2023-01-01', '2023-12-31',1),
('Project B', 'Financial Audit', '2023-03-01', '2023-12-01',2),
('Project C', 'New App Development', '2023-05-01', '2024-01-31',3),
('Project D', 'Marketing Campaign', '2023-07-01', '2023-11-30',4),
('Project E', 'Sales Platform Upgrade', '2023-09-01', '2024-06-30',5),
('Project F', 'IT Infrastructure Upgrade', '2023-04-01', '2023-12-31',6),
('Project G', 'Legal Compliance Audit', '2023-07-01', '2023-12-01',7),
('Project H', 'Operations Workflow Optimization', '2023-05-15', '2023-12-31',8),
('Project I', 'Customer Feedback System', '2023-06-01', '2024-03-31',9),
('Project J', 'Cloud Migration', '2023-09-01', '2024-05-31',6);

INSERT INTO Timesheets (employee_id, project_id, date_ts, hours) VALUES
(1, 1, '2023-02-15',8.0),
(2, 3, '2023-05-10',6.5),
(2, 3, '2023-05-11',7.0),
(3, 2, '2023-03-20',8.0),
(4, 4, '2023-08-10',5.5),
(4, 4, '2023-08-11',7.5),
(5, 5, '2023-10-15',6.0),
(6, 6, '2023-06-15',7.5), -- Emma Watson working on Project F
(7, 6, '2023-06-16',8.0), -- David Miller working on Project F
(7, 6, '2023-06-17',6.5),
(8, 7, '2023-08-01',8.0), -- Sophia Wilson working on Project G
(9, 7, '2023-08-02',7.0), -- Liam Johnson working on Project G
(9, 7, '2023-08-03',8.5),
(10, 1, '2023-04-01',8.0), -- Olivia Martinez working on Project A
(11, 4, '2023-05-22',6.0), -- Lucas Garcia working on Project D
(11, 4, '2023-05-23',5.5),
(12, 5, '2023-09-15',7.0), -- Mia Davis working on Project E
(13, 8, '2023-07-05',6.5), -- James Brown working on Project H
(13, 8, '2023-07-06',8.0),
(14, 9, '2023-07-10',6.0), -- Isabella Rodriguez working on Project I
(14, 9, '2023-07-11',6.5),
(1, 3, '2023-06-12',7.5), -- John Doe working on Project C
(1, 3, '2023-06-13',8.0),
(2, 3, '2023-06-14',7.0);

-- 1 Find out the working location of each employee

SELECT e.first_name, e.last_name, d.location
FROM Employees e
JOIN Departments d ON e.department_id = d.id;

-- 2 Create a Salary column & update the salaries for each department as follows: D1 --> 40K, D2 - 30k, D3 -- 55K, D4 --> 60K, D5 - 75K
-- Add the Salary column
ALTER TABLE Employees
ADD COLUMN salary DECIMAL(10, 2);

-- Update the salaries for each department
UPDATE Employees
SET salary = CASE 
    WHEN department_id = 1 THEN 40000
    WHEN department_id = 2 THEN 30000
    WHEN department_id = 3 THEN 55000
    WHEN department_id = 4 THEN 60000
    WHEN department_id = 5 THEN 75000
    ELSE salary
END;
describe employees;

-- 3 Find which project the employee is working on
SELECT e.first_name, e.last_name, p.p_name AS project_name
FROM Employees e
JOIN Timesheets t ON e.id = t.employee_id
JOIN Projects p ON t.project_id = p.id;

-- 4 Find out the total hours worked on each project by each employee
SELECT e.first_name, e.last_name, p.p_name AS project_name, SUM(t.hours) AS total_hours
FROM Employees e
JOIN Timesheets t ON e.id = t.employee_id
JOIN Projects p ON t.project_id = p.id
GROUP BY e.id, p.id;

-- 5 Find those employees who have not worked on any projects
SELECT e.first_name, e.last_name
FROM Employees e
LEFT JOIN Timesheets t ON e.id = t.employee_id
WHERE t.employee_id IS NULL;

-- 6 Find the maximum hours worked on which project
SELECT p.p_name AS project_name, SUM(t.hours) AS total_hours
FROM Timesheets t
JOIN Projects p ON t.project_id = p.id
GROUP BY p.id
ORDER BY total_hours DESC
LIMIT 1;

-- 7 Create a view that stores employees' department names & their salaries
CREATE VIEW EmployeeDepartmentSalaries AS
SELECT e.first_name, e.last_name, d.d_name AS department_name, e.salary
FROM Employees e
JOIN Departments d ON e.department_id = d.id;

-- 8 Create a view that stores the projects allocated to each employee
CREATE VIEW EmployeeProjects AS
SELECT e.first_name, e.last_name, p.p_name AS project_name
FROM Employees e
JOIN Timesheets t ON e.id = t.employee_id
JOIN Projects p ON t.project_id = p.id;

-- 9 Find the employees who have worked more than 40 hours on a single project
SELECT e.first_name, e.last_name, p.p_name AS project_name, SUM(t.hours) AS total_hours
FROM Employees e
JOIN Timesheets t ON e.id = t.employee_id
JOIN Projects p ON t.project_id = p.id
GROUP BY e.id, p.id
HAVING total_hours > 40;

-- 10 Create a query that classifies employees based on their job titles as 'Manager', 'Developer', or 'Other'
SELECT e.first_name, e.last_name, e.job_title,
    CASE 
        WHEN e.job_title LIKE 'Manager' THEN 'Manager'
        WHEN e.job_title LIKE 'Developer' THEN 'Developer'
        ELSE 'Other'
    END AS job_classification
FROM Employees e;

-- 11 Retrieve a list of employees who worked on multiple projects
SELECT e.first_name, e.last_name, COUNT(t.project_id) AS project_count
FROM Employees e
JOIN Timesheets t ON e.id = t.employee_id
GROUP BY e.id
HAVING project_count > 1;

-- 12 Retrieve each employee’s total hours worked on projects, and show the rank of each employee based on total hours worked
SELECT e.first_name, e.last_name, SUM(t.hours) AS total_hours_worked,RANK() OVER (ORDER BY SUM(t.hours) DESC) AS r
FROM Employees e
JOIN Timesheets t ON e.id = t.employee_id
GROUP BY e.id;

-- 13 List all employees whose total hours worked are above the overall average
WITH EmployeeTotalHours AS (
    SELECT e.id, e.first_name, e.last_name, SUM(t.hours) AS total_hours
    FROM Employees e
    JOIN Timesheets t ON e.id = t.employee_id
    GROUP BY e.id
),
AverageHours AS (
    SELECT AVG(total_hours) AS avg_hours FROM EmployeeTotalHours
)
SELECT e.first_name, e.last_name, e.total_hours
FROM EmployeeTotalHours e
JOIN AverageHours a ON e.total_hours > a.avg_hours;