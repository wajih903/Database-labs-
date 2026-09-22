-- DATABASE SYSTEMS LAB #2 — SQL JOINS
-- PART B ONLY: Tasks B1–B10
-- MySQL 8.x

CREATE DATABASE IF NOT EXISTS joins_lab;
USE joins_lab;

DROP TABLE IF EXISTS Assignment, Project, Employee, Department;

CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(40) NOT NULL,
    Location VARCHAR(30),
    Budget DECIMAL(12,2)
);

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Gender CHAR(1),
    Salary DECIMAL(10,2),
    HireDate DATE,
    City VARCHAR(30),
    ManagerID INT,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID),
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmpID)
);

CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Assignment (
    EmpID INT,
    ProjectID INT,
    HoursPerWeek INT,
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

INSERT INTO Department VALUES
(10,'Engineering','Lahore',5000000),
(20,'Marketing','Karachi',2000000),
(30,'Finance','Islamabad',3000000),
(40,'Research','Lahore',4000000),
(50,'Sales','Karachi',NULL);

INSERT INTO Employee VALUES
(101,'Ali Khan','M',120000,'2018-03-15','Lahore',NULL,10),
(102,'Sara Iqbal','F',95000,'2019-06-01','Lahore',101,10),
(103,'Hamza Raza','M',85000,'2020-01-20','Karachi',101,10),
(104,'Ayesha Noor','F',110000,'2017-11-10','Karachi',NULL,20),
(105,'Bilal Ahmed','M',70000,'2021-04-05','Karachi',104,20),
(106,'Fatima Sheikh','F',90000,'2019-09-12','Islamabad',NULL,30),
(107,'Usman Tariq','M',78000,'2022-02-18','Islamabad',106,30),
(108,'Maira Javed','F',115000,'2016-07-22','Lahore',NULL,40),
(109,'Zain Abbas','M',60000,'2023-01-09','Lahore',108,40),
(110,'Nida Yousaf','F',72000,'2022-08-30',NULL,108,40);

INSERT INTO Project VALUES
(1001,'Website Revamp','2024-01-10','2024-06-30',10),
(1002,'Mobile App','2024-03-01','2024-12-31',10),
(1003,'Brand Campaign','2024-02-15','2024-05-15',20),
(1004,'Audit System','2024-04-01',NULL,30),
(1005,'AI Research','2024-05-01','2025-04-30',40),
(1006,'Internal Tool','2024-06-01','2024-09-30',NULL);

INSERT INTO Assignment VALUES
(101,1001,10),
(102,1001,20),
(102,1002,15),
(103,1002,30),
(104,1003,25),
(105,1003,40),
(106,1004,35),
(108,1005,20),
(109,1005,30);

-- Task B1
-- For each employee, show their name and their manager's name.
-- Top-level managers should still appear with NULL Manager.
SELECT
    e.EmpName AS Employee,
    m.EmpName AS Manager
FROM Employee e
LEFT JOIN Employee m
    ON e.ManagerID = m.EmpID;

-- Task B2
-- List employees who earn more than their direct manager.
SELECT
    e.EmpName AS Employee,
    e.Salary AS EmpSalary,
    m.EmpName AS Manager,
    m.Salary AS MgrSalary
FROM Employee e
INNER JOIN Employee m
    ON e.ManagerID = m.EmpID
WHERE e.Salary > m.Salary;

-- Task B3
-- Employees whose manager works in a different department.
SELECT
    e.EmpName AS EmpName,
    m.EmpName AS ManagerName,
    ed.DeptName AS EmployeeDepartment,
    md.DeptName AS ManagerDepartment
FROM Employee e
INNER JOIN Employee m
    ON e.ManagerID = m.EmpID
INNER JOIN Department ed
    ON e.DeptID = ed.DeptID
INNER JOIN Department md
    ON m.DeptID = md.DeptID
WHERE e.DeptID <> m.DeptID;

-- Task B4
-- Show every employee with the project name they work on and weekly hours.
SELECT
    e.EmpName,
    p.ProjectName,
    a.HoursPerWeek
FROM Employee e
INNER JOIN Assignment a
    ON e.EmpID = a.EmpID
INNER JOIN Project p
    ON a.ProjectID = p.ProjectID;

-- Task B5
-- Every assignment with employee name, project name,
-- and the project's department name.
SELECT
    e.EmpName,
    p.ProjectName,
    d.DeptName
FROM Employee e
INNER JOIN Assignment a
    ON e.EmpID = a.EmpID
INNER JOIN Project p
    ON a.ProjectID = p.ProjectID
LEFT JOIN Department d
    ON p.DeptID = d.DeptID;

-- Task B6
-- Names and weekly hours of employees working on Mobile App.
SELECT
    e.EmpName,
    a.HoursPerWeek
FROM Employee e
INNER JOIN Assignment a
    ON e.EmpID = a.EmpID
INNER JOIN Project p
    ON a.ProjectID = p.ProjectID
WHERE p.ProjectName = 'Mobile App';

-- Task B7
-- Every Lahore employee with assigned projects.
-- Include Lahore employees with no assignments.
SELECT
    e.EmpName,
    p.ProjectName,
    a.HoursPerWeek
FROM Employee e
LEFT JOIN Assignment a
    ON e.EmpID = a.EmpID
LEFT JOIN Project p
    ON a.ProjectID = p.ProjectID
WHERE e.City = 'Lahore';

-- Task B8
-- Employees working on a project run by a different department.
SELECT DISTINCT
    e.EmpName
FROM Employee e
INNER JOIN Assignment a
    ON e.EmpID = a.EmpID
INNER JOIN Project p
    ON a.ProjectID = p.ProjectID
WHERE e.DeptID <> p.DeptID;

-- Task B9
-- For each department, list projects that started in 2024.
-- Include departments with no such projects.
SELECT
    d.DeptID,
    d.DeptName,
    p.ProjectName
FROM Department d
LEFT JOIN Project p
    ON d.DeptID = p.DeptID
    AND p.StartDate >= '2024-01-01'
    AND p.StartDate < '2025-01-01'
ORDER BY d.DeptID, p.ProjectName;

-- Task B10
-- Every employee with total weekly hours across all projects.
-- Include employees with zero hours.
SELECT
    e.EmpID,
    e.EmpName,
    COALESCE(SUM(a.HoursPerWeek), 0) AS TotalHoursPerWeek
FROM Employee e
LEFT JOIN Assignment a
    ON e.EmpID = a.EmpID
GROUP BY e.EmpID, e.EmpName
ORDER BY e.EmpID;

-- END: ONLY PART B IS INCLUDED.
-- Part A and Library Assessment Q1-Q10 are intentionally excluded.
