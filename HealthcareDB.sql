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
    EmergencyContactPhone VARCHAR(15),
    BloodType ENUM('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'),
    MaritalStatus ENUM('Single', 'Married', 'Divorced', 'Widowed'),
    PreferredLanguage VARCHAR(50),
    Ethnicity VARCHAR(50),
    Nationality VARCHAR(50),
    SocialSecurityNumber VARCHAR(20),
    PrimaryCareDoctorID INT,
    FOREIGN KEY (PrimaryCareDoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Hospitals (
    HospitalID INT PRIMARY KEY AUTO_INCREMENT,
    HospitalName VARCHAR(255),
    Location TEXT,
    Capacity INT,
    EstablishedYear INT,
    HospitalType ENUM('Public', 'Private', 'Non-Profit', 'For-Profit'),
    EmergencyRoomCapacity INT,
    ICUCapacity INT
);

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Specialization VARCHAR(100),
    HospitalID INT,
    LicenseNumber VARCHAR(50),
    ExperienceYears INT,
    MedicalSchool VARCHAR(100),
    BoardCertified BOOLEAN,
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
    DurationMinutes INT,
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
    DiagnosisSource ENUM('Primary Care', 'Specialist', 'Emergency'),
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
    FollowUpRequired BOOLEAN,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DiagnosisID) REFERENCES Diagnoses(DiagnosisID)
);

CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY AUTO_INCREMENT,
    MedicationName VARCHAR(100),
    Dosage VARCHAR(50),
    SideEffects TEXT,
    PrescriptionRequired BOOLEAN,
    MedicationCategory ENUM('Antibiotic', 'Painkiller', 'Antidepressant', 'Vaccine', 'Other'),
    MedicationManufacturer VARCHAR(100),
    ExpiryDate DATE
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
    ReferralRequired BOOLEAN,
    RecordCreationDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (HospitalID) REFERENCES Hospitals(HospitalID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE HospitalDepartments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100),
    HospitalID INT,
    DepartmentHead INT,
    ContactNumber VARCHAR(20),
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
    BillDescription TEXT,
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
    AnesthesiaRequired BOOLEAN,
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
    PlanType VARCHAR(50),
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
    TestResult VARCHAR(255),
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
    LengthOfStay INT,
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
    FollowUpDate DATE,
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
    AlertType ENUM('Emergency', 'Reminder', 'General'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE PatientDocuments (
    DocumentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DocumentType ENUM('ID Proof', 'Medical Report', 'Insurance', 'Other'),
    DocumentName VARCHAR(255),
    UploadDate DATE,
    DocumentURL TEXT,
    DocumentStatus ENUM('Active', 'Archived'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE PatientFeedback (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    FeedbackDate DATE,
    Rating INT,
    Comments TEXT,
    FeedbackCategory ENUM('Appointment', 'Treatment', 'Facilities', 'Doctor'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE EmergencyContacts (
    ContactID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    ContactName VARCHAR(100),
    Relationship ENUM('Spouse', 'Parent', 'Sibling', 'Friend', 'Other'),
    ContactPhone VARCHAR(15),
    ContactEmail VARCHAR(100),
    IsPrimary BOOLEAN,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE MedicalSupplies (
    SupplyID INT PRIMARY KEY AUTO_INCREMENT,
    SupplyName VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    UnitCost DECIMAL(10, 2),
    SupplierName VARCHAR(100),
    SupplyStatus ENUM('In Stock', 'Out of Stock', 'Discontinued'),
    ReorderLevel INT
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Role VARCHAR(100),
    HospitalID INT,
    HireDate DATE,
    Salary DECIMAL(10, 2),
    DepartmentID INT,
    FOREIGN KEY (HospitalID) REFERENCES Hospitals(HospitalID),
    FOREIGN KEY (DepartmentID) REFERENCES HospitalDepartments(DepartmentID)
);

CREATE TABLE StaffSchedules (
    ScheduleID INT PRIMARY KEY AUTO_INCREMENT,
    StaffID INT,
    ShiftStartTime TIME,
    ShiftEndTime TIME,
    DayOfWeek ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(100) UNIQUE,
    PasswordHash VARCHAR(255),
    Role ENUM('Admin', 'Doctor', 'Nurse', 'Patient'),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE AuditTrail (
    AuditID INT PRIMARY KEY AUTO_INCREMENT,
    TableName VARCHAR(100),
    RecordID INT,
    Action ENUM('INSERT', 'UPDATE', 'DELETE'),
    UserID INT,
    ActionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (User ID) REFERENCES Users(UserID)
);

CREATE TABLE AppointmentReminders (
    ReminderID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentID INT,
    ReminderDate DATE,
    ReminderTime TIME,
    ReminderMethod ENUM('Email', 'SMS'),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

CREATE TABLE PatientPortalAccess (
    AccessID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    AccessGranted BOOLEAN,
    AccessDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE TelemedicineSessions (
    SessionID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentID INT,
    SessionLink VARCHAR(255),
    SessionDate DATE,
    SessionTime TIME,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    MedicationID INT,
    Dosage VARCHAR(50),
    PrescriptionDate DATE,
    ExpiryDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

CREATE TABLE LabTestResults (
    ResultID INT PRIMARY KEY AUTO_INCREMENT,
    TestID INT,
    ResultDate DATE,
    ResultValue VARCHAR(255),
    Interpretation TEXT,
    FOREIGN KEY (TestID) REFERENCES LabTests(TestID)
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    SupplyID INT,
    QuantityInStock INT,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (SupplyID) REFERENCES MedicalSupplies(SupplyID)
);

CREATE TABLE QualityMetrics (
    MetricID INT PRIMARY KEY AUTO_INCREMENT,
    MetricName VARCHAR(100),
    MetricValue DECIMAL(10, 2),
    MeasurementDate DATE,
    Notes TEXT
);

CREATE TABLE PatientEducationResources (
    ResourceID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    ResourceType ENUM('Video', 'Article', 'Brochure'),
    ResourceURL VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE EmergencyAlerts (
    AlertID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    AlertMessage TEXT,
    AlertDate DATE,
    AlertStatus ENUM('Active', 'Resolved'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE FeedbackLoop (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    FeedbackDate DATE,
    Comments TEXT,
    ActionTaken TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);