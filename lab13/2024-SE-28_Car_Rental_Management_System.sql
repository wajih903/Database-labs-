DROP DATABASE IF EXISTS cargo_rentals;
CREATE DATABASE cargo_rentals;
USE cargo_rentals;

-- TASK 1: DATABASE DESIGN
CREATE TABLE Customer (
 CustomerID INT PRIMARY KEY AUTO_INCREMENT,
 CustomerName VARCHAR(100) NOT NULL,
 Phone VARCHAR(20) NOT NULL UNIQUE,
 Email VARCHAR(100) UNIQUE,
 Address VARCHAR(200),
 CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Vehicle (
 VehicleID INT PRIMARY KEY AUTO_INCREMENT,
 VehicleNumber VARCHAR(20) NOT NULL UNIQUE,
 VehicleModel VARCHAR(80) NOT NULL,
 VehicleType VARCHAR(40) NOT NULL,
 DailyRate DECIMAL(10,2) NOT NULL,
 Status ENUM('Available','Rented','Maintenance') NOT NULL DEFAULT 'Available',
 CHECK (DailyRate > 0)
);

CREATE TABLE Rental (
 RentalID INT PRIMARY KEY AUTO_INCREMENT,
 CustomerID INT NOT NULL,
 VehicleID INT NOT NULL,
 RentalDate DATE NOT NULL,
 ExpectedReturnDate DATE NOT NULL,
 ActualReturnDate DATE NULL,
 RentalStatus ENUM('Booked','Active','Completed','Cancelled') NOT NULL DEFAULT 'Active',
 FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
 FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID),
 CHECK (ExpectedReturnDate >= RentalDate),
 CHECK (ActualReturnDate IS NULL OR ActualReturnDate >= RentalDate)
);

CREATE TABLE Payment (
 PaymentID INT PRIMARY KEY AUTO_INCREMENT,
 RentalID INT NOT NULL,
 PaymentDate DATE NOT NULL DEFAULT (CURRENT_DATE),
 Amount DECIMAL(10,2) NOT NULL,
 PaymentMethod ENUM('Cash','Card','Bank Transfer','Online') NOT NULL,
 PaymentStatus ENUM('Paid','Pending','Refunded') NOT NULL DEFAULT 'Paid',
 FOREIGN KEY (RentalID) REFERENCES Rental(RentalID),
 CHECK (Amount >= 0)
);

CREATE INDEX idx_rental_customer ON Rental(CustomerID);
CREATE INDEX idx_rental_vehicle ON Rental(VehicleID);
CREATE INDEX idx_rental_status ON Rental(RentalStatus);
CREATE INDEX idx_payment_rental ON Payment(RentalID);

INSERT INTO Customer (CustomerName,Phone,Email,Address) VALUES
('Ali Khan','0300-1234567','ali@example.com','Lahore'),
('Sara Ahmed','0301-2223344','sara@example.com','Karachi'),
('Bilal Raza','0302-3334455','bilal@example.com','Islamabad'),
('Ayesha Noor','0303-4445566','ayesha@example.com','Lahore'),
('Hamza Tariq','0304-5556677','hamza@example.com','Rawalpindi'),
('Maira Javed','0305-6667788','maira@example.com','Multan');

INSERT INTO Vehicle (VehicleNumber,VehicleModel,VehicleType,DailyRate,Status) VALUES
('ABC-123','Toyota Corolla','Sedan',5000,'Rented'),
('LEA-456','Honda Civic','Sedan',6500,'Available'),
('ISB-789','Suzuki Swift','Hatchback',4000,'Available'),
('KHI-321','Toyota Yaris','Sedan',5500,'Rented'),
('RWP-654','Kia Sportage','SUV',9000,'Maintenance'),
('MUX-987','Honda City','Sedan',5200,'Available');

INSERT INTO Rental (CustomerID,VehicleID,RentalDate,ExpectedReturnDate,ActualReturnDate,RentalStatus) VALUES
(1,1,'2026-09-01','2026-09-04',NULL,'Active'),
(2,2,'2026-08-20','2026-08-23','2026-08-23','Completed'),
(1,3,'2026-07-10','2026-07-12','2026-07-12','Completed'),
(3,4,'2026-09-15','2026-09-20',NULL,'Active'),
(4,2,'2026-06-05','2026-06-08','2026-06-08','Completed');

INSERT INTO Payment (RentalID,PaymentDate,Amount,PaymentMethod,PaymentStatus) VALUES
(1,'2026-09-01',15000,'Cash','Paid'),
(2,'2026-08-20',19500,'Card','Paid'),
(3,'2026-07-10',8000,'Online','Paid'),
(4,'2026-09-15',27500,'Bank Transfer','Paid'),
(5,'2026-06-05',15000,'Card','Paid');

-- TASK 2: NORMALIZATION
-- 1NF: atomic values and one rental per row.
-- 2NF: separate customer/vehicle facts from rental facts to remove partial dependencies.
-- 3NF: separate payment and entity attributes to remove transitive dependencies.
-- Final relations: Customer, Vehicle, Rental, Payment.

-- TASK 3: JOIN QUERIES
-- 1
SELECT c.CustomerName,v.VehicleNumber,v.VehicleModel,r.RentalDate,
       r.ExpectedReturnDate AS ReturnDate
FROM Rental r
JOIN Customer c ON r.CustomerID=c.CustomerID
JOIN Vehicle v ON r.VehicleID=v.VehicleID;

