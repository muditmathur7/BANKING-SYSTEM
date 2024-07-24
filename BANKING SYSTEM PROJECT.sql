-- Create the bank database
CREATE DATABASE bank;

-- Use the bank database
USE bank;

-- Create BranchTable
CREATE TABLE BranchTable (
    Id INT NOT NULL IDENTITY(1,1),
    Name NVARCHAR(120) NOT NULL,
    BCode NVARCHAR(15) NOT NULL UNIQUE,
    Address NVARCHAR(200) NOT NULL,
    PRIMARY KEY (Id)
);
GO

-- Create EmployeeTable
CREATE TABLE EmployeeTable (
    Id INT NOT NULL IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Branch NVARCHAR(15) NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Branch) REFERENCES BranchTable(BCode)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

-- Create AccountTable
CREATE TABLE AccountTable (
    Id INT NOT NULL IDENTITY(1,1),
    Account_Number NVARCHAR(15) NOT NULL UNIQUE,
    Account_Type NVARCHAR(15) NOT NULL,
    BCode NVARCHAR(15) NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Gender NVARCHAR(10) NOT NULL,
    DOB DATE,
    Address NVARCHAR(50) NOT NULL,
    Aadhar NVARCHAR(12) NOT NULL,
    Balance FLOAT NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (BCode) REFERENCES BranchTable(BCode)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

-- Create TransactionTable
CREATE TABLE TransactionTable (
    Id INT NOT NULL IDENTITY(1,1),
    Date DATE NOT NULL,
    Account_Num NVARCHAR(15),
    Transaction_Type NVARCHAR(15),
    Amount FLOAT,
    PRIMARY KEY (Id),
    FOREIGN KEY (Account_Num) REFERENCES AccountTable(Account_Number)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

-- Create ServiceTable
CREATE TABLE ServiceTable (
    Id INT NOT NULL IDENTITY(1,1),
    Date DATE NOT NULL,
    Account_Num NVARCHAR(15),
    ServiceName NVARCHAR(100),
    Description NVARCHAR(200),
    Amount FLOAT,
    TransactionId INT NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (TransactionId) REFERENCES TransactionTable(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

-- Disable foreign key constraints
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT all';
GO

-- Truncate tables
DELETE FROM BranchTable;
DELETE FROM EmployeeTable;
DELETE FROM AccountTable;
DELETE FROM TransactionTable;
DELETE FROM ServiceTable;
GO

-- Enable foreign key constraints
EXEC sp_MSforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all';
GO
