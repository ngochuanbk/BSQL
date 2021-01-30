
-------Question 1---------------
-------CRATE DATABASE EmployeeManagementSystem

CREATE DATABASE EmployeeManagementSystem
GO
USE EmployeeManagementSystem
GO

-------CRATE TABLE EMPLOYEE
CREATE TABLE EMPLOYEE	
(		
	   EmpNO		CHAR(6) PRIMARY KEY NOT NULL,
	   FirstName	VARCHAR(12),
	   LastName		VARCHAR(15),
	   BirthDay		DATE,
	   DeptNo		INT NOT NULL,
	   MgrNo		CHAR(10) NOT NULL,
	   StartDate	DATE,
	   Salary		MONEY,
	   [Level]		TINYINT CONSTRAINT Level_CK CHECK (Level BETWEEN 1 AND	7),
	   [Status]		TINYINT, --0: working, 1: unpaid leave, 2: out
	   Note			TEXT
)
GO	

-------CRATE TABLE SKILL
CREATE TABLE SKILL
(
	SkillNo			INT IDENTITY(1,1) PRIMARY KEY,
	SkillName		VARCHAR(30),
	Note			TEXT
)
GO	


-------CRATE TABLE DEPARTMENT
CREATE TABLE DEPARTMENT
(	
	DeptNo			INT IDENTITY(1,1) PRIMARY KEY,
	DeptName		VARCHAR(30),
	Note			TEXT
)
GO

-------CRATE TABLE EMP_SKILL		
CREATE TABLE EMP_SKILL
(
	SkillNo			INT FOREIGN KEY(SkillNo) REFERENCES dbo.SKILL,
	EmpNO			CHAR(6) FOREIGN KEY(EmpNO) REFERENCES dbo.EMPLOYEE,
	SkillLevel		TINYINT CONSTRAINT SkillLevel_CK CHECK (SkillLevel BETWEEN 1 AND 3),
	RedDate			DATE,
	[Description]	TEXT,
	PRIMARY KEY		(SkillNo, EmpNO)
)
GO	

-------Question 2---------------
--1.Add an Email field to EMPLOYEE table and make sure that the database will not allow 
--the value for Email to be inserted into a new row if that value has already been used in another row

ALTER TABLE dbo.EMPLOYEE
ADD Email varchar(50) UNIQUE

--2. Modify EMPLOYEE table to set default values to 0 of MgrNo and Status fields.

ALTER TABLE dbo.EMPLOYEE
ADD CONSTRAINT DF_MgrNo DEFAULT 0 FOR MgrNo

ALTER TABLE dbo.EMPLOYEE
ADD CONSTRAINT DF_Status DEFAULT 0 FOR Status

-------Question 3---------------
--1. Add the FOREIGN KEY constrain of DeptNo field to the EMPLOYEE table that will relate the DEPARTMENT table.

ALTER TABLE dbo.EMPLOYEE  
ADD  CONSTRAINT FK_DeptNo FOREIGN KEY(DeptNo)
REFERENCES dbo.DEPARTMENT(DeptNo)

--2. Remove the Description field from the EMP_SKILL table

ALTER TABLE dbo.EMP_SKILL
DROP COLUMN Description

-------Question 4---------------
--1. Add at least 5 records into each of the created tables.

INSERT dbo.DEPARTMENT
VALUES		 ('Developer1', '')
			,('Developer2', '')
			,('Developer3', '')
			,('Developer4', '')
			,('Developer5', '')


INSERT dbo.EMPLOYEE
VALUES		 ('FSO001', 'Tran Van', 'A1', '1996-02-01', '1', 'FSO002', '2021-01-01', '5000000', '2', '0', 'Hard working', 'Anhtv1@fsoft.com.vn')
			,('FSO002', 'Tran Van', 'A2', '1995-02-01', '1', 'FSO001', '2020-06-01', '7000000', '4', '0', 'Hard working', 'Anhtv2@fsoft.com.vn')
			,('FSO003', 'Tran Van', 'A3', '1994-02-01', '4', 'FSO002', '2020-03-01', '8000000', '6', '0', 'Hard working', 'Anhtv3@fsoft.com.vn')
			,('FSO004', 'Tran Van', 'A4', '1993-02-01', '4', 'FSO003', '2020-01-01', '6000000', '5', '0', 'Hard working', 'Anhtv4@fsoft.com.vn')
			,('FSO005', 'Tran Van', 'A5', '1992-02-01', '4', 'FSO003', '2019-01-01', '5000000', '4', '0', 'Hard working', 'Anhtv5@fsoft.com.vn')
			,('FSO006', 'Tran Van', 'A6', '1991-02-01', '3', 'FSO007', '2019-03-01', '8000000', '3', '0', 'Hard working', 'Anhtv6@fsoft.com.vn')
			,('FSO007', 'Tran Van', 'A7', '1990-02-01', '4', 'FSO002', '2019-05-01', '15000000', '7', '0', 'Hard working', 'Anhtv7@fsoft.com.vn')
			,('FSO008', 'Tran Van', 'A8', '1997-02-01', '2', 'FSO005', '2020-07-01', '5000000', '2', '0', 'Hard working', 'Anhtv8@fsoft.com.vn')
			,('FSO009', 'Tran Van', 'A9', '1998-02-01', '2', 'FSO005', '2020-04-01', '6000000', '4', '0', 'Hard working', 'Anhtv9@fsoft.com.vn')
			,('FSO010', 'Tran Van', 'A10', '1999-02-01', '2','FSO005', '2020-05-01', '5000000', '1', '0', 'Hard working', 'Anhtv10@fsoft.com.vn')


INSERT 	dbo.SKILL
VALUES	 ('C++', '')
		,('C#', '')
		,('Java', '')
		,('Python', '')
		,('JavaScript', '')

INSERT dbo.EMP_SKILL
VALUES	 ('2', 'FSO001', '2', '2020-03-01')
		,('4', 'FSO003', '1', '2019-06-01')
		,('3', 'FSO003', '2', '2020-06-01')
		,('2', 'FSO004', '3', '2019-03-01')
		,('1', 'FSO004', '1', '2020-04-01')
		,('1', 'FSO005', '2', '2020-05-01')
		,('2', 'FSO006', '2', '2020-06-01')
		,('3', 'FSO006', '2', '2020-01-01')
		,('2', 'FSO007', '3', '2020-02-01')
		,('3', 'FSO007', '2', '2020-07-01')
		,('2', 'FSO008', '1', '2019-03-01')
		,('5', 'FSO009', '2', '2019-08-01')
    

--2. Create a VIEW called EMPLOYEE_TRACKING that will appear to the user 
--as EmpNo, Emp_Name and Level. It has Level satisfied the criteria: Level >=3 and Level <= 5.

CREATE	VIEW EMPLOYEE_TRACKING  AS
SELECT	dbo.EMPLOYEE.DeptNo, dbo.EMPLOYEE.EmpNO, dbo.EMPLOYEE.Level
FROM	dbo.EMPLOYEE
WHERE	dbo.EMPLOYEE.Level BETWEEN 3 AND 5
