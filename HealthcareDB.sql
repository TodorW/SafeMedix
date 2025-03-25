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

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    AppointmentTime TIME,
    ReasonForVisit TEXT,
    Status ENUM('Scheduled', 'Completed', 'Cancelled', 'No Show'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
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

CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY AUTO_INCREMENT,
    MedicationName VARCHAR(100),
    Dosage VARCHAR(50),
    SideEffects TEXT
);

CREATE TABLE TreatmentMedications (
    TreatmentID INT,
    MedicationID INT,
    PRIMARY KEY (TreatmentID, MedicationID),
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
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

CREATE TABLE HospitalDepartments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100),
    HospitalID INT,
    FOREIGN KEY (HospitalID) REFERENCES Hospitals(HospitalID)
);

CREATE TABLE Billing (
    BillID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    BillDate DATE,
    Amount DECIMAL(10, 2),
    PaymentStatus ENUM('Paid', 'Pending', 'Overdue'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Procedures (
    ProcedureID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    ProcedureName VARCHAR(255),
    ProcedureDate DATE,
    ProcedureDescription TEXT,
    Cost DECIMAL(10, 2),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE InsuranceDetails (
    InsuranceID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    ProviderName VARCHAR(255),
    PolicyNumber VARCHAR(255),
    CoverageDetails TEXT,
    ExpiryDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE LabTests (
    TestID INT PRIMARY KEY AUTO_INCREMENT,
    DiagnosisID INT,
    TestType VARCHAR(100),
    TestDate DATE,
    ResultDescription TEXT,
    TestCost DECIMAL(10, 2),
    FOREIGN KEY (DiagnosisID) REFERENCES Diagnoses(DiagnosisID)
);

CREATE TABLE Admissions (
    AdmissionID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    HospitalID INT,
    AdmissionDate DATE,
    DischargeDate DATE,
    AdmissionReason TEXT,
    RoomNumber VARCHAR(10),
    AdmissionStatus ENUM('Admitted', 'Discharged', 'Transferred'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (HospitalID) REFERENCES Hospitals(HospitalID)
);
