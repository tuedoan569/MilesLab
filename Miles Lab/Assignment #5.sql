/************************************************************/
/* Author:          Tue Doan                                */
/* Creation Date:   Feb 01, 2021                            */
/* Due Date:        Feb 04, 2021                            */
/* Course:          Miles Training Lab                      */
/* Assignment:      #5                                      */
/* Filename:        Assignment #5.sql                       */
/* Purpose: Write a series of queries as described in the   */
/*			header.											*/
/************************************************************/

/*  Write a query to return a “report” of all users and their roles */
SELECT u.FullName, t.Name, r.Name FROM Users u
JOIN Tavern t
ON u.TavernID = t.ID
JOIN Roles r
ON u.RolesID = r.ID;

/* Write a query to return all classes and the count of guests that hold those classes */
SELECT c.Name, COUNT(gc.ClassID) ClassCount FROM Class c
LEFT JOIN GuestClass gc 
ON c.ID = gc.ClassID
GROUP BY c.Name
HAVING COUNT(*) >= 0; 

/* Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels */
SELECT g.FullName, c.Name, gc.Level,
	CASE WHEN gc.Level >= 1 AND gc.Level < 6 THEN 'Beginner'
	WHEN gc.Level >= 5 AND gc.Level < 11 THEN 'Intermediate'
	WHEN gc.Level >= 11 THEN 'Expert'
	ELSE 'err' END AS LevelGroup 
FROM Guest g
JOIN GuestClass gc
ON g.ID = gc.GuestID
JOIN Class c
ON gc.ClassID = c.ID
ORDER BY g.FullName ASC;

/* Write a function that takes a level and returns a “grouping” from question 3 */

IF OBJECT_ID(N'dbo.getGrouping', N'FN') IS NOT NULL
	DROP FUNCTION getGrouping;
GO
CREATE FUNCTION dbo.getGrouping(@Level INT)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @LevelGroup VARCHAR(20);
	SELECT @LevelGroup  = CASE 
	WHEN @Level >= 1 AND @Level < 6 THEN  'Beginner'
	WHEN @Level >= 5 AND @Level < 11 THEN   'Intermediate'
	WHEN @Level >= 11 THEN   'Expert'
	ELSE  'err' END 
	RETURN @LevelGroup;
END

SELECT g.FullName, c.Name, gc.Level, dbo.getGrouping(gc.Level) LevelGrouping
FROM Guest g
JOIN GuestClass gc
ON g.ID = gc.GuestID
JOIN Class c
ON gc.ClassID = c.ID
ORDER BY g.FullName ASC;

/* Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to */
IF OBJECT_ID(N'dbo.getOpenRoom', N'IF') IS NOT NULL
	DROP FUNCTION getOpenRoom;
GO 
CREATE FUNCTION dbo.getOpenRoom(@openDate DATE)
RETURNS TABLE 
AS 
RETURN (
	SELECT ra.ID, rs.Name RoomAvailability, t.Name TaverenName FROM RoomAvail ra
	JOIN Room r
	ON ra.RoomID = r.ID
	JOIN Tavern t
	ON r.TavernID = t.ID
	JOIN RoomStatus rs
	On Ra.RoomStatusID = rs.ID
	WHERE CurrentDate = @openDate AND RoomStatusID = 2
);

SELECT * FROM getOpenRoom('20210101');

/* Modify the same function from 5 to instead return a report of prices in a range (min and max prices) - Return Rooms and their taverns based on price inputs */
IF OBJECT_ID(N'dbo.findRoom', N'IF') IS NOT NULL
	DROP FUNCTION findRoom;
GO 
CREATE FUNCTION dbo.findRoom(@min INT, @max INT)
RETURNS TABLE 
AS 
RETURN (
	SELECT r.ID, t.Name, Rate FROM RoomStay rs
	JOIN RoomAvail ra 
	ON rs.RoomAvailID = ra.ID
	JOIN Room r
	ON ra.RoomID = r.ID
	JOIN Tavern t
	ON r.TavernID = t.ID
	WHERE rs.Rate >= @min AND rs.Rate <= @max
);

SELECT * FROM findRoom(9, 10);

/* Write a command that uses the result from 6 to Create a Room in another tavern that undercuts (is less than) the cheapest room by a penny - thereby making the new room the cheapest one */
Select 'INSERT INTO RoomStay (' 
UNION All Select CONCAT(COLUMN_NAME,
Case When ORDINAL_POSITION = (select COUNT(*)From INFORMATION_SCHEMA.COLUMNS Where TABLE_NAME = 'RoomStay')  Then Null Else ',' End
) From INFORMATION_SCHEMA.COLUMNS
Where TABLE_NAME = 'RoomStay'
UNION All Select ') VALUES ('
UNION All Select CONCAT(10 ,',', 10, ',', 9, ',', 5, ',', '''20210110''', ',', (
SELECT  MIN(CAST (Rate AS NUMERIC)) - 0.01 FROM findRoom(9, 10)), ');')

UNION ALL 

Select 'INSERT INTO Room (' 
UNION All Select CONCAT(COLUMN_NAME,
Case When ORDINAL_POSITION = (select COUNT(*)From INFORMATION_SCHEMA.COLUMNS Where TABLE_NAME = 'Room')  Then Null Else ',' End
) From INFORMATION_SCHEMA.COLUMNS
Where TABLE_NAME = 'Room'
UNION All Select ') VALUES ('
UNION All Select CONCAT(10 ,',', 2, ');')

UNION ALL 

Select 'INSERT INTO RoomAvail (' 
UNION All Select CONCAT(COLUMN_NAME,
Case When ORDINAL_POSITION = (select COUNT(*)From INFORMATION_SCHEMA.COLUMNS Where TABLE_NAME = 'RoomAvail')  Then Null Else ',' End
) From INFORMATION_SCHEMA.COLUMNS
Where TABLE_NAME = 'RoomAvail'
UNION All Select ') VALUES ('
UNION All Select CONCAT(20 ,',',10 ,',', 2, ',', GETDATE(), ');');












