-- CIS 344 Project 1
-- Virtual Reality Arcade
-- Name: Jorge Grullon

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `vr_arcade_db`;
USE `vr_arcade_db`;

CREATE TABLE IF NOT EXISTS `vr_arcade_db`.`CUSTOMER` (
  `Customer_ID` INT NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(50) NOT NULL,
  `Last_Name` VARCHAR(50) NOT NULL,
  `Phone` VARCHAR(20) NULL,
  `Email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Customer_ID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `vr_arcade_db`.`EMPLOYEE` (
  `Employee_ID` INT NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(50) NOT NULL,
  `Last_Name` VARCHAR(50) NOT NULL,
  `Job_Title` VARCHAR(50) NOT NULL,
  `Phone` VARCHAR(20) NULL,
  `Hire_Date` DATE NOT NULL,
  PRIMARY KEY (`Employee_ID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `vr_arcade_db`.`VR_STATION` (
  `Station_ID` INT NOT NULL AUTO_INCREMENT,
  `Station_Name` VARCHAR(50) NOT NULL,
  `Equipment_Type` VARCHAR(100) NOT NULL,
  `Status` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Station_ID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `vr_arcade_db`.`GAME` (
  `Game_ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(100) NOT NULL,
  `Genre` VARCHAR(50) NOT NULL,
  `Age_Rating` VARCHAR(10) NULL,
  `Max_Players` INT NOT NULL,
  PRIMARY KEY (`Game_ID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `vr_arcade_db`.`BOOKING` (
  `Booking_ID` INT NOT NULL AUTO_INCREMENT,
  `Customer_ID` INT NOT NULL,
  `Station_ID` INT NOT NULL,
  `Employee_ID` INT NOT NULL,
  `Booking_Date` DATE NOT NULL,
  `Start_Time` TIME NOT NULL,
  `Duration` INT NOT NULL,
  `Number_of_Players` INT NOT NULL,
  `Status` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Booking_ID`),
  INDEX `FK_Booking_Customer_idx` (`Customer_ID` ASC) VISIBLE,
  INDEX `FK_Booking_Station_idx` (`Station_ID` ASC) VISIBLE,
  INDEX `FK_Booking_Employee_idx` (`Employee_ID` ASC) VISIBLE,
  CONSTRAINT `FK_Booking_Customer`
    FOREIGN KEY (`Customer_ID`) REFERENCES `vr_arcade_db`.`CUSTOMER` (`Customer_ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Booking_Station`
    FOREIGN KEY (`Station_ID`) REFERENCES `vr_arcade_db`.`VR_STATION` (`Station_ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Booking_Employee`
    FOREIGN KEY (`Employee_ID`) REFERENCES `vr_arcade_db`.`EMPLOYEE` (`Employee_ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `vr_arcade_db`.`PAYMENT` (
  `Payment_ID` INT NOT NULL AUTO_INCREMENT,
  `Booking_ID` INT NOT NULL,
  `Amount` DECIMAL(10,2) NOT NULL,
  `Payment_Date` DATE NOT NULL,
  `Payment_Method` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Payment_ID`),
  UNIQUE INDEX `Booking_ID_UNIQUE` (`Booking_ID` ASC) VISIBLE,
  CONSTRAINT `FK_Payment_Booking`
    FOREIGN KEY (`Booking_ID`) REFERENCES `vr_arcade_db`.`BOOKING` (`Booking_ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `vr_arcade_db`.`MAINTENANCE` (
  `Maintenance_ID` INT NOT NULL AUTO_INCREMENT,
  `Station_ID` INT NOT NULL,
  `Employee_ID` INT NOT NULL,
  `Maintenance_Date` DATE NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `Status` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Maintenance_ID`),
  INDEX `FK_Maintenance_Station_idx` (`Station_ID` ASC) VISIBLE,
  INDEX `FK_Maintenance_Employee_idx` (`Employee_ID` ASC) VISIBLE,
  CONSTRAINT `FK_Maintenance_Station`
    FOREIGN KEY (`Station_ID`) REFERENCES `vr_arcade_db`.`VR_STATION` (`Station_ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Maintenance_Employee`
    FOREIGN KEY (`Employee_ID`) REFERENCES `vr_arcade_db`.`EMPLOYEE` (`Employee_ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `vr_arcade_db`.`BOOKING_GAME` (
  `Booking_ID` INT NOT NULL,
  `Game_ID` INT NOT NULL,
  PRIMARY KEY (`Booking_ID`, `Game_ID`),
  INDEX `FK_BookingGame_Game_idx` (`Game_ID` ASC) VISIBLE,
  CONSTRAINT `FK_BookingGame_Booking`
    FOREIGN KEY (`Booking_ID`) REFERENCES `vr_arcade_db`.`BOOKING` (`Booking_ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_BookingGame_Game`
    FOREIGN KEY (`Game_ID`) REFERENCES `vr_arcade_db`.`GAME` (`Game_ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE `vr_arcade_db`;

INSERT INTO CUSTOMER (Customer_ID, First_Name, Last_Name, Phone, Email) VALUES
(1, 'Alex', 'Rivera', '555-101-1001', 'alex.rivera@email.com'),
(2, 'Maya', 'Johnson', '555-101-1002', 'maya.johnson@email.com'),
(3, 'Daniel', 'Lee', '555-101-1003', 'daniel.lee@email.com'),
(4, 'Sophia', 'Martinez', '555-101-1004', 'sophia.martinez@email.com');

INSERT INTO EMPLOYEE (Employee_ID, First_Name, Last_Name, Job_Title, Phone, Hire_Date) VALUES
(1, 'Michael', 'Brown', 'Arcade Manager', '555-201-2001', '2025-01-15'),
(2, 'Emily', 'Davis', 'VR Technician', '555-201-2002', '2025-03-10'),
(3, 'Chris', 'Wilson', 'Game Attendant', '555-201-2003', '2026-01-05');

INSERT INTO VR_STATION (Station_ID, Station_Name, Equipment_Type, Status) VALUES
(1, 'Station 1', 'Meta Quest 3', 'Available'),
(2, 'Station 2', 'HTC Vive Pro', 'Available'),
(3, 'Station 3', 'Valve Index', 'Maintenance'),
(4, 'Station 4', 'Meta Quest 3', 'Available');

INSERT INTO GAME (Game_ID, Title, Genre, Age_Rating, Max_Players) VALUES
(1, 'Beat Saber', 'Rhythm', 'E10+', 1),
(2, 'Arizona Sunshine', 'Action', 'M', 4),
(3, 'Walkabout Mini Golf', 'Sports', 'E', 8),
(4, 'Job Simulator', 'Simulation', 'E10+', 1),
(5, 'Among Us VR', 'Social', 'T', 10);

INSERT INTO BOOKING (Booking_ID, Customer_ID, Station_ID, Employee_ID, Booking_Date, Start_Time, Duration, Number_of_Players, Status) VALUES
(1, 1, 1, 3, '2026-09-25', '14:00:00', 60, 1, 'Confirmed'),
(2, 2, 2, 3, '2026-09-25', '15:30:00', 90, 2, 'Confirmed'),
(3, 3, 4, 1, '2026-09-26', '13:00:00', 60, 3, 'Confirmed'),
(4, 4, 1, 1, '2026-09-27', '16:00:00', 120, 2, 'Pending');

INSERT INTO PAYMENT (Payment_ID, Booking_ID, Amount, Payment_Date, Payment_Method) VALUES
(1, 1, 35.00, '2026-09-25', 'Credit Card'),
(2, 2, 55.00, '2026-09-25', 'Debit Card'),
(3, 3, 45.00, '2026-09-26', 'Credit Card'),
(4, 4, 65.00, '2026-09-27', 'Cash');

INSERT INTO MAINTENANCE (Maintenance_ID, Station_ID, Employee_ID, Maintenance_Date, Description, Status) VALUES
(1, 3, 2, '2026-09-23', 'Headset display cable replacement', 'In Progress'),
(2, 2, 2, '2026-09-20', 'Controller calibration and testing', 'Completed'),
(3, 1, 2, '2026-09-18', 'Routine headset cleaning and inspection', 'Completed');

INSERT INTO BOOKING_GAME (Booking_ID, Game_ID) VALUES
(1, 1), (1, 4), (2, 2), (2, 3), (3, 3), (3, 5), (4, 1), (4, 5);

SELECT * FROM CUSTOMER;
SELECT * FROM EMPLOYEE;
SELECT * FROM VR_STATION;
SELECT * FROM GAME;
SELECT * FROM BOOKING;
SELECT * FROM PAYMENT;
SELECT * FROM MAINTENANCE;
SELECT * FROM BOOKING_GAME;

SELECT
    B.Booking_ID,
    CONCAT(C.First_Name, ' ', C.Last_Name) AS Customer,
    V.Station_Name,
    CONCAT(E.First_Name, ' ', E.Last_Name) AS Employee,
    B.Booking_Date,
    B.Start_Time,
    B.Status
FROM BOOKING B
JOIN CUSTOMER C ON B.Customer_ID = C.Customer_ID
JOIN VR_STATION V ON B.Station_ID = V.Station_ID
JOIN EMPLOYEE E ON B.Employee_ID = E.Employee_ID;

SELECT B.Booking_ID, G.Title, G.Genre
FROM BOOKING B
JOIN BOOKING_GAME BG ON B.Booking_ID = BG.Booking_ID
JOIN GAME G ON BG.Game_ID = G.Game_ID
ORDER BY B.Booking_ID;

SELECT
    P.Payment_ID,
    B.Booking_ID,
    CONCAT(C.First_Name, ' ', C.Last_Name) AS Customer,
    P.Amount,
    P.Payment_Date,
    P.Payment_Method
FROM PAYMENT P
JOIN BOOKING B ON P.Booking_ID = B.Booking_ID
JOIN CUSTOMER C ON B.Customer_ID = C.Customer_ID;

SELECT
    C.Customer_ID,
    CONCAT(C.First_Name, ' ', C.Last_Name) AS Customer,
    COUNT(B.Booking_ID) AS Total_Bookings
FROM CUSTOMER C
LEFT JOIN BOOKING B ON C.Customer_ID = B.Customer_ID
GROUP BY C.Customer_ID, C.First_Name, C.Last_Name;

UPDATE BOOKING
SET Status = 'Completed'
WHERE Booking_ID = 1;

SELECT * FROM BOOKING WHERE Booking_ID = 1;
