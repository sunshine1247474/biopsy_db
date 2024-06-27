
# Managing Biopsy Data with PostgreSQL

## Introduction

Effective management of biopsy data requires a well-structured and accessible database system. This blog post explores the creation and management of a PostgreSQL database tailored for biopsy data, encompassing patients, doctors, biopsies, and treatments.

## Entities and Relationships

### Key Entities

In this database schema, the essential entities include:

- **Patients**: Individuals undergoing biopsies.
- **Doctors**: Medical professionals performing biopsies.
- **Biopsies**: Detailed records of biopsy procedures, including results and types.
- **Treatments**: Follow-up treatments administered based on biopsy results.

### Relationships

These entities relate as follows:

- **Patients to Biopsies**: One-to-many relationship. Each patient may have multiple biopsies.
- **Doctors to Biopsies**: One-to-many relationship. Each doctor may perform multiple biopsies.
- **Biopsies to Treatments**: One-to-many relationship. Each biopsy may result in multiple treatments.

These relationships are maintained using foreign keys in the database schema.

## Creating the Database

### Steps to Create the Database and Tables

To initiate the database and define its structure, execute the following SQL commands:

```sql
-- Create the Database
CREATE DATABASE biopsy_db;

-- Connect to the new database
\c biopsy_db;
```

### Table Definitions

```sql
-- Create Patients Table
CREATE TABLE Patients (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1)
);

-- Create Doctors Table
CREATE TABLE Doctors (
    doctor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialty VARCHAR(50)
);

-- Create Biopsies Table
CREATE TABLE Biopsies (
    biopsy_id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES Patients(patient_id),
    doctor_id INTEGER REFERENCES Doctors(doctor_id),
    date DATE,
    result BOOLEAN,
    location VARCHAR(50),
    type VARCHAR(50)
);

-- Create Treatments Table
CREATE TABLE Treatments (
    treatment_id SERIAL PRIMARY KEY,
    biopsy_id INTEGER REFERENCES Biopsies(biopsy_id),
    treatment_type VARCHAR(50),
    start_date DATE,
    end_date DATE
);
```

## Adding Data to the Database

### Inserting Sample Data

To populate the tables with example data, use SQL `INSERT` statements:

```sql
-- Insert Data into Patients
INSERT INTO Patients (first_name, last_name, date_of_birth, gender) VALUES 
('John', 'Doe', '1980-01-01', 'M'),
('Jane', 'Smith', '1985-02-02', 'F');

-- Insert Data into Doctors
INSERT INTO Doctors (first_name, last_name, specialty) VALUES 
('Alice', 'Wilson', 'Oncology'),
('Bob', 'Moore', 'Pathology');

-- Insert Data into Biopsies
INSERT INTO Biopsies (patient_id, doctor_id, date, result, location, type) VALUES 
(1, 1, '2024-06-05', true, 'Lung', 'Needle Biopsy'),
(2, 2, '2024-06-06', false, 'Breast', 'Core Biopsy');

-- Insert Data into Treatments
INSERT INTO Treatments (biopsy_id, treatment_type, start_date, end_date) VALUES 
(1, 'Chemotherapy', '2024-07-01', '2024-12-31'),
(2, 'Radiation Therapy', '2024-07-02', '2024-12-31');
```

## Querying the Data

### Retrieving Information with SQL Joins

To extract meaningful insights from the database, utilize SQL `JOIN` queries:

```sql
SELECT
    P.first_name AS patient_first_name,
    P.last_name AS patient_last_name,
    D.first_name AS doctor_first_name,
    D.last_name AS doctor_last_name,
    B.date AS biopsy_date,
    B.result AS biopsy_result,
    B.location AS biopsy_location,
    B.type AS biopsy_type,
    T.treatment_type,
    T.start_date AS treatment_start_date,
    T.end_date AS treatment_end_date
FROM
    Patients P
JOIN
    Biopsies B ON P.patient_id = B.patient_id
JOIN
    Doctors D ON B.doctor_id = D.doctor_id
JOIN
    Treatments T ON B.biopsy_id = T.biopsy_id;
```

## Conclusion

Creating and maintaining a PostgreSQL database for biopsy data involves:

- Designing a robust schema with appropriate entity relationships.
- Populating the database with relevant data to simulate real-world scenarios.
- Optimizing the database with indexing and regular maintenance tasks like `VACUUM` and `ANALYZE`.
- Utilizing tools like psql, Postbird, or VS Code for database management and querying.

For detailed code examples, including the complete SQL script and database schema diagram, visit the project repository [here](https://github.com/sunshine1247474/biopsy_db).

![Database Schema](https://github.com/sunshine1247474/biopsy_db/blob/main/Diagram.png)

---

