CREATE TABLE doctor (
    doctor_id INT PRIMARY KEY,
    ssn VARCHAR (13),
    name VARCHAR (50),
    specialty VARCHAR (100),
    experience_year INT
);

CREATE TABLE patient (
    patient_id INT PRIMARY KEY,
    ssn VARCHAR (13),
    name VARCHAR (50),
    address VARCHAR (100),
    age INT,
    doctor_id INT,
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

CREATE TABLE pharmacy (
    pharmacy_id INT PRIMARY KEY,
    name VARCHAR (100),
    address VARCHAR (200),
    phone VARCHAR (10)
);

CREATE TABLE drug (
    drug_id INT PRIMARY KEY,
    trade_name VARCHAR (100),
    formula VARCHAR (100)
);
    
CREATE TABLE pharm_co (
    pharm_co_id INT PRIMARY KEY,
    name VARCHAR (100),
    phone VARCHAR (13)
);

CREATE TABLE sell (
    sell_id INT PRIMARY KEY,
    pharmacy_id INT,
    drug_id INT,
    price Numeric,
    FOREIGN KEY (pharmacy_id) REFERENCES pharmacy(pharmacy_id),
    FOREIGN KEY (drug_id) REFERENCES drug(drug_id)
);

CREATE TABLE contract (
    contract_id INT PRIMARY KEY,
    pharmacy_id INT,
    pharm_co_id INT,
    drug_id INT,
    start_date DATE,
    end_date DATE,
    contract_note VARCHAR (200),
    supervisor VARCHAR (100),
    FOREIGN KEY (pharmacy_id) REFERENCES pharmacy(pharmacy_id),
    FOREIGN KEY (drug_id) REFERENCES drug(drug_id),
    FOREIGN KEY (pharm_co_id) REFERENCES pharm_co(pharm_co_id)
);

CREATE TABLE prescription (
    prescription_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    drug_id INT,
    prescription_date DATE,
    quantity INT,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (drug_id) REFERENCES drug(drug_id)
);

INSERT INTO doctor (doctor_id, ssn, name, specialty, experience_year) VALUES
(1, '1101701234567', 'Dr. Somchai', 'Cardiology', 15),
(2, '1201702345678', 'Dr. Supaporn', 'Pediatrics', 10),
(3, '1301703456789', 'Dr. Anan', 'Neurology', 8);

INSERT INTO patient (patient_id, ssn, name, address, age, doctor_id) VALUES
(1, '3101704567890', 'Mr. Adisak', '123 Sukhumvit Rd, Bangkok', 45, 1),
(2, '3201705678901', 'Mrs. Kamonwan', '456 Rama IV Rd, Bangkok', 30, 2),
(3, '3301706789012', 'Ms. Nattaya', '789 Silom Rd, Bangkok', 28, 3);

INSERT INTO drug (drug_id, trade_name, formula) VALUES
(1, 'Paracetamol', 'C8H9NO2'),
(2, 'Amoxicillin', 'C16H19N3O5S'),
(3, 'Aspirin', 'C9H8O4');

INSERT INTO prescription (prescription_id, patient_id, doctor_id, drug_id, prescription_date, quantity) VALUES
(1, 1, 1, 1, '2025-12-01', 10),
(2, 2, 2, 2, '2025-12-02', 20),
(3, 3, 3, 3, '2025-12-03', 15);

INSERT INTO pharmacy (pharmacy_id, name, address, phone) VALUES
(1, 'Bangkok Pharmacy', '101 Sukhumvit Rd, Bangkok', '0812345678'),
(2, 'Central Pharmacy', '202 Silom Rd, Bangkok', '0898765432');

INSERT INTO pharm_co (pharm_co_id, name, phone) VALUES
(1, 'Thai Pharma Co., Ltd.', '021234567'),
(2, 'Global Pharma Inc.', '022345678');

INSERT INTO sell (sell_id, pharmacy_id, drug_id, price) VALUES
(1, 1, 1, 5.50),
(2, 1, 2, 12.75),
(3, 2, 1, 5.75),
(4, 2, 3, 8.20);

INSERT INTO contract (contract_id, pharmacy_id, pharm_co_id, drug_id, start_date, end_date, contract_note, supervisor) VALUES
(1, 1, 1, 1, '2025-01-01', '2025-12-31', 'Annual supply of Paracetamol', 'Mr. Chai'),
(2, 1, 2, 2, '2025-06-01', '2025-12-31', 'Supply of Amoxicillin', 'Ms. Pim'),
(3, 2, 1, 1, '2025-03-01', '2025-12-31', 'Paracetamol supply', 'Mr. Somchai'),
(4, 2, 2, 3, '2025-07-01', '2025-12-31', 'Supply of Aspirin', 'Ms. Supaporn');

SELECT doctor.name, patient.name 
FROM doctor 
join patient ON doctor.doctor_id = patient.patient_id;

SELECT patient.name, doctor.name, drug.trade_name, prescription.quantity
FROM doctor 
join patient ON doctor.doctor_id = patient.patient_id
join prescription ON patient.patient_id = prescription.patient_id
join drug ON prescription.drug_id = drug.drug_id;

SELECT pharmacy.name AS pharmacy, drug.trade_name AS drug, sell.price
FROM pharmacy
join sell ON pharmacy.pharmacy_id = sell.pharmacy_id
join drug ON sell.drug_id = drug.drug_id;

SELECT pharmacy.name AS pharmacy, pharm_co.name AS pharm_co, drug.trade_name AS drug, contract.start_date, contract.end_date
FROM pharmacy
join contract ON pharmacy.pharmacy_id = contract.pharmacy_id    
join pharm_co ON contract.pharm_co_id = pharm_co.pharm_co_id
join drug ON contract.drug_id = drug.drug_id;