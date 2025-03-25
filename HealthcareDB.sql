CREATE DATABASE HealthcareDB;
USE HealthcareDB;

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    DOB DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Address TEXT,
    Phone VARCHAR(15),
    Email VARCHAR(100),
    InsuranceProvider VARCHAR(100)
);

CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    HospitalID INT,
    DoctorID INT,
    VisitDate DATE,
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (HospitalID) REFERENCES Hospitals(HospitalID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Diagnoses (
    DiagnosisID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DiagnosisDate DATE,
    DiagnosisCode VARCHAR(50),
    DiagnosisDescription TEXT,
    Severity ENUM('Mild', 'Moderate', 'Severe'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Treatments (
    TreatmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DiagnosisID INT,
    TreatmentDate DATE,
    TreatmentType VARCHAR(100),
    Medication VARCHAR(100),
    Dosage VARCHAR(50),
    TreatmentOutcome ENUM('Recovered', 'Ongoing', 'Complications'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DiagnosisID) REFERENCES Diagnoses(DiagnosisID)
);

CREATE TABLE Hospitals (
    HospitalID INT PRIMARY KEY AUTO_INCREMENT,
    HospitalName VARCHAR(255),
    Location TEXT,
    Capacity INT
);

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Specialization VARCHAR(100),
    HospitalID INT,
    FOREIGN KEY (HospitalID) REFERENCES Hospitals(HospitalID)
);
