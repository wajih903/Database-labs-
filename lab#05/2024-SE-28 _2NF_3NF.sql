-- ============================================================
-- DATABASE SYSTEMS - NORMALIZATION LAB
-- SCOPE: 2NF AND 3NF ONLY
-- ============================================================
-- IMPORTANT:
-- This submission intentionally DOES NOT implement or reproduce
-- the 1NF stage. It starts directly with the requested 2NF and
-- 3NF designs using the data supplied in LAB_04_(1).pdf.
--
-- Source manual sections used:
-- * Bookstore Task 3: 2NF
-- * Bookstore Task 4: 3NF
-- * Bookstore Task 5: verification
-- * Bookstore Task 6: reflection
-- * Hospital Deliverables 3-6: 2NF, 3NF, verification, anomalies
-- ============================================================

CREATE DATABASE IF NOT EXISTS normalization_2nf_3nf;
USE normalization_2nf_3nf;

-- ============================================================
-- PART A - ONLINE BOOKSTORE
-- ============================================================

-- ============================================================
-- BOOKSTORE: 2NF
-- ============================================================
-- Relevant dependencies from the manual's bookstore data:
-- OrderID -> OrderDate, CustID
-- CustID -> CustName, CustEmail
-- BookID -> BookTitle, Publisher, UnitPrice
-- (OrderID, BookID) -> Qty
--
-- The order-book relation has a composite key:
-- (OrderID, BookID)
--
-- Partial dependencies:
-- 1. OrderID -> OrderDate, CustID
-- 2. BookID -> BookTitle, Publisher, UnitPrice
--
-- Therefore, the partial dependencies are removed by separating:
-- Customer, Orders, Book, and OrderItem.
--
-- This is the 2NF design requested by Task 3.

DROP TABLE IF EXISTS OrderItem_2NF;
DROP TABLE IF EXISTS Orders_2NF;
DROP TABLE IF EXISTS Book_2NF;
DROP TABLE IF EXISTS Customer_2NF;

CREATE TABLE Customer_2NF (
    CustID VARCHAR(10) PRIMARY KEY,
    CustName VARCHAR(100) NOT NULL,
    CustEmail VARCHAR(150) NOT NULL
);

CREATE TABLE Book_2NF (
    BookID VARCHAR(10) PRIMARY KEY,
    BookTitle VARCHAR(100) NOT NULL,
    Publisher VARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

CREATE TABLE Orders_2NF (
    OrderID VARCHAR(10) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustID VARCHAR(10) NOT NULL,
    CONSTRAINT fk_orders_customer_2nf
        FOREIGN KEY (CustID) REFERENCES Customer_2NF(CustID)
);

CREATE TABLE OrderItem_2NF (
    OrderID VARCHAR(10) NOT NULL,
    BookID VARCHAR(10) NOT NULL,
    Qty INT NOT NULL,
    PRIMARY KEY (OrderID, BookID),
    CONSTRAINT fk_orderitem_order_2nf
        FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID),
    CONSTRAINT fk_orderitem_book_2nf
        FOREIGN KEY (BookID) REFERENCES Book_2NF(BookID)
);

INSERT INTO Customer_2NF (CustID, CustName, CustEmail) VALUES
('C-11', 'Bilal', 'bilal@x.com'),
('C-12', 'Areeba', 'areeba@x.com');

INSERT INTO Book_2NF (BookID, BookTitle, Publisher, UnitPrice) VALUES
('B-1', 'SQL Basics', 'Pearson', 1200),
('B-2', 'Python 101', 'OReilly', 1500),
('B-3', 'Networks', 'Pearson', 1800);

INSERT INTO Orders_2NF (OrderID, OrderDate, CustID) VALUES
('O-501', '2026-04-02', 'C-11'),
('O-502', '2026-04-03', 'C-12'),
('O-503', '2026-04-05', 'C-11');

INSERT INTO OrderItem_2NF (OrderID, BookID, Qty) VALUES
('O-501', 'B-1', 1),
('O-501', 'B-2', 2),
('O-502', 'B-1', 3),
('O-503', 'B-3', 1),
('O-503', 'B-2', 1);

-- ============================================================
-- BOOKSTORE: 3NF
-- ============================================================
-- The 2NF design has already separated attributes according to
-- their determinants:
--
-- CustID -> CustName, CustEmail
-- OrderID -> OrderDate, CustID
-- BookID -> BookTitle, Publisher, UnitPrice
-- (OrderID, BookID) -> Qty
--
-- No non-key attribute in these relations depends on another
-- non-key attribute based on the supplied functional dependencies.
--
-- Therefore, no additional decomposition is required for this
-- dataset to reach 3NF.
--
-- The 3NF implementation below uses the same logical decomposition
-- with final table names and foreign keys.

DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer (
    CustID VARCHAR(10) PRIMARY KEY,
    CustName VARCHAR(100) NOT NULL,
    CustEmail VARCHAR(150) NOT NULL
);

CREATE TABLE Book (
    BookID VARCHAR(10) PRIMARY KEY,
    BookTitle VARCHAR(100) NOT NULL,
    Publisher VARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

CREATE TABLE Orders (
    OrderID VARCHAR(10) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustID VARCHAR(10) NOT NULL,
    FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

CREATE TABLE OrderItem (
    OrderID VARCHAR(10) NOT NULL,
    BookID VARCHAR(10) NOT NULL,
    Qty INT NOT NULL,
    PRIMARY KEY (OrderID, BookID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

INSERT INTO Customer VALUES
('C-11', 'Bilal', 'bilal@x.com'),
('C-12', 'Areeba', 'areeba@x.com');

INSERT INTO Book VALUES
('B-1', 'SQL Basics', 'Pearson', 1200),
('B-2', 'Python 101', 'OReilly', 1500),
('B-3', 'Networks', 'Pearson', 1800);

INSERT INTO Orders VALUES
('O-501', '2026-04-02', 'C-11'),
('O-502', '2026-04-03', 'C-12'),
('O-503', '2026-04-05', 'C-11');

INSERT INTO OrderItem VALUES
('O-501', 'B-1', 1),
('O-501', 'B-2', 2),
('O-502', 'B-1', 3),
('O-503', 'B-3', 1),
('O-503', 'B-2', 1);

-- Bookstore 3NF verification: one row per purchased book.
SELECT
    o.OrderID,
    o.OrderDate,
    c.CustID,
    c.CustName,
    c.CustEmail,
    b.BookID,
    b.BookTitle,
    b.Publisher,
    b.UnitPrice,
    oi.Qty
FROM Orders o
JOIN Customer c ON o.CustID = c.CustID
JOIN OrderItem oi ON o.OrderID = oi.OrderID
JOIN Book b ON oi.BookID = b.BookID
ORDER BY o.OrderID, b.BookID;

-- Customer total spend.
SELECT
    c.CustID,
    c.CustName,
    SUM(b.UnitPrice * oi.Qty) AS TotalSpend
FROM Customer c
JOIN Orders o ON c.CustID = o.CustID
JOIN OrderItem oi ON o.OrderID = oi.OrderID
JOIN Book b ON oi.BookID = b.BookID
GROUP BY c.CustID, c.CustName
ORDER BY c.CustID;

-- ============================================================
-- PART B - HOSPITAL PATIENT VISITS ASSESSMENT
-- ============================================================

-- ============================================================
-- HOSPITAL: 2NF
-- ============================================================
-- Candidate key from the supplied hospital data:
-- VisitID
--
-- Functional dependencies supplied by the data:
-- VisitID -> VisitDate, PatientID, DoctorID, Diagnosis, Fee
-- PatientID -> PatientName, PatientPhone
-- DoctorID -> DoctorName, Specialty, DeptName
-- DeptName -> DeptHead
--
-- IMPORTANT 2NF OBSERVATION:
-- The candidate key is a SINGLE attribute (VisitID).
-- Therefore, there can be no partial dependency on part of the
-- primary key. A partial dependency requires a composite key.
--
-- So the hospital relation is already in 2NF with respect to
-- partial-dependency removal. The decomposition needed to remove
-- transitive dependencies belongs to 3NF, not 2NF.
--
-- To show the 2NF stage without performing 1NF, we implement the
-- complete atomic hospital relation as the 2NF relation below.

DROP TABLE IF EXISTS HospitalVisit_2NF;

CREATE TABLE HospitalVisit_2NF (
    VisitID VARCHAR(10) PRIMARY KEY,
    VisitDate DATE NOT NULL,
    PatientID VARCHAR(10) NOT NULL,
    PatientName VARCHAR(100) NOT NULL,
    PatientPhone VARCHAR(20) NOT NULL,
    DoctorID VARCHAR(10) NOT NULL,
    DoctorName VARCHAR(100) NOT NULL,
    Specialty VARCHAR(100) NOT NULL,
    DeptName VARCHAR(100) NOT NULL,
    DeptHead VARCHAR(100) NOT NULL,
    Diagnosis VARCHAR(150) NOT NULL,
    Fee DECIMAL(10,2) NOT NULL
);

INSERT INTO HospitalVisit_2NF VALUES
('V-9001','2026-04-10','P-201','Hassan','0300-1112233',
 'D-30','Dr. Imran','Cardiology','Heart Care','Dr. Tariq',
 'Hypertension',2500),

('V-9002','2026-04-10','P-202','Mehreen','0301-4445566',
 'D-31','Dr. Asma','Dermatology','Skin Clinic','Dr. Asma',
 'Eczema',2000),

('V-9003','2026-04-11','P-201','Hassan','0300-1112233',
 'D-31','Dr. Asma','Dermatology','Skin Clinic','Dr. Asma',
 'Allergy',2000),

('V-9004','2026-04-12','P-203','Junaid','0302-7778899',
 'D-30','Dr. Imran','Cardiology','Heart Care','Dr. Tariq',
 'Arrhythmia',3000);

-- ============================================================
-- HOSPITAL: 3NF
-- ============================================================
-- Transitive dependencies identified:
--
-- VisitID -> PatientID -> PatientName, PatientPhone
-- VisitID -> DoctorID -> DoctorName, Specialty, DeptName
-- VisitID -> DoctorID -> DeptName -> DeptHead
--
-- These are removed by creating separate Patient, Doctor,
-- Department, and Visit relations.
--
-- 3NF tables:
-- Patient(PatientID, PatientName, PatientPhone)
-- Department(DeptName, DeptHead)
-- Doctor(DoctorID, DoctorName, Specialty, DeptName)
-- Visit(VisitID, VisitDate, PatientID, DoctorID, Diagnosis, Fee)

DROP TABLE IF EXISTS Visit;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Patient;

CREATE TABLE Patient (
    PatientID VARCHAR(10) PRIMARY KEY,
    PatientName VARCHAR(100) NOT NULL,
    PatientPhone VARCHAR(20) NOT NULL
);

CREATE TABLE Department (
    DeptName VARCHAR(100) PRIMARY KEY,
    DeptHead VARCHAR(100) NOT NULL
);

CREATE TABLE Doctor (
    DoctorID VARCHAR(10) PRIMARY KEY,
    DoctorName VARCHAR(100) NOT NULL,
    Specialty VARCHAR(100) NOT NULL,
    DeptName VARCHAR(100) NOT NULL,
    FOREIGN KEY (DeptName) REFERENCES Department(DeptName)
);

CREATE TABLE Visit (
    VisitID VARCHAR(10) PRIMARY KEY,
    VisitDate DATE NOT NULL,
    PatientID VARCHAR(10) NOT NULL,
    DoctorID VARCHAR(10) NOT NULL,
    Diagnosis VARCHAR(150) NOT NULL,
    Fee DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

INSERT INTO Patient VALUES
('P-201','Hassan','0300-1112233'),
('P-202','Mehreen','0301-4445566'),
('P-203','Junaid','0302-7778899');

INSERT INTO Department VALUES
('Heart Care','Dr. Tariq'),
('Skin Clinic','Dr. Asma');

INSERT INTO Doctor VALUES
('D-30','Dr. Imran','Cardiology','Heart Care'),
('D-31','Dr. Asma','Dermatology','Skin Clinic');

INSERT INTO Visit VALUES
('V-9001','2026-04-10','P-201','D-30','Hypertension',2500),
('V-9002','2026-04-10','P-202','D-31','Eczema',2000),
('V-9003','2026-04-11','P-201','D-31','Allergy',2000),
('V-9004','2026-04-12','P-203','D-30','Arrhythmia',3000);

-- ============================================================
-- HOSPITAL: 3NF VERIFICATION QUERY
-- ============================================================
-- Recreates the supplied Table 8.1 by joining the 3NF tables.

SELECT
    v.VisitID,
    v.VisitDate,
    p.PatientID,
    p.PatientName,
    p.PatientPhone,
    d.DoctorID,
    d.DoctorName,
    d.Specialty,
    dep.DeptName,
    dep.DeptHead,
    v.Diagnosis,
    v.Fee
FROM Visit v
JOIN Patient p
    ON v.PatientID = p.PatientID
JOIN Doctor d
    ON v.DoctorID = d.DoctorID
JOIN Department dep
    ON d.DeptName = dep.DeptName
ORDER BY v.VisitID;

-- ============================================================
-- REFLECTION / ANOMALIES
-- ============================================================
-- BOOKSTORE:
-- 2NF removes the partial dependencies from the composite
-- (OrderID, BookID) key by separating order, customer, book,
-- and order-item facts. The resulting 3NF design stores each
-- customer, order, book, and order line fact in its appropriate
-- relation, reducing repeated data. Customer information can be
-- updated once in Customer, and book information can be updated
-- once in Book. A book/customer can therefore exist independently
-- of a particular order row.
--
-- HOSPITAL:
-- Because VisitID is a single-attribute key, there are no partial
-- dependencies to remove in 2NF. The 3NF decomposition removes
-- transitive dependencies by storing patient details in Patient,
-- doctor details in Doctor, and department details in Department.
-- Visit stores only the visit-specific facts and references the
-- related entities with foreign keys. This prevents repeated
-- patient, doctor, and department information from being stored
-- on every visit and reduces update, insertion, and deletion
-- anomalies.

-- ============================================================
-- END: 2NF + 3NF ONLY
-- ============================================================
