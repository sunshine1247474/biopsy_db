-- Start the PostgreSQL shell
-- psql

-- Create the Database
CREATE DATABASE biopsy_db;

-- Connect to the new database
\c biopsy_db

-- Create the Tables
CREATE TABLE Patients (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1)
);

CREATE TABLE Doctors (
    doctor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialty VARCHAR(50)
);

CREATE TABLE Biopsies (
    biopsy_id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES Patients(patient_id),
    doctor_id INTEGER REFERENCES Doctors(doctor_id),
    date DATE,
    result BOOLEAN,
    location VARCHAR(50),
    type VARCHAR(50)
);

CREATE TABLE Treatments (
    treatment_id SERIAL PRIMARY KEY,
    biopsy_id INTEGER REFERENCES Biopsies(biopsy_id),
    treatment_type VARCHAR(50),
    start_date DATE,
    end_date DATE
);

-- Insert Data
INSERT INTO Patients (first_name, last_name, date_of_birth, gender) VALUES 
('John', 'Doe', '1980-01-01', 'M'),
('Jane', 'Smith', '1985-02-02', 'F'),
('Jim', 'Brown', '1990-03-03', 'M'),
('Julia', 'Johnson', '1995-04-04', 'F'),
('Jack', 'Williams', '2000-05-05', 'M'),
('Jill', 'Jones', '2005-06-06', 'F'),
('Jerry', 'Miller', '2010-07-07', 'M'),
('Jasmine', 'Davis', '2015-08-08', 'F'),
('Jacob', 'Garcia', '2020-09-09', 'M'),
('Joyce', 'Martinez', '2025-10-10', 'F');

INSERT INTO Doctors (first_name, last_name, specialty) VALUES 
('Alice', 'Wilson', 'Oncology'),
('Bob', 'Moore', 'Pathology'),
('Charlie', 'Taylor', 'Radiology'),
('Diana', 'Anderson', 'Surgery'),
('Edward', 'Thomas', 'Immunology'),
('Fiona', 'Jackson', 'Genetics'),
('George', 'White', 'Pediatrics'),
('Hannah', 'Harris', 'Geriatrics'),
('Ivan', 'Martin', 'Neurology'),
('Irene', 'Thompson', 'Cardiology');

INSERT INTO Biopsies (patient_id, doctor_id, date, result, location, type) VALUES 
(1, 1, '2024-06-05', true, 'Lung', 'Needle Biopsy'),
(2, 2, '2024-06-06', false, 'Breast', 'Core Biopsy'),
(3, 3, '2024-06-07', true, 'Liver', 'Fine Needle Aspiration'),
(4, 4, '2024-06-08', false, 'Skin', 'Punch Biopsy'),
(5, 5, '2024-06-09', true, 'Prostate', 'Transrectal Biopsy'),
(6, 6, '2024-06-10', false, 'Kidney', 'Open Biopsy'),
(7, 7, '2024-06-11', true, 'Bone', 'Closed Biopsy'),
(8, 8, '2024-06-12', false, 'Thyroid', 'Incisional Biopsy'),
(9, 9, '2024-06-13', true, 'Pancreas', 'Excisional Biopsy'),
(10, 10, '2024-06-14', false, 'Stomach', 'Endoscopic Biopsy');

INSERT INTO Treatments (biopsy_id, treatment_type, start_date, end_date) VALUES 
(1, 'Chemotherapy', '2024-07-01', '2024-12-31'),
(2, 'Radiation Therapy', '2024-07-02', '2024-12-31'),
(3, 'Immunotherapy', '2024-07-03', '2024-12-31'),
(4, 'Targeted Therapy', '2024-07-04', '2024-12-31'),
(5, 'Hormone Therapy', '2024-07-05', '2024-12-31'),
(6, 'Stem Cell Transplant', '2024-07-06', '2024-12-31'),
(7, 'Precision Medicine', '2024-07-07', '2024-12-31'),
(8, 'Surgery', '2024-07-08', '2024-12-31'),
(9, 'Photodynamic Therapy', '2024-07-09', '2024-12-31'),
(10, 'Lasers in Cancer Treatment', '2024-07-10', '2024-12-31');

-- Join the Tables
SELECT P.first_name AS patient_first_name, P.last_name AS patient_last_name, 
       D.first_name AS doctor_first_name, D.last_name AS doctor_last_name, 
       B.date AS biopsy_date, B.result AS biopsy_result, B.location AS biopsy_location, B.type AS biopsy_type,
       T.treatment_type, T.start_date AS treatment_start_date, T.end_date AS treatment_end_date
FROM Patients P
JOIN Biopsies B ON P.patient_id = B.patient_id
JOIN Doctors D ON B.doctor_id = D.doctor_id
JOIN Treatments T ON B.biopsy_id = T.biopsy_id;
