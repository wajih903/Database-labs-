-- ============================================================
-- DATABASE SYSTEMS LAB #1 — SQL FILTERS
-- Scope: FILTERS ONLY
-- Excluded: PATTERN MATCHING (LIKE / NOT LIKE)
-- Based on LAB_06_Manual.pdf
-- MySQL 8.x
-- ============================================================

-- ============================================================
-- SETUP: EMPLOYEE DATABASE
-- ============================================================
CREATE DATABASE IF NOT EXISTS filters_lab;
USE filters_lab;

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Gender CHAR(1),
    Salary DECIMAL(10,2),
    HireDate DATE,
    City VARCHAR(30),
    JobTitle VARCHAR(40),
    DeptName VARCHAR(40)
);

INSERT INTO Employee VALUES
(101,'Ali Khan','M',120000,'2018-03-15','Lahore','Senior Engineer','Engineering'),
(102,'Sara Iqbal','F',95000,'2019-06-01','Lahore','Software Engineer','Engineering'),
(103,'Hamza Raza','M',85000,'2020-01-20','Karachi','Software Engineer','Engineering'),
(104,'Ayesha Noor','F',110000,'2017-11-10','Karachi','Marketing Lead','Marketing'),
(105,'Bilal Ahmed','M',70000,'2021-04-05','Karachi','Marketing Exec','Marketing'),
(106,'Fatima Sheikh','F',90000,'2019-09-12','Islamabad','Accountant','Finance'),
(107,'Usman Tariq','M',78000,'2022-02-18','Islamabad','Accountant','Finance'),
(108,'Maira Javed','F',115000,'2016-07-22','Lahore','Research Lead','Research'),
(109,'Zain Abbas','M',60000,'2023-01-09','Lahore','Research Analyst','Research'),
(110,'Nida Yousaf','F',72000,'2022-08-30',NULL,'Research Analyst','Research'),
(111,'Adeel Akhtar','M',88000,'2020-05-14','Lahore','QA Engineer','Engineering'),
(112,'Sana Malik','F',102000,'2018-12-01','Karachi','Sales Manager','Sales'),
(113,'Talha Hussain','M',65000,'2023-07-18','Islamabad','Sales Exec','Sales'),
(114,'Mehwish Anwar','F',80000,'2021-10-25','Lahore','HR Officer','HR'),
(115,'Imran Shafi','M',125000,'2015-04-30',NULL,'Director','Engineering');

-- ============================================================
-- PART A — COMPARISON & LOGICAL OPERATORS
-- Pattern matching tasks are intentionally excluded.
-- ============================================================

-- Task A1: Employees earning more than 90,000
SELECT EmpID, EmpName, Salary
FROM Employee
WHERE Salary > 90000;

-- Task A2: Employees with salary <= 75,000
SELECT EmpName, Salary
FROM Employee
WHERE Salary <= 75000;

-- Task A3: Employees in Lahore and earning more than 90,000
SELECT EmpID, EmpName, Salary, City
FROM Employee
WHERE City = 'Lahore' AND Salary > 90000;

-- Task A4: Employees in Karachi or Islamabad
SELECT EmpName, City
FROM Employee
WHERE City = 'Karachi' OR City = 'Islamabad';

-- Task A5: Female employees who are not in Engineering
SELECT EmpName, Gender, DeptName
FROM Employee
WHERE Gender = 'F' AND DeptName != 'Engineering';

-- Task A6: Male employees earning between 70,000 and 90,000
-- Uses AND + comparison operators only; no BETWEEN.
SELECT EmpName, Gender, Salary
FROM Employee
WHERE Gender = 'M'
  AND Salary >= 70000
  AND Salary <= 90000;

-- Task A7: Software Engineers OR employees earning more than 100,000
SELECT EmpName, JobTitle, Salary
FROM Employee
WHERE JobTitle = 'Software Engineer'
   OR Salary > 100000;

-- Task A8: Employees not in Marketing and not in Sales
SELECT EmpName, DeptName
FROM Employee
WHERE DeptName != 'Marketing'
  AND DeptName != 'Sales';


-- ============================================================
-- PART B — RANGE, LIST, NULL, ORDER BY, LIMIT
-- LIKE / NOT LIKE tasks are excluded.
-- ============================================================

-- Task B1: Salary between 75,000 and 100,000 inclusive
SELECT EmpName, Salary
FROM Employee
WHERE Salary BETWEEN 75000 AND 100000
ORDER BY Salary ASC;

-- Task B2: Employees hired between January 2020 and December 2022
SELECT EmpName, HireDate
FROM Employee
WHERE HireDate BETWEEN '2020-01-01' AND '2022-12-31';

-- Task B3: Salary NOT between 80,000 and 100,000
SELECT EmpName, Salary
FROM Employee
WHERE Salary NOT BETWEEN 80000 AND 100000;

-- Task B4: City is Lahore or Islamabad; sort by city then salary descending
SELECT EmpName, City, Salary
FROM Employee
WHERE City IN ('Lahore', 'Islamabad')
ORDER BY City ASC, Salary DESC;

