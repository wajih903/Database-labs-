# Lab 4 - Aggregate Functions

## Files
- `RollNo_Aggregates.sql` — Complete MySQL solution.
- `README.md` — Instructions and task coverage.

## Topic
Aggregate Functions: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, together with
`GROUP BY`, `HAVING`, `JOIN`, `LEFT JOIN`, `ORDER BY`, and `LIMIT`.

## Software
- MySQL 8.x
- MySQL Workbench or MySQL Command Line Client

## How to Run
1. Open MySQL Workbench.
2. Open `RollNo_Aggregates.sql`.
3. Execute the complete script.
4. The script creates and populates:
   - `agg_lab` for the Retail Store lab tasks.
   - `uni_lab` for the Assessment Problem.
5. Run each labelled query and inspect its result grid.

## What Is Included
### Part A
Tasks A1-A10:
- Whole-table counts
- MIN/MAX
- AVG
- SUM
- COUNT(DISTINCT)
- NULL handling
- Date aggregates
- Revenue calculation
- Average quantity

### Part B
Tasks B1-B17:
- GROUP BY
- HAVING
- WHERE + GROUP BY + HAVING
- LEFT JOIN with zero-activity records
- Revenue and quantity summaries
- Top 3 products
- Year/month grouping
- Average order value using a subquery

### Assessment
Questions Q1-Q12:
- University database setup
- Student/course aggregates
- GROUP BY and HAVING
- Course and student summaries
- LEFT JOIN for students/courses with no matching rows
- Fee revenue
- Top 3 students

## Important SQL Concepts Demonstrated
- `COUNT(*)` counts rows, including rows containing NULL values.
- `COUNT(column)` ignores NULL values.
- `COUNT(DISTINCT column)` counts unique non-NULL values.
- `SUM()` and `AVG()` ignore NULL values.
- `WHERE` filters rows before grouping.
- `HAVING` filters groups after aggregation.
- With a `LEFT JOIN`, `COUNT(child_id)` is used to correctly show zero matching rows.
- Every non-aggregated SELECT column must be present in `GROUP BY`.
- Logical execution order:
  `FROM/JOIN -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT`

## Submission
The lab manual specifies a file named `RollNo_Aggregates.sql` and a folder named
`Lab4-Aggregates/`. Replace `RollNo` with your actual roll number before
submitting if required by your instructor.

## Note
The SQL follows the schema and sample data provided in the supplied lab manual.
No external database or additional data is required.
