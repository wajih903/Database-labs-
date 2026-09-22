# Database Normalization Lab — 2NF & 3NF Only

## Scope

This submission intentionally performs **ONLY 2NF and 3NF**.

It does **not** include a 1NF implementation or a 1NF section. The SQL starts with the requested 2NF work and then proceeds to 3NF.

The work is based on the uploaded `LAB_04_(1).pdf`.

## Completed Tasks

### Online Bookstore

The manual's Tasks 3–6 are covered:

- **Task 3 — 2NF**
  - Identifies partial dependencies.
  - Separates Customer, Orders, Book, and OrderItem.
  - Defines primary and foreign keys.
  - Inserts all supplied bookstore data.

- **Task 4 — 3NF**
  - Checks the remaining dependencies.
  - Confirms that the 2NF decomposition has no remaining transitive dependency based on the supplied FDs.
  - Provides the final 3NF schema.

- **Task 5 — Verification**
  - SELECT query recreates the original one-row-per-book-purchased report.
  - SELECT query calculates every customer's total spend.

- **Task 6 — Reflection**
  - SQL comments explain how the design reduces insertion, update, and deletion anomalies.

### Hospital Patient Visits

The assessment's Deliverables 3–6 are covered:

- **Deliverable 3 — 2NF**
  - Candidate key is `VisitID`.
  - Because `VisitID` is a single-attribute key, there are no partial dependencies.
  - The SQL explicitly documents this rather than inventing a partial-dependency decomposition.

- **Deliverable 4 — 3NF**
  - Patient, Doctor, Department, and Visit tables are created.
  - Foreign keys enforce relationships.
  - All supplied hospital data is loaded.

- **Deliverable 5 — Verification**
  - A single SELECT query joins the 3NF tables and recreates the supplied hospital report.

- **Deliverable 6 — Comments**
  - SQL comments explain which anomalies are reduced by the 2NF/3NF design.

## Important: No 1NF

The file does **not** create:
- `OrderBook_1NF`
- `HospitalVisit_1NF`
- any 1NF conversion section

The submission begins directly at 2NF as requested.

## How to Run

1. Open MySQL Workbench or another MySQL 8.x client.
2. Open `Lab-Normalization_2NF_3NF.sql`.
3. Execute the complete script.
4. The database `normalization_2nf_3nf` is created automatically.
5. Review the verification SELECT queries near the end of the file.

## Bookstore 2NF Design

The composite-key dependencies are handled as follows:

- `OrderID -> OrderDate, CustID` → `Orders`
- `CustID -> CustName, CustEmail` → `Customer`
- `BookID -> BookTitle, Publisher, UnitPrice` → `Book`
- `(OrderID, BookID) -> Qty` → `OrderItem`

## Bookstore 3NF

After this decomposition, the supplied functional dependencies do not identify another non-key-to-non-key dependency requiring an additional table. Therefore, the same logical decomposition serves as the final 3NF design.

## Hospital 2NF

The candidate key is `VisitID`, which contains only one attribute. Therefore, there cannot be a partial dependency on part of the key. The SQL documents this explicitly.

## Hospital 3NF

The transitive dependencies are separated:

- `PatientID -> PatientName, PatientPhone`
- `DoctorID -> DoctorName, Specialty, DeptName`
- `DeptName -> DeptHead`

Final tables:
- `Patient`
- `Department`
- `Doctor`
- `Visit`

## Files

This ZIP contains:
- `Lab-Normalization_2NF_3NF.sql`
- `README_2NF_3NF.md`
