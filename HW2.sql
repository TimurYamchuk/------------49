CREATE DATABASE HOSPITAL;
GO

USE HOSPITAL;
GO

CREATE TABLE Departments (
    Id INT PRIMARY KEY IDENTITY,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Financing MONEY NOT NULL DEFAULT 0,
    Floor INT NOT NULL CHECK (Floor >= 1),
    Name NVARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE Diseases (
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Severity INT NOT NULL DEFAULT 1 CHECK (Severity >= 1)
);
GO

CREATE TABLE Doctors (
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(MAX) NOT NULL,
    Phone CHAR(10) NULL,
    Premium MONEY NOT NULL DEFAULT 0 CHECK (Premium >= 0),
    Salary MONEY NOT NULL CHECK (Salary > 0),
    Surname NVARCHAR(MAX) NOT NULL
);
GO

CREATE TABLE Examinations (
    Id INT PRIMARY KEY IDENTITY,
    DayOfWeek INT NOT NULL CHECK (DayOfWeek BETWEEN 1 AND 7),
    EndTime TIME NOT NULL,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    StartTime TIME NOT NULL CHECK (StartTime >= '08:00' AND StartTime <= '18:00')
);
GO

CREATE TABLE Wards (
    Id INT PRIMARY KEY IDENTITY,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Floor INT NOT NULL CHECK (Floor >= 1),
    Name NVARCHAR(20) NOT NULL UNIQUE
);
GO

-- ������� Departments
INSERT INTO Departments (Building, Financing, Floor, Name)
VALUES (1, 100000, 1, 'Cardiology'),
       (2, 200000, 2, 'Oncology'),
       (3, 150000, 1, 'Neurology'),
       (4, 180000, 3, 'Orthopedics'),
       (5, 120000, 2, 'Pediatrics'),
       (1, 90000, 4, 'Dermatology');

-- ������� Diseases
INSERT INTO Diseases (Name, Severity)
VALUES ('Cancer', 5),
       ('Heart Disease', 4),
       ('Stroke', 3),
       ('Diabetes', 2),
       ('Pneumonia', 2),
       ('Allergies', 1);

-- ������� Doctors
INSERT INTO Doctors (Name, Phone, Premium, Salary, Surname)
VALUES ('Aslan', '1234567890', 5000, 100000, 'Gadzhyyev'),
       ('Oleksiy', '9876543210', 3000, 90000, 'Berezovskyy'),
       ('Maksym', '5555555555', 4000, 110000, 'Nazaryshyn'),
       ('Kristine', NULL, 2000, 80000, 'Cherkezyan'),
       ('Valeriya', '4444444444', 2500, 95000, 'Prokhorova'),
       ('Darya', '6666666666', 3500, 95000, 'Ivaskevych');

-- ������� Examinations
INSERT INTO Examinations (DayOfWeek, EndTime, Name, StartTime)
VALUES (1, '10:00', 'MRI Scan', '08:00'),
       (2, '12:00', 'Ultrasound', '09:00'),
       (3, '14:00', 'X-ray', '10:00'),
       (4, '16:00', 'Blood Test', '11:00'),
       (5, '18:00', 'EKG', '12:00'),
       (6, '15:00', 'CT Scan', '13:00');

-- ������� Wards
INSERT INTO Wards (Building, Floor, Name)
VALUES (1, 1, 'Ward A'),
       (2, 2, 'Ward B'),
       (3, 3, 'Ward C'),
       (4, 1, 'Ward D'),
       (5, 2, 'Ward E'),
       (1, 4, 'Ward F');

Select *
From Departments

Select *
From Diseases

Select *
From Doctors

Select *
From Examinations

Select *
From Wards

--1. ������� ���������� ������� �����.
SELECT * FROM Wards;
--2. ������� ������� � �������� ���� ������.
SELECT Surname, Phone FROM Doctors;
--3. ������� ��� ����� ��� ����������, �� ������� ������������� ������.
SELECT DISTINCT Floor FROM Wards;
--4. ������� �������� ����������� ��� ������ �Name of Disease� � ������� �� ������� ��� ������ �Severity of Disease�.
SELECT Name, Severity AS 'Severity of Disease' FROM Diseases WHERE Name = 'Name of Disease';
--5. ������������ ��������� FROM ��� ����� ���� ������ ���� ������, ��������� ��� ��� ����������.
SELECT D.Name, E.Name, W.Name
FROM Doctors AS D, Examinations AS E, Wards AS W;
--6. ������� �������� ���������, ������������� � ������� 5 � ������� ���� �������������� ����� 30000.
SELECT Name FROM Departments WHERE Building = 5 AND Financing < 30000;
--7. ������� �������� ���������, ������������� � 3-� ������� � ������ �������������� � ��������� �� 12000 �� 15000.
SELECT Name FROM Departments WHERE Building = 3 AND Financing BETWEEN 12000 AND 15000;
--8. ������� �������� �����, ������������� � �������� 4 � 5 �� 1-� �����.
SELECT Name FROM Wards WHERE Building IN (4, 5) AND Floor = 1;
--9. ������� ��������, ������� � ����� �������������� ���������, ������������� � �������� 3 ��� 6 � ������� ���� �������������� ������ 11000 ��� ������ 25000.
SELECT Name, Building, Financing FROM Departments WHERE (Building = 3 OR Building = 6) AND (Financing < 11000 OR Financing > 25000);
--10. ������� ������� ������, ��� �������� (����� ������ � ��������) ��������� 1500.
SELECT Surname FROM Doctors WHERE (Salary + Premium) > 1500;
--11. ������� ������� ������, � ������� �������� �������� ��������� ����������� ��������.
SELECT Surname FROM Doctors WHERE (Salary / 2) > (3 * Premium);
--12. ������� �������� ������������ ��� ����������, ���������� � ������ ��� ��� ������ � 12:00 �� 15:00. 
SELECT DISTINCT Name FROM Examinations WHERE DayOfWeek IN (1, 2, 3) AND StartTime >= '12:00' AND EndTime <= '15:00';
--13. ������� �������� � ������ �������� ���������, ������������� � �������� 1, 3, 8 ��� 10.
SELECT D.Name, D.Building
FROM Departments AS D
WHERE D.Building IN (1, 3, 8, 10);
--14. ������� �������� ����������� ���� �������� �������, ����� 1-� � 2-�.
SELECT Name FROM Diseases WHERE Severity NOT IN (1, 2);
--15. ������� �������� ���������, ������� �� ������������� � 1-� ��� 3-� �������.
SELECT Name FROM Departments WHERE Building NOT IN (1, 3);
--16. ������� �������� ���������, ������� ������������� � 1-� ��� 3-� �������.
SELECT Name FROM Departments WHERE Building IN (1, 3);
--17. ������� ������� ������, ������������ �� ����� �N�.
SELECT Surname FROM Doctors WHERE Surname LIKE 'N%';