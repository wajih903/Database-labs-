# University MySQL Lab Solution

## Files
- `University_MySQL_Lab_Solution.sql` — complete MySQL script for the lab.
- `University_MySQL_Lab_Solution.pdf` — formatted lab report containing the completed tasks, explanations, and SQL.
- `README.md` — setup and execution instructions.

## Source
This work is based on the uploaded **LAB_03_Manual.pdf**, covering:
1. Database keys
2. CREATE/ALTER TABLE commands
3. CRUD operations
4. TRUNCATE and DROP
5. University example using Students, Departments, Courses, Instructors, and Enrollments
6. Joins and key practice

## Requirements
- MySQL 8.x or compatible MySQL server
- MySQL Workbench, command-line client, or another MySQL client

## How to Run
1. Open MySQL Workbench (or another MySQL client).
2. Open `University_MySQL_Lab_Solution.sql`.
3. Execute the script from top to bottom.
4. The script creates the `university_lab` database automatically.
5. Review the SELECT statements and the final JOIN result.

## Important Notes
- The script begins by dropping the five lab tables if they already exist, so the lab starts clean.
- The sample data follows the values in the manual.
- The DELETE operation removes Sara's enrollment before deleting Sara because of the foreign-key constraint.
- The ALTER TABLE section demonstrates adding, modifying, renaming, and dropping a column.
- The TRUNCATE/DROP examples are commented out in the main execution flow because they are destructive. A temporary-table demonstration is provided instead.
- The enrollment table uses the composite primary key `(student_id, course_id)` exactly as specified by the lab structure.

## Expected Main Data
Departments:
- 1 — CS
- 2 — EE

Students initially inserted:
- Ali — ali@gmail.com — age 20 — CS
- Sara — sara@gmail.com — age 21 — CS
- Ahmed — ahmed@gmail.com — age 22 — EE

Courses:
- 101 — Database — CS
- 102 — AI — CS
- 201 — Circuits — EE

Enrollments:
- Ali → Database — Fall 2025
- Ali → AI — Fall 2025
- Sara → Database — Fall 2025

The script then updates Ali to **Ali Khan** and performs the required DELETE task for Sara.

## Key Concepts Covered
- Primary key
- Foreign key
- Unique key
- Composite key
- Candidate key
- Alternate key
- Super key
- Natural key
- Surrogate key
- CREATE TABLE
- ALTER TABLE
- INSERT
- SELECT
- UPDATE
- DELETE
- TRUNCATE
- DROP
- JOIN

## Submission
The ZIP archive contains the SQL solution, PDF report, and this README.
