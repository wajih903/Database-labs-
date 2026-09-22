# Database Systems Lab #2 — SQL Joins (Part B Only)

## Scope

This submission performs **only Part B (B1–B10)** from the uploaded SQL Joins lab manual. Part B is titled **Self Joins, Multi-table Joins, and Combined Challenges**. fileciteturn6file0L303-L322

## Included Tasks

- **B1:** Self join — employee and manager
- **B2:** Employees earning more than their direct manager
- **B3:** Employees whose manager is in a different department
- **B4:** Employee, project, and weekly hours using a 3-table join
- **B5:** Assignment, employee, project, and project department using a 4-table join
- **B6:** Employees and weekly hours for the Mobile App project
- **B7:** Lahore employees with their projects, including employees without assignments
- **B8:** Employees working on projects run by another department
- **B9:** Each department with projects started in 2024, including departments with no such projects
- **B10:** Total weekly project hours for every employee, including zero-hour employees

## Database Setup

The SQL file creates the `joins_lab` database and the Company schema containing:

- `Department`
- `Employee`
- `Project`
- `Assignment`

These are the tables and relationships specified in the manual. fileciteturn6file0L45-L61

The supplied sample data is also included. fileciteturn6file0L103-L145

## Concepts Used

### Self Join
B1–B3 use the `Employee` table twice with aliases. The manual explains that `ManagerID` points to another employee and shows aliases being used for employee and manager. fileciteturn6file0L249-L265

### Multi-table Joins
B4–B6 chain `Employee`, `Assignment`, and `Project`. B5 additionally joins `Department`. The manual demonstrates chaining three or more tables. fileciteturn6file0L266-L274

### LEFT JOIN with Unmatched Rows
B7 uses LEFT JOIN so Lahore employees without assignments remain in the result, following the manual's guidance on preserving unmatched rows. fileciteturn6file0L199-L208

### LEFT JOIN with a Condition in ON
B9 places the 2024 project-date condition in the `ON` clause so departments with no matching 2024 project are preserved. This follows the manual's warning about putting right-table conditions in `WHERE` when using LEFT JOIN. fileciteturn6file0L229-L233

## How to Run

1. Open MySQL Workbench or another MySQL 8.x client.
2. Open `RollNo_Joins_B_Only.sql`.
3. Run the complete script.
4. Execute or inspect the queries labelled **B1** through **B10**.

## Explicit Exclusions

This package intentionally does **not** include:

- Part A — A1 to A10
- Library Assessment — Q1 to Q10

Only **Part B (B1–B10)** has been performed, as requested.
