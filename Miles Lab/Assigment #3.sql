/* Write a query that returns guests with a birthday before 2000. */
Select 'CREATE TABLE Tavern (' 
Union All
Select CONCAT(COLUMN_NAME, ' ', DATA_TYPE, 
Case When CHARACTER_MAXIMUM_LENGTH > 0 Then
CONCAT(' (', CHARACTER_MAXIMUM_LENGTH, ')') Else Null End
, ',')
From INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Tavern'
Union All 
Select ')';

/* Write a query to return rooms that cost more than 100 gold a night */
Select * From Guest 
Where Birthday < '20000101';

/* Write a query that returns UNIQUE guest names. */
Select distinct FullName from Guest;

/* 5. Write a query that returns all guests ordered by name (ascending) */
Select * from Guest 
Order By FullName Asc;

/* Write a query that returns the top 10 highest price sales */
Select Top 10 * from Sale 
Order By Price desc;

/* Write a query to return all the values stored in all Lookup Tables */
Select b.FullName, c.Name, a.Level from GuestCLass as a
Join Guest as b
On a.GuestID = b.ID
Join Class as c
On a.ClassID = c.ID;

/*  Write a query that returns Guest Classes with Levels and Generate a new column with a label for their level grouping (lvl 1-10, 10-20, etc) */
Select GuestID, 
Case When Level > 0 and Level < 11 Then 'lvl 1-10'
When Level > 10 and Level < 21 Then  'lvl 11-20'
When Level > 20 and Level < 31 Then  'lvl 21-30'
When Level > 30 and Level < 41 Then  'lvl 31-40'
When Level > 40 and Level < 51 Then  'lvl 41-50'
When Level > 50 and Level < 61 Then  'lvl 51-60'
When Level > 60 and Level < 71 Then  'lvl 61-70'
When Level > 70 and Level < 81 Then  'lvl 71-80'
When Level > 80 and Level < 91 Then  'lvl 81-90'
When Level > 90 and Level < 100 Then  'lvl 91-99'
 Else 'Err' End  as LevelGroup From GuestClass 
Order By Level;

/* Write a series of INSERT commands */
Select 'INSERT INTO (' 
UNION All Select CONCAT(COLUMN_NAME,
Case When ORDINAL_POSITION = (select COUNT(*)From INFORMATION_SCHEMA.COLUMNS Where TABLE_NAME = 'Guest')  Then Null Else ',' End
) From INFORMATION_SCHEMA.COLUMNS
Where TABLE_NAME = 'Guest'
UNION All Select ') VALUES ('
UNION All Select CONCAT('''Name 1'',','''None'',', '''20000303'',', '''20160101'',', GuestStatus.ID, '),') From GuestStatus;


