# SQL Joins — Part A Only

## Scope
This package contains **only Part A (A1–A10)** from the uploaded SQL Joins lab manual. The manual defines Part A as INNER, LEFT, and RIGHT join tasks A1–A10. fileciteturn5file0L285-L302

## Included
- A1: INNER JOIN — employees with department name and location
- A2: LEFT JOIN — all employees, including NULL DeptID
- A3: RIGHT JOIN — every department with employees
- A4: LEFT JOIN — every project with department details
- A5: LEFT JOIN + IS NULL — employees without projects
- A6: LEFT JOIN + IS NULL — projects without assignments
- A7: INNER JOIN + WHERE — Engineering employees by salary
- A8: INNER JOIN + WHERE — employees in Lahore-based departments
- A9: LEFT JOIN + COUNT + GROUP BY — employee count per department
- A10: FULL OUTER JOIN emulation using LEFT JOIN + RIGHT JOIN + UNION

## Database Setup
The SQL file creates the `joins_lab` database and the four Company tables: Department, Employee, Project, and Assignment, following the manual's schema. fileciteturn5file0L45-L61

It also loads the sample data supplied by the manual. fileciteturn5file0L103-L145

## Join Notes
A LEFT JOIN keeps all rows from the left table, while a RIGHT JOIN keeps all rows from the right table. The manual also uses LEFT JOIN + IS NULL as the anti-join pattern for finding missing relationships. fileciteturn5file0L199-L216

MySQL does not provide FULL OUTER JOIN directly; the manual demonstrates emulating it with LEFT JOIN + RIGHT JOIN + UNION. fileciteturn5file0L237-L248

## How to Run
1. Open MySQL Workbench.
2. Open `RollNo_Joins_A_Only.sql`.
3. Execute the complete script.
4. Run/view each labelled query from A1 through A10.

## Explicit Exclusions
Part B (B1–B10) and the Library Assessment (Q1–Q10) are intentionally **not included**.
