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
    InsuranceProvider VARCHAR(100),
    EmergencyContactName VARCHAR(100),
    EmergencyContactPhone VARCHAR(15)
);

CREATE TABLE Hospitals (
    HospitalID INT PRIMARY KEY AUTO_INCREMENT,
    HospitalName VARCHAR(255),
    Location TEXT,
    Capacity INT,
    EstablishedYear INT,
    HospitalType ENUM('Public', 'Private', 'Non-Profit', 'For-Profit')
);

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Specialization VARCHAR(100),
    HospitalID INT,
    LicenseNumber VARCHAR(50),
    ExperienceYears INT,
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
    FollowUpDate DATE,
    AppointmentType ENUM('In-person', 'Telemedicine'),
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
    DiagnosisType ENUM('Initial', 'Follow-up', 'Emergency'),
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
    TreatmentDuration INT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DiagnosisID) REFERENCES Diagnoses(DiagnosisID)
);

CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY AUTO_INCREMENT,
    MedicationName VARCHAR(100),
    Dosage VARCHAR(50),
    SideEffects TEXT,
    PrescriptionRequired BOOLEAN,
    MedicationCategory ENUM('Antibiotic', 'Painkiller', 'Antidepressant', 'Vaccine', 'Other')
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
    VisitType ENUM('Routine', 'Emergency', 'Follow-up'),
    Notes TEXT,
    RecordStatus ENUM('Active', 'Archived'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (HospitalID) REFERENCES Hospitals(HospitalID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE HospitalDepartments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100),
    HospitalID INT,
    DepartmentHead INT,
    FOREIGN KEY (HospitalID) REFERENCES Hospitals(HospitalID),
    FOREIGN KEY (DepartmentHead) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Billing (
    BillID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    BillDate DATE,
    Amount DECIMAL(10, 2),
    PaymentStatus ENUM('Paid', 'Pending', 'Overdue'),
    PaymentMethod ENUM('Credit Card', 'Insurance', 'Cash', 'Other'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Procedures (
    ProcedureID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    ProcedureName VARCHAR(255),
    ProcedureDate DATE,
    ProcedureDescription TEXT,
    Cost DECIMAL(10, 2),
    ProcedureOutcome ENUM('Successful', 'Failed', 'Ongoing'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE InsuranceDetails (
    InsuranceID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    ProviderName VARCHAR(255),
    PolicyNumber VARCHAR(255),
    CoverageDetails TEXT,
    ExpiryDate DATE,
    PremiumAmount DECIMAL(10, 2),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE LabTests (
    TestID INT PRIMARY KEY AUTO_INCREMENT,
    DiagnosisID INT,
    TestType VARCHAR(100),
    TestDate DATE,
    ResultDescription TEXT,
    TestCost DECIMAL(10, 2),
    TestStatus ENUM('Pending', 'Completed', 'Failed'),
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
    IsCritical BOOLEAN,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (HospitalID) REFERENCES Hospitals(HospitalID)
);

CREATE TABLE PatientHistory (
    HistoryID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    HistoryDescription TEXT,
    DateRecorded DATE,
    RecordedByDoctorID INT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (RecordedByDoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Referrals (
    ReferralID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    ReferringDoctorID INT,
    ReferredToDoctorID INT,
    ReferralDate DATE,
    ReferralReason TEXT,
    Status ENUM('Pending', 'Completed'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (ReferringDoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (ReferredToDoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE MedicalCertificates (
    CertificateID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    IssuedDate DATE,
    CertificateType ENUM('Sick Leave', 'Disability', 'Other'),
    ValidUntil DATE,
    IssuedByDoctorID INT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (IssuedByDoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE PatientAlerts (
    AlertID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    AlertMessage TEXT,
    AlertDate DATE,
    AlertStatus ENUM('Active', 'Resolved'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE PatientDocuments (
    DocumentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DocumentType ENUM('ID Proof', 'Medical Report', 'Insurance', 'Other'),
    DocumentName VARCHAR(255),
    UploadDate DATE,
    DocumentURL TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE PatientFeedback (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    FeedbackDate DATE,
    Rating INT,
    Comments TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE EmergencyContacts (
    ContactID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    ContactName VARCHAR(100),
    Relationship ENUM('Spouse', 'Parent', 'Sibling', 'Friend', 'Other'),
    ContactPhone VARCHAR(15),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);