-- Task B5: Departments except Engineering, Sales, and HR
SELECT EmpName, DeptName
FROM Employee
WHERE DeptName NOT IN ('Engineering', 'Sales', 'HR');

-- Task B10: Employees without a recorded city
SELECT EmpName
FROM Employee
WHERE City IS NULL;

-- Task B11: Employees with a recorded city, sorted alphabetically by city
SELECT EmpName, City
FROM Employee
WHERE City IS NOT NULL
ORDER BY City ASC;

-- Task B12: Three highest paid employees
SELECT EmpName, Salary
FROM Employee
ORDER BY Salary DESC
LIMIT 3;

-- Task B13: Five most recently hired employees
SELECT EmpName, HireDate
FROM Employee
ORDER BY HireDate DESC
LIMIT 5;

-- Task B14: Bottom three salaries
SELECT EmpName, Salary
FROM Employee
ORDER BY Salary ASC
LIMIT 3;

-- Task B15: Sort by department ascending, then hire date ascending
SELECT EmpID, EmpName, DeptName, HireDate
FROM Employee
ORDER BY DeptName ASC, HireDate ASC;


-- ============================================================
-- ASSESSMENT — ONLINE BOOKSTORE
-- Pattern-matching questions Q4 and Q5 are excluded.
-- ============================================================

CREATE DATABASE IF NOT EXISTS bookstore_lab;
USE bookstore_lab;

DROP TABLE IF EXISTS Book;

CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(80) NOT NULL,
    Author VARCHAR(60),
    Genre VARCHAR(30),
    Price DECIMAL(8,2),
    StockQty INT,
    PublishedYear INT,
    Publisher VARCHAR(40),
    Language VARCHAR(20)
);

INSERT INTO Book VALUES
(1,'Pride and Prejudice','Jane Austen','Fiction',850,12,1813,'Penguin','English'),
(2,'Emma','Jane Austen','Fiction',900,8,1815,'Penguin','English'),
(3,'Things Fall Apart','Chinua Achebe','Fiction',1100,5,1958,'Heinemann','English'),
(4,'Norwegian Wood','Haruki Murakami','Fiction',1500,3,1987,'Vintage','English'),
(5,'Kafka on the Shore','Haruki Murakami','Fiction',1700,0,2002,'Vintage','English'),
(6,'Ice-Candy-Man','Bapsi Sidhwa','Fiction',1200,15,1988,'Penguin','English'),
(7,'The Reluctant Fundamentalist','Mohsin Hamid','Fiction',1300,9,2007,'Penguin','English'),
(8,'Exit West','Mohsin Hamid','Fiction',1450,6,2017,'Riverhead','English'),
(9,'Atomic Habits','James Clear','Self-help',1800,20,2018,'Avery','English'),
(10,'The Power of Habit','Charles Duhigg','Self-help',1600,11,2012,'Random House','English'),
(11,'Sapiens','Yuval Harari','History',2200,7,2011,'Harper','English'),
(12,'Rich Dad Poor Dad','Robert Kiyosaki','Finance',1100,25,1997,'Plata','English'),
(13,'Aab-e-Hayat','Ibn-e-Safi','Mystery',650,18,1955,'Asrar','Urdu'),
(14,'Raja Gidh','Bano Qudsia','Fiction',900,14,1981,'Sang-e-Meel','Urdu'),
(15,'Mystery Title',NULL,'Mystery',950,4,2020,NULL,'English');

-- Q1: Books with price greater than 1500
SELECT Title, Price
FROM Book
WHERE Price > 1500;

-- Q2: Books published between 1900 and 2000, sorted by year
SELECT Title, PublishedYear
FROM Book
WHERE PublishedYear BETWEEN 1900 AND 2000
ORDER BY PublishedYear ASC;

-- Q3: Fiction or Mystery books with stock greater than 5
SELECT BookID, Title, Genre, StockQty
FROM Book
WHERE Genre IN ('Fiction', 'Mystery')
  AND StockQty > 5;

-- Q6: Books with no recorded author
SELECT Title
FROM Book
WHERE Author IS NULL;

-- Q7: Out-of-stock books OR books with unknown publisher
SELECT Title, StockQty, Publisher
FROM Book
WHERE StockQty = 0
   OR Publisher IS NULL;

-- Q8: Three most expensive books currently in stock
SELECT Title, Price, StockQty
FROM Book
WHERE StockQty > 0
ORDER BY Price DESC
LIMIT 3;

-- Q9: Urdu books sorted by published year ascending
SELECT Title, PublishedYear, Language
FROM Book
WHERE Language = 'Urdu'
ORDER BY PublishedYear ASC;

-- Q10: Books published before 2000 with price under 1200
SELECT Title, Genre, Price, PublishedYear
FROM Book
WHERE PublishedYear < 2000
  AND Price < 1200
ORDER BY Genre ASC, Title ASC;


-- ============================================================
-- EXCLUDED BY REQUEST
-- ============================================================
-- Employee: B6, B7, B8, B9 (LIKE / NOT LIKE pattern matching)
-- Bookstore: Q4, Q5 (title pattern matching)
-- No LIKE or NOT LIKE queries are included in this file.
-- ============================================================
