# Database Normalization Lab — 1NF Only

## Scope

This submission is intentionally limited to **First Normal Form (1NF)**.

It is based on the supplied `LAB_04_.pdf`. The manual defines 1NF as:
- every cell contains a single atomic value;
- no repeating groups;
- every row is uniquely identifiable.

**2NF and 3NF are deliberately not performed.**

## Included File

- `Lab-Normalization_1NF.sql` — MySQL 8.x script containing the 1NF work.

## What Has Been Completed

### Part A — Online Bookstore

From the manual's Lab Tasks:

**Task 1 — Functional Dependencies and Anomalies**
- Functional dependencies are documented as SQL comments.
- The candidate key is identified as `(OrderID, BookID)`.
- Insertion, update, and deletion anomalies are documented.

**Task 2 — Convert to 1NF**
- The original multi-valued book/order cells are expanded into individual rows.
- The table is named `OrderBook_1NF`.
- Primary key: `(OrderID, BookID)`.
- All rows from the bookstore data in the manual are inserted.
- A SELECT query verifies the result.

### Part B — Hospital Patient Visits Assessment

Only the first two assessment deliverables are included:

**Deliverable 1**
- Functional dependencies are written as SQL comments.
- Candidate key: `VisitID`.

**Deliverable 2**
- A single atomic 1NF table named `HospitalVisit_1NF` is created.
- All four hospital visit records from the manual are inserted.
- `VisitID` is the primary key.
- A SELECT query verifies the 1NF table.

## Important: No 2NF / 3NF

The SQL file does **not** contain:
- 2NF decomposition,
- 3NF decomposition,
- separate Customer/Book tables,
- separate Patient/Doctor/Department tables,
- 2NF/3NF foreign-key redesign,
- 3NF verification joins.

This is intentional because the requested submission is **1NF only**.

## How to Run

1. Open MySQL Workbench or another MySQL 8.x client.
2. Open `Lab-Normalization_1NF.sql`.
3. Run the entire script.
4. The script creates the database `normalization_1nf`.
5. Review the final SELECT results for `OrderBook_1NF` and `HospitalVisit_1NF`.

## Expected Bookstore 1NF Rows

The bookstore source data produces five atomic order-book rows:

| OrderID | BookID | BookTitle | Qty |
|---|---|---|---:|
| O-501 | B-1 | SQL Basics | 1 |
| O-501 | B-2 | Python 101 | 2 |
| O-502 | B-1 | SQL Basics | 3 |
| O-503 | B-3 | Networks | 1 |
| O-503 | B-2 | Python 101 | 1 |

## Expected Hospital 1NF Rows

The hospital source data produces four atomic visit rows:

| VisitID | PatientID | DoctorID | Diagnosis | Fee |
|---|---|---|---|---:|
| V-9001 | P-201 | D-30 | Hypertension | 2500 |
| V-9002 | P-202 | D-31 | Eczema | 2000 |
| V-9003 | P-201 | D-31 | Allergy | 2000 |
| V-9004 | P-203 | D-30 | Arrhythmia | 3000 |

## Source Basis

The uploaded lab manual contains the bookstore Lab Tasks on pages 9–10 and the Hospital Patient Visits assessment on pages 11–12. The 1NF rule and example are given on page 6.

