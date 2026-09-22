# Scalar SQL Functions — Numeric + Date/Time Only

## Lab
Database Systems — Lab #3: Scalar SQL Functions  
MySQL 8.x / MySQL Workbench

## Scope
This submission contains **only the Numeric Functions and Date/Time Functions** from Part B of the supplied Lab #3 manual.

### Included
- **B1–B5:** Numeric functions
- **B6–B15:** Date/Time functions

### Numeric topics used
- `ROUND()`
- `FLOOR()`
- `CEIL()`
- `MOD()`
- Arithmetic expressions

### Date/Time topics used
- `YEAR()`
- `MONTHNAME()`
- `DAYNAME()`
- `DATE_FORMAT()`
- `TIMESTAMPDIFF()`
- `CURDATE()`
- `DATEDIFF()`
- `DATE_SUB()`
- `MONTH()`
- `DATE_ADD()`
- `CONCAT()`, `UPPER()`, and `TRIM()` only where required by the B15 combined challenge

## Explicitly Excluded
- Part A String Functions **A1–A12**
- Assessment Problem **Q1–Q10**

## Database Setup
The SQL file creates:
- Database: `scalar_lab`
- Table: `Customer`
- Table: `Product`

It also inserts the sample data supplied in the manual.

## How to Run
1. Open MySQL Workbench or another MySQL 8.x client.
2. Open `RollNo_ScalarFunctions_Numeric_DateTime_Only.sql`.
3. Run the complete script.
4. The script creates the database/tables and sample data.
5. Each task is labelled with a comment such as `-- Task B1`.

## Task Coverage

| Task | Description |
|---|---|
| B1 | 15% product discount |
| B2 | 17% sales tax and final price |
| B3 | FLOOR and CEIL of price / 1000 |
| B4 | Round price to nearest hundred |
| B5 | Products with odd ProdID |
| B6 | Join year, month name, and day of week |
| B7 | DOB formatted as DD-Month-YYYY |
| B8 | Current age in years |
| B9 | Days since customer joined |
| B10 | Customers who joined in 2023 |
| B11 | Products launched in Q4 |
| B12 | Customers who joined within last 6 months |
| B13 | Product age in days |
| B14 | Date 90 days after launch |
| B15 | Combined customer summary |

## Source Alignment
The task list follows Part B of the supplied Scalar SQL Functions manual, where B1–B5 are numeric tasks and B6–B15 are date/time/combined tasks.

The manual identifies the topic as String, Numeric, and Date/Time scalar functions and specifies MySQL 8.x as the tool environment.

## Important Note
Tasks involving `CURDATE()` and `NOW()` are dynamic. Their results change depending on the date/time when the SQL is executed.

## Submission Files
- `RollNo_ScalarFunctions_Numeric_DateTime_Only.sql`
- `README_ScalarFunctions_Numeric_DateTime_Only.md`
