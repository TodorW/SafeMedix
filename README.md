---

# SafeMedix - Healthcare Data Management System

## Description

SafeMedix is a comprehensive healthcare data management system designed to securely store and manage electronic health records (EHR), including patient demographics, diagnoses, treatments, medical records, hospital data, billing information, insurance details, and much more. This system enables healthcare providers to efficiently manage patient care, analyze treatment outcomes, and monitor hospital performance while ensuring compliance with data privacy regulations.

### Key Features
- **Patient Management**: Store patient demographics, emergency contacts, insurance details, and medical history.
- **Hospital and Doctor Management**: Track hospitals, their departments, and associated doctors.
- **Appointment Scheduling**: Book and manage appointments between patients and doctors.
- **Diagnoses & Treatments**: Capture diagnoses, treatments, and treatment outcomes.
- **Medication Management**: Track medications prescribed during treatments.
- **Billing**: Capture billing data and payment status for patients.
- **Lab Tests & Procedures**: Store lab test results and medical procedures linked to diagnoses.
- **Insurance Management**: Store and manage patient insurance details, coverage, and policy expiration.
- **Patient Feedback**: Collect patient feedback and satisfaction ratings for healthcare services.
- **Data Security & Compliance**: Ensures HIPAA compliance through secure storage and handling of sensitive healthcare data.

## Database Schema

The SafeMedix database schema includes the following tables:

- **Patients**: Stores patient demographic information such as name, DOB, contact details, and insurance provider.
- **Hospitals**: Stores information about hospitals including name, location, and capacity.
- **Doctors**: Stores doctor information, including specialization and hospital affiliation.
- **Appointments**: Records appointments between patients and doctors, with details such as appointment date, reason, and status.
- **Diagnoses**: Tracks diagnoses for patients including severity, diagnosis code, and description.
- **Treatments**: Stores treatment details such as type, medication prescribed, dosage, and outcome.
- **Medications**: Stores medication details, including name, dosage, and side effects.
- **MedicalRecords**: Captures patient visits to the hospital and associated details (e.g., doctor, notes).
- **Billing**: Records billing information for patients, including payment status.
- **InsuranceDetails**: Stores patient insurance policy details.
- **LabTests**: Stores lab test results linked to diagnoses.
- **Admissions**: Tracks hospital admissions, discharge dates, and room numbers.
- **PatientHistory**: Captures any recorded patient history provided by doctors.
- **Referrals**: Manages referrals from one doctor to another.
- **MedicalCertificates**: Manages sick leave, disability, or other medical certificates for patients.
- **PatientDocuments**: Stores patient-related documents such as IDs and medical reports.
- **EmergencyContacts**: Stores emergency contact details for patients.

## Technologies Used

- **Database**: MySQL
- **Programming Language**: SQL (for database creation and manipulation)
- **Compliance**: HIPAA compliance (privacy and data security standards)
- **License**: Choose a suitable open-source license based on project goals.

## Installation

To use this system, you need to set up a MySQL database server. Follow these steps:

1. Install MySQL on your local machine or use a cloud-based MySQL service.
2. Clone the SafeMedix repository to your local machine.
3. Import the `HealthcareDB` schema into your MySQL database:
   - Open MySQL Workbench or any SQL client.
   - Run the `CREATE DATABASE HealthcareDB;` command to create the database.
   - Execute the schema SQL script provided in this repository to create the necessary tables.
4. Customize the database by adding real data or creating interfaces to interact with the system.

## Usage

- Use SQL queries to interact with the database, such as:
  - Inserting new patients, doctors, or hospital records.
  - Updating treatment details or diagnoses.
  - Querying appointment schedules and patient histories.
  - Analyzing billing records and insurance coverage.

Example queries:

```sql
-- Add a new patient
INSERT INTO Patients (FirstName, LastName, DOB, Gender, Address, Phone, Email, InsuranceProvider)
VALUES ('John', 'Doe', '1985-05-12', 'Male', '123 Main St, City, State', '555-1234', 'johndoe@example.com', 'HealthCorp');

-- Query all appointments for a patient
SELECT * FROM Appointments WHERE PatientID = 1;
```

## Contributing

We welcome contributions to enhance SafeMedix! If you'd like to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Make your changes and commit them (`git commit -am 'Add new feature'`).
4. Push your changes to your fork (`git push origin feature/your-feature`).
5. Create a pull request.

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- The SafeMedix project was created to help healthcare providers improve data management.
- Special thanks to MySQL for being an easy-to-use relational database management system.
- All contributors and open-source libraries used in this project are highly appreciated.

---
