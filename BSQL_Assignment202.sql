
-----CREATE DATABASE FresherTrainingManagement
CREATE DATABASE FresherTrainingManagement
GO	
USE	FresherTrainingmanagement
GO	

--1. Create the tables (with the most appropriate/economic field/column constraints & types) 
--   and add at least 10 records into each created table.

CREATE TABLE Trainee 
(
	TraineeID		INT	NOT NULL IDENTITY(1,1) PRIMARY KEY,
	FullName		VARCHAR(30) NOT NULL,
	BirthDay		DATE	NOT NULL,
	Gender			BIT NOT NULL, ----(1. male, 2.female)
	ET_IQ			TINYINT	NOT NULL CONSTRAINT CHK_ET_IQ CHECK(ET_IQ BETWEEN 0 AND 20),
	ET_Gmath		TINYINT	NOT NULL CONSTRAINT CHK_ET_Gmath CHECK(ET_Gmath BETWEEN 0 AND 20),
	ET_English		TINYINT	NOT NULL CONSTRAINT CHK_English CHECK(ET_English BETWEEN 0 AND 50),
	TrainingClass	VARCHAR(10) NOT NULL,
	EvalutionNote	TEXT	NOT NULL	
)

INSERT Trainee
VALUES	 ('Tran Van A1', '1990-01-01', '1', '5', '8', '15', 'FSOHN001', 'Good')
		,('Tran Van A2', '1991-01-01', '2', '15','8', '30', 'FSOHN001', 'Good')
		,('Tran Van A3', '1992-01-01', '2', '15','18', '30', 'FSOHN002', 'Good')
		,('Tran Van A4', '1993-01-01', '1', '8', '18', '30', 'FSOHN002', 'Good')
		,('Tran Van A5', '1994-01-01', '1', '5', '8',  '25', 'FSOHN002', 'Good')
		,('Tran Van A6', '1995-01-01', '1', '20','10', '25', 'FSOHN001', 'Good')
		,('Tran Van A7', '1996-01-01', '2', '5', '8', '25', 'FSOHN001', 'Good')
		,('Tran Van A8', '1997-01-01', '1', '5', '5', '25', 'FSOHN002', 'Good')
		,('Tran Van A9', '1998-01-01', '2', '10','20', '15', 'FSOHN002', 'Good')
		,('Tran Van A10','1999-01-01', '1', '5', '8', '15', 'FSOHN001', 'Good')
 
 --2. Change the table TRAINEE to add one more field named Fsoft_Account which is a not-null & unique field.

 ALTER TABLE Trainee
ADD Fsoft_Account CHAR(20) NOT NULL UNIQUE

--3. Create a VIEW that includes all the ET-passed trainees. 
--  One trainee is considered as ET-passed when he/she has the entry test points satisfied below criteria:

CREATE VIEW	ET_Passed_Trainees AS
SELECT		TraineeID, FullNane, BirthDay, Gender
FROM		Trainee
WHERE ET_IQ + ET_Gmath >= 20
 AND ET_IQ >= 8 
 AND ET_Gmath >= 8 
 AND ET_English >= 18

CREATE	VIEW ET_Passed_Trainees  AS
SELECT	TraineeID, FullName, BirthDay, Gender
FROM	Trainee
WHERE ET_IQ + ET_Gmath >= 20
AND ET_IQ >= 8 
AND ET_Gmath >= 8 
AND ET_English >= 18

--4. Query all the trainees who are passed the entry test, group them into different birth months.

SELECT	TraineeID, FullName, BirthDay
FROM	Trainee
WHERE ET_IQ + ET_Gmath >= 20
AND ET_IQ >= 8 
AND ET_Gmath >= 8 
AND ET_English >= 18
ORDER BY MONTH(BirthDay)

--5. Query the trainee who has the longest name, showing his/her age along with his/her basic information (as defined in the table).

SELECT	TraineeID, FullName, BirthDay,
		YEAR(GETDATE()) - YEAR(BirthDay) AS Age, Gender
FROM	Trainee
WHERE	LEN(FullName) = (SELECT MAX(LEN(FullName)) FROM Trainee)


