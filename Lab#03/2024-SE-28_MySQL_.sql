-- University MySQL Lab Solution
-- Based on LAB_03_Manual.pdf
-- MySQL 8.x

CREATE DATABASE IF NOT EXISTS university_lab;
USE university_lab;

-- =========================================================
-- 1. Clean start (safe for a lab database)
-- =========================================================
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS instructors;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS departments;

-- =========================================================
-- 2. DATABASE KEYS + TABLE CREATION
-- =========================================================

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) UNIQUE
);

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT,
    dept_id INT,
    CONSTRAINT fk_students_department
        FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    dept_id INT,
    CONSTRAINT fk_courses_department
        FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    dept_id INT,
    CONSTRAINT fk_instructors_department
        FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Composite key: (student_id, course_id)
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    semester VARCHAR(20),
    PRIMARY KEY (student_id, course_id),
    CONSTRAINT fk_enrollments_student
        FOREIGN KEY (student_id) REFERENCES students(student_id),
    CONSTRAINT fk_enrollments_course
        FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- =========================================================
-- 3. SAMPLE DATA
-- =========================================================

INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'CS'),
(2, 'EE');

INSERT INTO students (name, email, age, dept_id) VALUES
('Ali', 'ali@gmail.com', 20, 1),
('Sara', 'sara@gmail.com', 21, 1),
('Ahmed', 'ahmed@gmail.com', 22, 2);

INSERT INTO courses (course_id, course_name, dept_id) VALUES
(101, 'Database', 1),
(102, 'AI', 1),
(201, 'Circuits', 2);

INSERT INTO enrollments (student_id, course_id, semester) VALUES
(1, 101, 'Fall 2025'),
(1, 102, 'Fall 2025'),
(2, 101, 'Fall 2025');

-- Optional instructor data for completeness
INSERT INTO instructors (instructor_id, name, email, dept_id) VALUES
(1, 'Dr. Khan', 'khan@university.edu', 1),
(2, 'Dr. Ahmed', 'ahmed@university.edu', 2);

-- =========================================================
-- 4. SELECT / READ OPERATIONS
-- =========================================================

SELECT * FROM departments;
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM instructors;
SELECT * FROM enrollments;

-- =========================================================
-- 5. UPDATE TASK
-- Update Ali's name to Ali Khan
-- =========================================================

UPDATE students
SET name = 'Ali Khan'
WHERE student_id = 1;

SELECT * FROM students WHERE student_id = 1;

-- =========================================================
-- 6. DELETE TASK
-- Delete Sara's enrollment first, then delete Sara.
-- This respects the foreign-key relationship.
-- =========================================================

DELETE FROM enrollments
WHERE student_id = 2;

DELETE FROM students
WHERE student_id = 2;

SELECT * FROM students;

-- =========================================================
-- 7. ALTER TABLE TASKS
-- Add a new column, demonstrate modification/rename/drop.
-- These are shown as executable lab practice statements.
-- The phone column is added and then removed.
-- =========================================================

ALTER TABLE students
ADD phone VARCHAR(20);

UPDATE students
SET phone = '0300-0000000'
WHERE student_id = 1;

SELECT * FROM students;

-- MySQL 8.x:
ALTER TABLE students
MODIFY age INT NOT NULL;

ALTER TABLE students
CHANGE dept_id department_id INT;

-- Restore the original lab-guide column name for consistency
ALTER TABLE students
CHANGE department_id dept_id INT;

ALTER TABLE students
DROP COLUMN phone;

-- =========================================================
-- 8. JOINS: Students + Courses
-- =========================================================

SELECT
    s.student_id,
    s.name AS student_name,
    c.course_id,
    c.course_name,
    e.semester
FROM students AS s
JOIN enrollments AS e
    ON s.student_id = e.student_id
JOIN courses AS c
    ON e.course_id = c.course_id
ORDER BY s.student_id, c.course_id;

-- Students with their departments
SELECT
    s.student_id,
    s.name,
    d.dept_name
FROM students AS s
JOIN departments AS d
    ON s.dept_id = d.dept_id;

-- Courses with their departments
SELECT
    c.course_id,
    c.course_name,
    d.dept_name
FROM courses AS c
JOIN departments AS d
    ON c.dept_id = d.dept_id;

-- =========================================================
-- 9. KEY PRACTICE
-- =========================================================
-- Primary key: students.student_id
-- Foreign keys: students.dept_id, courses.dept_id,
--               instructors.dept_id, enrollments.student_id/course_id
-- Unique keys: departments.dept_name, students.email, instructors.email
-- Composite key: enrollments(student_id, course_id)
-- Candidate key examples: student_id and email (assuming email is unique)
-- Alternate key example: email when student_id is selected as PK
-- Super key examples: student_id; (student_id, name)
-- Natural key example: a real-world identifier such as CNIC
-- Surrogate key example: AUTO_INCREMENT student_id

-- =========================================================
-- 10. TRUNCATE AND DROP PRACTICE
-- =========================================================
-- These are destructive operations. They are included as comments
-- so the main solution does not destroy the completed lab data.
--
-- To practice TRUNCATE safely, use a temporary table:
--
-- CREATE TABLE truncate_demo AS SELECT * FROM students;
-- TRUNCATE TABLE truncate_demo;
-- DROP TABLE truncate_demo;
--
-- The direct lab commands are:
-- TRUNCATE TABLE students;
-- DROP TABLE students;
--
-- Do NOT run those direct commands unless you intentionally want
-- to remove the table/data and understand the foreign-key effects.

-- =========================================================
-- END OF LAB SOLUTION
-- =========================================================