-- 2
SELECT c.CustomerName,v.VehicleNumber,v.VehicleModel,r.RentalDate,r.RentalStatus
FROM Customer c
LEFT JOIN Rental r ON c.CustomerID=r.CustomerID
LEFT JOIN Vehicle v ON r.VehicleID=v.VehicleID;

-- 3
SELECT v.VehicleNumber,v.VehicleModel,v.Status,r.RentalID,r.RentalDate,
       r.ExpectedReturnDate,c.CustomerName
FROM Vehicle v
LEFT JOIN Rental r
 ON v.VehicleID=r.VehicleID AND r.RentalStatus IN ('Booked','Active')
LEFT JOIN Customer c ON r.CustomerID=c.CustomerID;

-- 4
SELECT c.CustomerID,c.CustomerName,COUNT(r.RentalID) AS TotalRentals
FROM Customer c
LEFT JOIN Rental r ON c.CustomerID=r.CustomerID
GROUP BY c.CustomerID,c.CustomerName;

-- TASK 4: VIEW
CREATE OR REPLACE VIEW vw_RentalReport AS
SELECT r.RentalID,c.CustomerName,c.Phone,v.VehicleNumber,v.VehicleModel,
       v.VehicleType,v.DailyRate,r.RentalDate,r.ExpectedReturnDate,
       r.ActualReturnDate,r.RentalStatus,COALESCE(SUM(p.Amount),0) AS TotalPaid
FROM Rental r
JOIN Customer c ON r.CustomerID=c.CustomerID
JOIN Vehicle v ON r.VehicleID=v.VehicleID
LEFT JOIN Payment p ON r.RentalID=p.RentalID
GROUP BY r.RentalID,c.CustomerName,c.Phone,v.VehicleNumber,v.VehicleModel,
         v.VehicleType,v.DailyRate,r.RentalDate,r.ExpectedReturnDate,
         r.ActualReturnDate,r.RentalStatus;
SELECT * FROM vw_RentalReport;

-- TASK 5: TRIGGER
DELIMITER $$
CREATE TRIGGER trg_PreventUnavailableVehicle
BEFORE INSERT ON Rental
FOR EACH ROW
BEGIN
 DECLARE v_status VARCHAR(20);
 SELECT Status INTO v_status FROM Vehicle WHERE VehicleID=NEW.VehicleID;
 IF v_status <> 'Available' THEN
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT='Vehicle is not available for a new rental.';
 END IF;
END$$

CREATE TRIGGER trg_SetVehicleRented
AFTER INSERT ON Rental
FOR EACH ROW
BEGIN
 IF NEW.RentalStatus IN ('Booked','Active') THEN
  UPDATE Vehicle SET Status='Rented' WHERE VehicleID=NEW.VehicleID;
 END IF;
END$$

CREATE TRIGGER trg_SetVehicleAvailableAfterReturn
AFTER UPDATE ON Rental
FOR EACH ROW
BEGIN
 IF NEW.ActualReturnDate IS NOT NULL AND OLD.ActualReturnDate IS NULL THEN
  UPDATE Vehicle SET Status='Available' WHERE VehicleID=NEW.VehicleID;
 END IF;
END$$
DELIMITER ;

-- TASK 6: STORED PROCEDURE
DELIMITER $$
CREATE PROCEDURE RegisterRental(
 IN p_customer_id INT, IN p_vehicle_id INT,
 IN p_rental_date DATE, IN p_return_date DATE,
 IN p_payment_method VARCHAR(30)
)
BEGIN
 DECLARE v_status VARCHAR(20);
 DECLARE v_rate DECIMAL(10,2);
 DECLARE v_days INT;
 DECLARE v_charge DECIMAL(10,2);
 DECLARE v_rental_id INT;

 IF p_return_date < p_rental_date THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Return date cannot be before rental date.';
 END IF;

 SELECT Status,DailyRate INTO v_status,v_rate
 FROM Vehicle WHERE VehicleID=p_vehicle_id;

 IF v_status <> 'Available' THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Selected vehicle is not available.';
 END IF;

 SET v_days=DATEDIFF(p_return_date,p_rental_date);
 IF v_days=0 THEN SET v_days=1; END IF;
 SET v_charge=v_days*v_rate;

 INSERT INTO Rental(CustomerID,VehicleID,RentalDate,ExpectedReturnDate,RentalStatus)
 VALUES(p_customer_id,p_vehicle_id,p_rental_date,p_return_date,'Active');
 SET v_rental_id=LAST_INSERT_ID();

 INSERT INTO Payment(RentalID,PaymentDate,Amount,PaymentMethod,PaymentStatus)
 VALUES(v_rental_id,p_rental_date,v_charge,p_payment_method,'Paid');

 SELECT v_rental_id AS RentalID,v_days AS RentalDays,v_rate AS DailyRate,
        v_charge AS RentalCharge;
END$$
DELIMITER ;

-- Example: vehicle 6 is initially available.
CALL RegisterRental(5,6,'2026-09-22','2026-09-25','Cash');

-- TASK 7: OPTIMIZATION
-- Indexes on Rental.CustomerID, Rental.VehicleID, Rental.RentalStatus
-- and Payment.RentalID improve common JOIN/filter operations.
EXPLAIN
SELECT c.CustomerName,v.VehicleNumber,r.RentalDate
FROM Rental r
JOIN Customer c ON r.CustomerID=c.CustomerID
JOIN Vehicle v ON r.VehicleID=v.VehicleID
WHERE r.RentalStatus='Active';
