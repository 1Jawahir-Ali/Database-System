-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 02, 2026 at 08:02 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospital_normalization`
--

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `DeptID` int(11) NOT NULL,
  `DeptName` varchar(50) DEFAULT NULL,
  `DeptHead` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`DeptID`, `DeptName`, `DeptHead`) VALUES
(1, 'Heart Care', 'Dr. Tariq'),
(2, 'Skin Clinic', 'Dr. Asma');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `DoctorID` varchar(10) NOT NULL,
  `DoctorName` varchar(50) DEFAULT NULL,
  `Specialty` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`DoctorID`, `DoctorName`, `Specialty`) VALUES
('D-30', 'Dr. Imran', 'Cardiology'),
('D-31', 'Dr. Asma', 'Dermatology');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_3nf`
--

CREATE TABLE `doctor_3nf` (
  `DoctorID` varchar(10) NOT NULL,
  `DoctorName` varchar(50) DEFAULT NULL,
  `Specialty` varchar(50) DEFAULT NULL,
  `DeptID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_3nf`
--

INSERT INTO `doctor_3nf` (`DoctorID`, `DoctorName`, `Specialty`, `DeptID`) VALUES
('D-30', 'Dr. Imran', 'Cardiology', 1),
('D-31', 'Dr. Asma', 'Dermatology', 2);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `PatientID` varchar(10) NOT NULL,
  `PatientName` varchar(50) DEFAULT NULL,
  `PatientPhone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`PatientID`, `PatientName`, `PatientPhone`) VALUES
('P-201', 'Hassan', '0300-1112233'),
('P-202', 'Mehreen', '0301-4445566'),
('P-203', 'Junaid', '0302-7778899');

-- --------------------------------------------------------

--
-- Table structure for table `visit`
--

CREATE TABLE `visit` (
  `VisitID` varchar(10) NOT NULL,
  `VisitDate` date DEFAULT NULL,
  `PatientID` varchar(10) DEFAULT NULL,
  `DoctorID` varchar(10) DEFAULT NULL,
  `Diagnosis` varchar(50) DEFAULT NULL,
  `Fee` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `visit`
--

INSERT INTO `visit` (`VisitID`, `VisitDate`, `PatientID`, `DoctorID`, `Diagnosis`, `Fee`) VALUES
('V-9001', '2026-04-10', 'P-201', 'D-30', 'Hypertension', 2500),
('V-9002', '2026-04-10', 'P-202', 'D-31', 'Eczema', 2000),
('V-9003', '2026-04-11', 'P-201', 'D-31', 'Allergy', 2000),
('V-9004', '2026-04-12', 'P-203', 'D-30', 'Arrhythmia', 3000);

-- --------------------------------------------------------

--
-- Table structure for table `visit_1nf`
--

CREATE TABLE `visit_1nf` (
  `VisitID` varchar(10) NOT NULL,
  `VisitDate` date DEFAULT NULL,
  `PatientID` varchar(10) DEFAULT NULL,
  `PatientName` varchar(50) DEFAULT NULL,
  `PatientPhone` varchar(20) DEFAULT NULL,
  `DoctorID` varchar(10) DEFAULT NULL,
  `DoctorName` varchar(50) DEFAULT NULL,
  `Specialty` varchar(50) DEFAULT NULL,
  `DeptName` varchar(50) DEFAULT NULL,
  `DeptHead` varchar(50) DEFAULT NULL,
  `Diagnosis` varchar(50) DEFAULT NULL,
  `Fee` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `visit_1nf`
--

INSERT INTO `visit_1nf` (`VisitID`, `VisitDate`, `PatientID`, `PatientName`, `PatientPhone`, `DoctorID`, `DoctorName`, `Specialty`, `DeptName`, `DeptHead`, `Diagnosis`, `Fee`) VALUES
('V-9001', '2026-04-10', 'P-201', 'Hassan', '0300-1112233', 'D-30', 'Dr. Imran', 'Cardiology', 'Heart Care', 'Dr. Tariq', 'Hypertension', 2500),
('V-9002', '2026-04-10', 'P-202', 'Mehreen', '0301-4445566', 'D-31', 'Dr. Asma', 'Dermatology', 'Skin Clinic', 'Dr. Asma', 'Eczema', 2000),
('V-9003', '2026-04-11', 'P-201', 'Hassan', '0300-1112233', 'D-31', 'Dr. Asma', 'Dermatology', 'Skin Clinic', 'Dr. Asma', 'Allergy', 2000),
('V-9004', '2026-04-12', 'P-203', 'Junaid', '0302-7778899', 'D-30', 'Dr. Imran', 'Cardiology', 'Heart Care', 'Dr. Tariq', 'Arrhythmia', 3000);

-- --------------------------------------------------------

--
-- Table structure for table `visit_3nf`
--

CREATE TABLE `visit_3nf` (
  `VisitID` varchar(10) NOT NULL,
  `VisitDate` date DEFAULT NULL,
  `PatientID` varchar(10) DEFAULT NULL,
  `DoctorID` varchar(10) DEFAULT NULL,
  `Diagnosis` varchar(50) DEFAULT NULL,
  `Fee` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `visit_3nf`
--

INSERT INTO `visit_3nf` (`VisitID`, `VisitDate`, `PatientID`, `DoctorID`, `Diagnosis`, `Fee`) VALUES
('V-9001', '2026-04-10', 'P-201', 'D-30', 'Hypertension', 2500),
('V-9002', '2026-04-10', 'P-202', 'D-31', 'Eczema', 2000),
('V-9003', '2026-04-11', 'P-201', 'D-31', 'Allergy', 2000),
('V-9004', '2026-04-12', 'P-203', 'D-30', 'Arrhythmia', 3000);

-- --------------------------------------------------------

--
-- Table structure for table `visit_unf`
--

CREATE TABLE `visit_unf` (
  `VisitID` varchar(10) DEFAULT NULL,
  `VisitDate` date DEFAULT NULL,
  `PatientID` varchar(10) DEFAULT NULL,
  `PatientName` varchar(50) DEFAULT NULL,
  `PatientPhone` varchar(20) DEFAULT NULL,
  `DoctorID` varchar(10) DEFAULT NULL,
  `DoctorName` varchar(50) DEFAULT NULL,
  `Specialty` varchar(50) DEFAULT NULL,
  `DeptName` varchar(50) DEFAULT NULL,
  `DeptHead` varchar(50) DEFAULT NULL,
  `Diagnosis` varchar(50) DEFAULT NULL,
  `Fee` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `visit_unf`
--

INSERT INTO `visit_unf` (`VisitID`, `VisitDate`, `PatientID`, `PatientName`, `PatientPhone`, `DoctorID`, `DoctorName`, `Specialty`, `DeptName`, `DeptHead`, `Diagnosis`, `Fee`) VALUES
('V-9001', '2026-04-10', 'P-201', 'Hassan', '0300-1112233', 'D-30', 'Dr. Imran', 'Cardiology', 'Heart Care', 'Dr. Tariq', 'Hypertension', 2500),
('V-9002', '2026-04-10', 'P-202', 'Mehreen', '0301-4445566', 'D-31', 'Dr. Asma', 'Dermatology', 'Skin Clinic', 'Dr. Asma', 'Eczema', 2000),
('V-9003', '2026-04-11', 'P-201', 'Hassan', '0300-1112233', 'D-31', 'Dr. Asma', 'Dermatology', 'Skin Clinic', 'Dr. Asma', 'Allergy', 2000),
('V-9004', '2026-04-12', 'P-203', 'Junaid', '0302-7778899', 'D-30', 'Dr. Imran', 'Cardiology', 'Heart Care', 'Dr. Tariq', 'Arrhythmia', 3000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`DeptID`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`DoctorID`);

--
-- Indexes for table `doctor_3nf`
--
ALTER TABLE `doctor_3nf`
  ADD PRIMARY KEY (`DoctorID`),
  ADD KEY `DeptID` (`DeptID`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`PatientID`);

--
-- Indexes for table `visit`
--
ALTER TABLE `visit`
  ADD PRIMARY KEY (`VisitID`),
  ADD KEY `PatientID` (`PatientID`),
  ADD KEY `DoctorID` (`DoctorID`);

--
-- Indexes for table `visit_1nf`
--
ALTER TABLE `visit_1nf`
  ADD PRIMARY KEY (`VisitID`);

--
-- Indexes for table `visit_3nf`
--
ALTER TABLE `visit_3nf`
  ADD PRIMARY KEY (`VisitID`),
  ADD KEY `PatientID` (`PatientID`),
  ADD KEY `DoctorID` (`DoctorID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `DeptID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `doctor_3nf`
--
ALTER TABLE `doctor_3nf`
  ADD CONSTRAINT `doctor_3nf_ibfk_1` FOREIGN KEY (`DeptID`) REFERENCES `department` (`DeptID`);

--
-- Constraints for table `visit`
--
ALTER TABLE `visit`
  ADD CONSTRAINT `visit_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`),
  ADD CONSTRAINT `visit_ibfk_2` FOREIGN KEY (`DoctorID`) REFERENCES `doctor` (`DoctorID`);

--
-- Constraints for table `visit_3nf`
--
ALTER TABLE `visit_3nf`
  ADD CONSTRAINT `visit_3nf_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`),
  ADD CONSTRAINT `visit_3nf_ibfk_2` FOREIGN KEY (`DoctorID`) REFERENCES `doctor_3nf` (`DoctorID`);
COMMIT;

/*
------------------------------------------------------------------
                            TASK 6
------------------------------------------------------------------

/*
ANOMALY ELIMINATION SUMMARY:

1. Insertion Anomaly:
   We can now insert patients, doctors, departments independently.

2. Update Anomaly:
   Changes in department or doctor info happen in only one place.

3. Deletion Anomaly:
   Deleting a visit does not delete patient/doctor records.

FINAL RESULT:
Fully normalized hospital database in 3NF with zero redundancy,
high consistency, and strong referential integrity.
*/



*/

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
