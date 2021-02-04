/************************************************************/
/* Author:          Tue Doan                                */
/* Creation Date:   Jan 30, 2021                            */
/* Due Date:        Feb 01, 2021                            */
/* Course:          Miles Training Lab                      */
/* Assignment:      #4                                      */
/* Filename:        Assignment #4.sql                       */
/* Purpose: Write a series of queries as described in the   */
/*			header.											*/
/************************************************************/

/* Write a query to return users who have admin roles */
SELECT u.FullName, r.Name AS Role FROM Users AS u
JOIN Roles AS r
ON u.RolesID = r.ID 
WHERE r.Name = 'Admin';

/* Write a query to return users who have admin roles and information about their taverns */
SELECT usr.FullName, rol.Name AS Role, tav.Name AS TavernName, inv.ID AS InventoryID, loc.Name AS Location FROM Users AS usr
JOIN Roles AS rol
ON usr.RolesID = rol.ID
JOIN Tavern AS tav
ON usr.TavernID = tav.ID
JOIN Inventory AS inv 
ON tav.InventoryID = inv.ID
JOIN Locations AS loc
ON tav.LocationsID = loc.ID
WHERE rol.Name = 'Admin';

/* Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels */
SELECT gue.FullName, Cls.Name, Guc.Level FROM Guest AS gue
JOIN GuestClass AS Guc
ON gue.ID = Guc.ClassID 
JOIN Class AS Cls
ON Guc.ClassID = Cls.ID
ORDER BY gue.FullName ASC;

/* Write a query that returns the top 10 sales in terms of sales price and what the services were */
SELECT TOP 10 sal.ID, sal.Price, ser.Name FROM Sale AS sal
JOIN Services AS ser
ON sal.ServicesID = ser.ID
ORDER BY Price DESC;

/* Write a query that returns guests with 2 or more classes */
SELECT GuestID ClassCount FROM GuestClass
GROUP BY GuestID
HAVING COUNT(*) > 1; 

/* Write a query that returns guests with 2 or more classes with levels higher than 5 */
SELECT GuestID FROM GuestClass
WHERE Level > 5
GROUP BY GuestID
HAVING COUNT(*) > 1;

/*SELECT GuestID, COUNT(*) ClassCount FROM GuestClass
WHERE Level > 5
GROUP BY GuestID
HAVING COUNT(*) > 1; */

/* Write a query that returns guests with ONLY their highest level class */
SELECT DISTINCT GuestID, MAX(Level) FROM GuestClass
GROUP BY GuestID;

/* Write a query that returns guests that stay within a date range. */
SELECT * FROM RoomStay
WHERE StayDate BETWEEN '20210101' AND '20210130';

/* Using the additional queries provided, take the lab’s SELECT ‘CREATE query’ and add any IDENTITY and PRIMARY KEY constraints to it.*/
SELECT 
CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as queryPiece 
FROM INFORMATION_SCHEMA.TABLES
 WHERE TABLE_NAME = 'Tavern'
UNION ALL
SELECT CONCAT(cols.COLUMN_NAME, ' ' ,cols.DATA_TYPE, 
(	CASE WHEN sysOC.is_identity = 1 AND cols.COLUMN_NAME = sysOC.ColumName
	Then 
		' IDENTITY '
	Else '' 
	END 
),
(
	CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL 
	Then CONCAT
		('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')') 
	Else '' 
	END)
, 
	CASE WHEN refConst.CONSTRAINT_NAME IS NOT NULL
	Then 
		(CONCAT(' FOREIGN KEY REFERENCES ', constKeys.TABLE_NAME, '(', constKeys.COLUMN_NAME, ')')) 
	Else '' 
	END
,
	CASE WHEN refConst.CONSTRAINT_NAME IS NULL AND keys.COLUMN_NAME IS NOT NULL
	Then 
		' PRIMARY KEY'
	Else '' 
	END
, 
',') as queryPiece FROM 
INFORMATION_SCHEMA.COLUMNS as cols
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as keys ON 
(keys.TABLE_NAME = cols.TABLE_NAME and keys.COLUMN_NAME = cols.COLUMN_NAME)
LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as refConst ON 
(refConst.CONSTRAINT_NAME = keys.CONSTRAINT_NAME)
LEFT JOIN 
(SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE) as constKeys 
ON (constKeys.CONSTRAINT_NAME = refConst.UNIQUE_CONSTRAINT_NAME)

LEFT JOIN (select DISTINCT sysCol.is_identity, sysObj.name, sysCol.name as ColumName
from sys.objects sysObj 
join sys.columns sysCol on sysObj.object_id = sysCol.object_id
WHERE sysObj.name = 'Tavern' AND sysCol.is_identity = 1) as sysOC
ON sysOC.name = cols.TABLE_NAME

 WHERE cols.TABLE_NAME = 'Tavern'
UNION ALL
SELECT ')'; 
















