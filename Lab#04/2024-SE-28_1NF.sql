-- ============================================================
-- Database Systems Lab - Normalization
-- SCOPE: 1NF ONLY
-- Based strictly on LAB_04_.pdf
--
-- IMPORTANT:
-- This submission intentionally stops at First Normal Form (1NF).
-- No 2NF or 3NF decomposition is performed.
-- ============================================================

CREATE DATABASE IF NOT EXISTS normalization_1nf;
USE normalization_1nf;

-- ============================================================
-- PART A: ONLINE BOOKSTORE
-- Lab Tasks 1 and 2 ONLY
-- ============================================================

-- ------------------------------------------------------------
-- TASK 1: FUNCTIONAL DEPENDENCIES AND ANOMALIES
-- ------------------------------------------------------------
-- Functional dependencies identified from the supplied data:
--
-- OrderID -> OrderDate, CustID
-- CustID -> CustName, CustEmail
-- (OrderID, BookID) -> Qty
-- BookID -> BookTitle, Publisher, UnitPrice
--
-- Candidate key for the 1NF order-book relation:
-- (OrderID, BookID)
--
-- Insertion anomaly:
-- A new book/publisher cannot be recorded in the flat order
-- structure unless an order row is also available.
--
-- Update anomaly:
-- If a customer's name/email or a book's publisher/price changes,
-- the same fact may need to be updated in multiple order rows.
--
-- Deletion anomaly:
-- Deleting the last order containing a particular book can also
-- remove the only stored occurrence of that book's information.

-- ------------------------------------------------------------
-- TASK 2: CONVERT THE BOOKSTORE DATA TO 1NF
-- ------------------------------------------------------------
-- Rule followed from the manual:
-- * every cell contains one atomic value
-- * no repeating groups
-- * every row is uniquely identifiable
--
-- The original multi-valued cells are expanded into separate rows.
-- Primary key: (OrderID, BookID)

DROP TABLE IF EXISTS OrderBook_1NF;

CREATE TABLE OrderBook_1NF (
    OrderID     VARCHAR(10) NOT NULL,
    OrderDate   DATE NOT NULL,
    CustID      VARCHAR(10) NOT NULL,
    CustName    VARCHAR(100) NOT NULL,
    CustEmail   VARCHAR(150) NOT NULL,
    BookID      VARCHAR(10) NOT NULL,
    BookTitle   VARCHAR(100) NOT NULL,
    Publisher   VARCHAR(100) NOT NULL,
    UnitPrice   DECIMAL(10,2) NOT NULL,
    Qty         INT NOT NULL,
    PRIMARY KEY (OrderID, BookID)
);

-- Atomic 1NF rows derived from Table 7.1 in the manual.
INSERT INTO OrderBook_1NF
    (OrderID, OrderDate, CustID, CustName, CustEmail,
     BookID, BookTitle, Publisher, UnitPrice, Qty)
VALUES
    ('O-501', '2026-04-02', 'C-11', 'Bilal',  'bilal@x.com',
     'B-1', 'SQL Basics', 'Pearson', 1200, 1),

    ('O-501', '2026-04-02', 'C-11', 'Bilal',  'bilal@x.com',
     'B-2', 'Python 101', 'OReilly', 1500, 2),

    ('O-502', '2026-04-03', 'C-12', 'Areeba', 'areeba@x.com',
     'B-1', 'SQL Basics', 'Pearson', 1200, 3),

    ('O-503', '2026-04-05', 'C-11', 'Bilal',  'bilal@x.com',
     'B-3', 'Networks', 'Pearson', 1800, 1),

    ('O-503', '2026-04-05', 'C-11', 'Bilal',  'bilal@x.com',
     'B-2', 'Python 101', 'OReilly', 1500, 1);

-- Verify the complete 1NF relation.
SELECT *
FROM OrderBook_1NF
ORDER BY OrderID, BookID;

-- Optional verification: each cell above contains a single value.
-- No comma-separated multi-valued Book/Publisher/Price/Qty cells remain.

-- ============================================================
-- PART B: ASSESSMENT PROBLEM - HOSPITAL PATIENT VISITS
-- DELIVERABLES 1 and 2 ONLY (1NF ONLY)
-- ============================================================

-- ------------------------------------------------------------
-- DELIVERABLE 1: FUNCTIONAL DEPENDENCIES + CANDIDATE KEY
-- ------------------------------------------------------------
-- Based on the supplied Hospital Patient Visits data:
--
-- VisitID -> VisitDate, PatientID, DoctorID, Diagnosis, Fee
-- PatientID -> PatientName, PatientPhone
-- DoctorID -> DoctorName, Specialty, DeptName
-- DeptName -> DeptHead
--
-- Candidate key for the unnormalized/1NF visit relation:
-- VisitID
--
-- The following dependencies are written as comments because
-- Deliverable 1 specifically requests them as SQL comments.

-- ------------------------------------------------------------
-- DELIVERABLE 2: 1NF VERSION OF THE HOSPITAL TABLE
-- ------------------------------------------------------------
-- The manual presents the hospital information across three views.
-- For 1NF, all values are kept atomic and represented in one row
-- per VisitID. No 2NF/3NF decomposition is performed.

DROP TABLE IF EXISTS HospitalVisit_1NF;

CREATE TABLE HospitalVisit_1NF (
    VisitID       VARCHAR(10) NOT NULL,
    VisitDate     DATE NOT NULL,
    PatientID     VARCHAR(10) NOT NULL,
    PatientName   VARCHAR(100) NOT NULL,
    PatientPhone  VARCHAR(20) NOT NULL,
    DoctorID      VARCHAR(10) NOT NULL,
    DoctorName    VARCHAR(100) NOT NULL,
    Specialty     VARCHAR(100) NOT NULL,
    DeptName      VARCHAR(100) NOT NULL,
    DeptHead      VARCHAR(100) NOT NULL,
    Diagnosis     VARCHAR(150) NOT NULL,
    Fee           DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (VisitID)
);

INSERT INTO HospitalVisit_1NF
    (VisitID, VisitDate, PatientID, PatientName, PatientPhone,
     DoctorID, DoctorName, Specialty, DeptName, DeptHead,
     Diagnosis, Fee)
VALUES
    ('V-9001', '2026-04-10', 'P-201', 'Hassan',  '0300-1112233',
     'D-30', 'Dr. Imran', 'Cardiology', 'Heart Care', 'Dr. Tariq',
     'Hypertension', 2500),

    ('V-9002', '2026-04-10', 'P-202', 'Mehreen', '0301-4445566',
     'D-31', 'Dr. Asma', 'Dermatology', 'Skin Clinic', 'Dr. Asma',
     'Eczema', 2000),

    ('V-9003', '2026-04-11', 'P-201', 'Hassan',  '0300-1112233',
     'D-31', 'Dr. Asma', 'Dermatology', 'Skin Clinic', 'Dr. Asma',
     'Allergy', 2000),

    ('V-9004', '2026-04-12', 'P-203', 'Junaid',  '0302-7778899',
     'D-30', 'Dr. Imran', 'Cardiology', 'Heart Care', 'Dr. Tariq',
     'Arrhythmia', 3000);

-- Verify the 1NF hospital relation.
SELECT *
FROM HospitalVisit_1NF
ORDER BY VisitID;

-- ============================================================
-- END OF 1NF SUBMISSION
-- ============================================================
-- 2NF and 3NF are intentionally NOT implemented.
-- The source manual requires later decomposition, but this file
-- stops at 1NF exactly as requested.
