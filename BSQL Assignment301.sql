CREATE DATABASE EMS
GO	
USE EMS
GO	
-- Create table Employee, Status = 1: are working
CREATE TABLE [dbo].[Employee](
	[EmpNo] [int] NOT NULL
,	[EmpName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[BirthDay] [datetime] NOT NULL
,	[DeptNo] [int] NOT NULL
, 	[MgrNo] [int]
,	[StartDate] [datetime] NOT NULL
,	[Salary] [money] NOT NULL
,	[Status] [int] NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
,	[Level] [int] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE Employee 
ADD CONSTRAINT PK_Emp PRIMARY KEY (EmpNo)
GO

ALTER TABLE [dbo].[Employee]  
ADD  CONSTRAINT [chk_Level] 
	CHECK  (([Level]=(7) OR [Level]=(6) OR [Level]=(5) OR [Level]=(4) OR [Level]=(3) OR [Level]=(2) OR [Level]=(1)))
GO
ALTER TABLE [dbo].[Employee]  
ADD  CONSTRAINT [chk_Status] 
	CHECK  (([Status]=(2) OR [Status]=(1) OR [Status]=(0)))

GO
ALTER TABLE [dbo].[Employee]
ADD Email NCHAR(30) 
GO

ALTER TABLE [dbo].[Employee]
ADD CONSTRAINT chk_Email CHECK (Email IS NOT NULL)
GO

ALTER TABLE [dbo].[Employee] 
ADD CONSTRAINT chk_Email1 UNIQUE(Email)

GO
ALTER TABLE Employee
ADD CONSTRAINT DF_EmpNo DEFAULT 0 FOR EmpNo

GO
ALTER TABLE Employee
ADD CONSTRAINT DF_Status DEFAULT 0 FOR Status

GO
CREATE TABLE [dbo].[Skill](
	[SkillNo] [int] IDENTITY(1,1) NOT NULL
,	[SkillName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Skill
ADD CONSTRAINT PK_Skill PRIMARY KEY (SkillNo)

GO
CREATE TABLE [dbo].[Department](
	[DeptNo] [int] IDENTITY(1,1) NOT NULL
,	[DeptName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Department
ADD CONSTRAINT PK_Dept PRIMARY KEY (DeptNo)

GO
CREATE TABLE [dbo].[Emp_Skill](
	[SkillNo] [int] NOT NULL
,	[EmpNo] [int] NOT NULL
,	[SkillLevel] [int] NOT NULL
,	[RegDate] [datetime] NOT NULL
,	[Description] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT PK_Emp_Skill PRIMARY KEY (SkillNo, EmpNo)
GO

ALTER TABLE Employee  
ADD  CONSTRAINT [FK_1] FOREIGN KEY([DeptNo])
REFERENCES Department (DeptNo)

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT [FK_2] FOREIGN KEY ([EmpNo])
REFERENCES Employee([EmpNo])

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT [FK_3] FOREIGN KEY ([SkillNo])
REFERENCES Skill([SkillNo])

GO

--1. Add at least 8 records into each created tables

INSERT dbo.Department
VALUES	('Dev1', 'Deverloper1'),
		('Dev2', 'Deverloper2'),
		('Dev3', 'Deverloper3'),
		('Dev4', 'Deverloper4'),
		('Dev5', 'Deverloper5'),
		('Dev6', 'Deverloper6'),
		('Dev7', 'Deverloper7'),
		('Dev8', 'Deverloper8')
GO	

INSERT dbo.Employee
VALUES	('201', 'TranVanA1', '1990-02-01', 1, '103','2011-01-01', '5000', '2', 'Tran Van A1', '7', 'a1@fsoft.com.vn'),
		('202', 'TranVanA2', '1991-02-01', 1, '103', '2012-01-01', '5000', '1', 'Tran Van A2', '2', 'a2@fsoft.com.vn'),
		('203', 'TranVanA3', '1992-02-01', 3, '104', '2013-01-01', '4000', '2', 'Tran Van A3', '3', 'a3@fsoft.com.vn'),
		('204', 'TranVanA4', '1993-02-01', 3, '104', '2014-01-01', '3000', '0', 'Tran Van A4', '2', 'a4@fsoft.com.vn'),
		('205', 'TranVanA5', '1994-02-01', 3, '104', '2015-01-01', '1000', '0', 'Tran Van A5', '3', 'a5@fsoft.com.vn'),
		('206', 'TranVanA6', '1995-02-01', 3, '104', '2016-01-01', '2000', '1', 'Tran Van A6', '5', 'a6@fsoft.com.vn'),
		('207', 'TranVanA7', '1996-02-01', 5, '102', '2017-01-01', '3000', '2', 'Tran Van A7', '3', 'a7@fsoft.com.vn'),
		('208', 'TranVanA8', '1997-02-01', 6, '107', '2018-01-01', '5000', '2', 'Tran Van A8', '1', 'a8@fsoft.com.vn')
GO

INSERT	dbo.Skill
VALUES	('C++', ''),
		('.NET', ''),
		('Java', ''),
		('C', ''),
		('Python', ''),
		('JavaScript', ''),
		('DataBase', ''),		
		('Oracle', '')
GO	

INSERT dbo.Emp_Skill
VALUES	(1, '201', 3, '2010-01-01', ''),
		(1, '202', 3, '2011-01-01', ''),
		(2, '203', 3, '2012-01-01', ''),
		(2, '201', 3, '2013-01-01', ''),
		(3, '204', 3, '2014-01-01', ''),
		(5, '205', 3, '2015-01-01', ''),
		(7, '206', 3, '2016-01-01', ''),
		(6, '203', 3, '2017-01-01', '')
GO	
--2. Specify the name, email and department name of the employees that have been working at least six months.

SELECT	EmpName, Email, DeptName
FROM	dbo.Employee, dbo.Department
WHERE	Department.DeptNo = Employee.DeptNo
AND	DATEDIFF(MONTH, StartDate, GETDATE()) >= 6

--3.Specify the names of the employees whore have either ‘C++’ or ‘.NET’ skills

SELECT EmpName FROM dbo.Employee, dbo.Skill, dbo.Emp_Skill
WHERE	Emp_Skill.EmpNo = Employee.EmpNo
AND		Emp_Skill.SkillNo = Skill.SkillNo
AND		(SkillName = 'C++' OR	SkillName = '.NET')
GROUP BY EmpName


--6. List all name, email and number of skills of the employees and sort ascending order by employee’s name.

SELECT EmpName, Email, SkillLevel FROM	dbo.Employee, dbo.Emp_Skill
WHERE	Emp_Skill.EmpNo = Employee.EmpNo
ORDER BY EmpName ASC






