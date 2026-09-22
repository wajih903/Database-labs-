# Lab 3 — Scalar SQL Functions (String Functions Only)

## Scope
This submission performs **only Part A — String Functions (A1–A12)** from the uploaded Lab #3 manual.

The manual identifies Part A as String Functions and lists tasks A1 through A12. The Numeric & Date/Time section (Part B) is intentionally excluded, as is the Assessment Problem.

## Included
- `RollNo_ScalarFunctions_String_Only.sql`
- Database/schema setup for `scalar_lab`
- Customer and Product sample data from the manual
- Task A1 through A12 only

## Excluded
- Part B — Numeric and Date/Time Functions (B1–B15)
- Section 9 — Assessment Problem (Q1–Q10)

## String Tasks Covered
- A1: TRIM customer names
- A2: UPPERCASE and lowercase names
- A3: Trimmed name and character count
- A4: Customer greeting
- A5: Email username extraction
- A6: Email domain extraction
- A7: First 3 characters of customer name
- A8: Phone masking
- A9: Product-name slug using REPLACE
- A10: Product ID padding using LPAD
- A11: Find `Pro` and its position
- A12: Extract first name

## How to Run
1. Open MySQL 8.x / MySQL Workbench.
2. Open `RollNo_ScalarFunctions_String_Only.sql`.
3. Execute the complete script.
4. The script creates and uses the `scalar_lab` database, recreates the two required tables, inserts the manual's sample data, and runs A1–A12.

## Notes
The SQL follows the terminology and schema from the uploaded Lab #3 manual. String functions used include TRIM, UPPER, LOWER, CHAR_LENGTH, CONCAT, SUBSTRING, LOCATE, LEFT, REPLACE, and LPAD.
