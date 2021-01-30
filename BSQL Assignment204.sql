-- -----Build database Movie Collection
-------------Q1. Create tables

--1.Create table Movie
CREATE DATABASE MovieCollection
GO
USE MovieCollection
GO
CREATE TABLE Movie
(
	MovieID VARCHAR(10) PRIMARY KEY,
	MovieName VARCHAR(30) NOT NULL,
	Duration INT CONSTRAINT CK_Duration CHECK(Duration >= 1) NOT NULL,
	Director VARCHAR(30) NOT NULL,
	Profit MONEY NOT NULL
)
GO
CREATE TABLE Actor
(
	ActorID VARCHAR(10) PRIMARY KEY,
	ActorName VARCHAR(30) NOT NULL,	
	BirthDay DATE NOT NULL,
	Average MONEY NOT NULL
)
GO
CREATE TABLE Movie_Cast
(
	ActorID VARCHAR(10) FOREIGN KEY(ActorID) REFERENCES dbo.Actor,
	MovieID VARCHAR(10) FOREIGN KEY(MovieID) REFERENCES dbo.Movie,
	Role VARCHAR(30) NOT NULL,
	PRIMARY KEY(ActorID, MovieID)
)

-------------Q2.Populate tables
--1.ADD an ImageLink field to Movie table and make sure that the database
-- will not allow the value for ImageLink to be inserted into a new row 
--if that value has already been used in another row

ALTER TABLE dbo.Movie 
ADD ImageLink VARCHAR(100) UNIQUE

--2.Populate your tables with some data using the INSERT statement. 
--Make sure you have at least 5 tuples per table
INSERT dbo.Movie     
VALUES	('101', 'Hunter1', 3, 'Michael1', 5000, 'https1'),
		('102', 'Hunter2', 2, 'Michael2', 6000, 'https2'),
		('103', 'Hunter3', 4, 'Michael3', 7000, 'https3'),
		('104', 'Hunter4', 1, 'Michael4', 4000, 'https4'),
		('105', 'Hunter5', 5, 'Michael5', 3000, 'https5')
GO

INSERT dbo.Actor
VALUES	('001', 'Peter1', '1990-01-01', 200),
		('002', 'Peter2', '1950-01-01', 400),
		('003', 'Peter3', '1960-01-01', 200),
		('004', 'Peter4', '1970-01-01', 400),
		('005', 'Peter5', '1980-01-01', 200)
GO

INSERT dbo.Movie_Cast
VALUES	('001', '101', 'main actor 1'),
		('002', '102', 'main actor 2'),
		('003', '103', 'main actor 3'),
		('004', '104', 'main actor 4'),
		('005', '105', 'main actor 5')
GO	

-- Update ActorName
UPDATE dbo.Actor
SET ActorName = 'Peter88'
WHERE ActorName = 'Peter5'
GO
------------Q3. Query tables
--1.Write a query to retrieve all the data in the Actor table for actors that are older than 50.

SELECT*FROM dbo.Actor
WHERE (YEAR(GETDATE()) - YEAR(BirthDay)) > 50

--2.Write a query to retrieve all actor names and average salaries 

SELECT ActorName, Average FROM	dbo.Actor
GO	
--3.Using an actor name from your table, write a query to retrieve the names of all the movies that the actor has acted in
SELECT	MovieName	 FROM dbo.Movie
JOIN	dbo.Movie_Cast
ON		Movie_Cast.MovieID = Movie.MovieID





