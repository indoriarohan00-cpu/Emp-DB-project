-- Employee Database Project
-- Demonstrates SQL schema creation, data insertion, joins, aggregation, and analysis
-- Author: Rohan Indoria

--  Create the database
CREATE DATABASE EmployeeDB;
USE EmployeeDB;

--  Create tables
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Age INT,
    Salary DECIMAL(10,2),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

CREATE TABLE Projects (
    ProjID INT PRIMARY KEY,
    ProjName VARCHAR(50),
    Budget DECIMAL(12,2)
);

CREATE TABLE EmployeeProjects (
    EmpID INT,
    ProjID INT,
    Role VARCHAR(30),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
    FOREIGN KEY (ProjID) REFERENCES Projects(ProjID)
);

--  Insert sample data
INSERT INTO Departments VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT');

INSERT INTO Employees VALUES
(101, 'Aarav', 28, 55000.00, 3),
(102, 'Sneha', 32, 75000.00, 2),
(103, 'Rohan', 24, 45000.00, 3),
(104, 'Meera', 30, 60000.00, 1);

INSERT INTO Projects VALUES
(501, 'ERP Upgrade', 1200000.00),
(502, 'Payroll Automation', 800000.00);

INSERT INTO EmployeeProjects VALUES
(101, 501, 'Developer'),
(103, 501, 'Tester'),
(102, 502, 'Analyst'),
(104, 502, 'Coordinator');

--  Perform key queries
-- Find employees with salary greater than 50,000
SELECT EmpName, Salary
FROM Employees
WHERE Salary > 50000;

-- Average salary by department
SELECT d.DeptName, AVG(e.Salary) AS AvgSalary
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
GROUP BY d.DeptName;

-- Employees working on each project
SELECT p.ProjName, e.EmpName, ep.Role
FROM EmployeeProjects ep
JOIN Employees e ON ep.EmpID = e.EmpID
JOIN Projects p ON ep.ProjID = p.ProjID
ORDER BY p.ProjName;
