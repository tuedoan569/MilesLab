/************************************************************/
/* Author:          Tue Doan                                */
/* Creation Date:   Jan 13, 2021                            */
/* Due Date:        Jan 14, 2021                            */
/* Course:          Miles Training Lab                      */
/* Assignment:      #1                                      */
/* Filename:        inventory.sql                           */
/* Purpose: This script for keeping track of supply and sale*/
/************************************************************/

/* Drop tables in order opposite of constraints */
DROP TABLE IF EXISTS SuppliesSale;
DROP TABLE IF EXISTS RoomStay;
DROP TABLE IF EXISTS RoomAvail;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Sale;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Tavern;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Supply;

DROP TABLE IF EXISTS Roles;

DROP TABLE IF EXISTS GuestClass;
DROP TABLE IF EXISTS Guest;
DROP TABLE IF EXISTS ServiceStatus;
DROP TABLE IF EXISTS Services;

DROP TABLE IF EXISTS RoomStatus;

DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Received;
DROP TABLE IF EXISTS Product;

DROP TABLE IF EXISTS GuestStatus;
DROP TABLE IF EXISTS Class;

/* Create tables */

CREATE TABLE Locations (
    ID INT IDENTITY(1, 1) NOT NULL,
    Name VARCHAR(250) NOT NULL
)

CREATE TABLE Product (
    ID INT IDENTITY(1, 1) NOT NULL,
    Name VARCHAR(250) NOT NULL,
    Unit VARCHAR(50) NOT NULL
)

CREATE TABLE Supply (
    ID INT IDENTITY(1, 1) NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL
)

CREATE TABLE Received (
    ID INT IDENTITY(1, 1) NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    DateReceived DATE NOT NULL
)

CREATE TABLE Inventory (
    ID INT IDENTITY(1, 1) NOT NULL,
    SupplyID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    ReceivedID INT NOT NULL
)

CREATE TABLE Users (
    ID INT IDENTITY(1, 1) NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    TavernID INT NOT NULL,
    RolesID INT NOT NULL
)

CREATE TABLE Roles (
    ID INT IDENTITY(1, 1) NOT NULL,
    Name VARCHAR (50) NOT NULL
)

CREATE TABLE Tavern (
    ID INT IDENTITY(1, 1) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    InventoryID INT NOT NULL,
    LocationsID INT NOT NULL
)

CREATE TABLE Orders (
    ID INT IDENTITY(1, 1) NOT NULL,
    SupplyID INT NOT NULL,
    TavernID INT NOT NULL,
    Cost DEC NOT NULL,
    AmountReceived INT NOT NULL,
    ReceivedID INT NOT NULL
)

CREATE TABLE ServiceStatus (
    ID INT IDENTITY(1, 1) NOT NULL,
    Name VARCHAR(50) NOT NULL
)

CREATE TABLE Services (
    ID INT IDENTITY(1, 1) NOT NULL,
    Name VARCHAR(50) NOT NULL
)

CREATE TABLE RoomStay (
    ID INT IDENTITY(1, 1) NOT NULL,
    SaleID INT NOT NULL, 
    GuestID INT NOT NULL,
    RoomAvailID INT NOT NULL,
    StayDate DATE NOT NULL,
    Rate DEC NOT NULL
)

CREATE TABLE RoomAvail (
    ID INT IDENTITY(1, 1) NOT NULL,
    RoomID INT NOT NULL,
    RoomStatusID INT NOT NULL,
    CurrentDate DATE NOT NULL
)

CREATE TABLE Room (
    ID INT IDENTITY(1, 1) NOT NULL,
    TavernID INT NOT NULL,
)

CREATE TABLE RoomStatus (
    ID INT IDENTITY(1, 1) NOT NULL,
    Name VARCHAR(20) NOT NULL
)

CREATE TABLE GuestStatus (
    ID INT IDENTITY(1, 1) NOT NULL,
    Name VARCHAR(50) NOT NULL
)

CREATE TABLE Guest (
    ID INT IDENTITY(1, 1) NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    Note VARCHAR(500) NOT NULL,
    Birthday DATE NOT NULL,
    Cakeday DATE NOT NULL,
    GuestStatusID INT NOT NULL
)

CREATE TABLE Class (
    ID INT IDENTITY(1, 1) NOT NULL,
    Name VARCHAR(100) NOT NULL
)

CREATE TABLE GuestClass (
    GuestID INT NOT NULL, 
    ClassID INT NOT NULL,
    Level INT NOT NULL
)

CREATE TABLE Sale (
    ID INT IDENTITY(1, 1) NOT NULL,
    GuestID INT NOT NULL,
    TavernID INT NOT NULL,
    ServicesID INT NOT NULL,
    ServiceStatusID INT NOT NULL,
    Price DEC NOT NULL,
    AmountPurchased INT NOT NULL,
    DatePurchased DATE NOT NULL
)

CREATE TABLE SuppliesSale (
    ID INT IDENTITY(1, 1) NOT NULL,
    InventoryID INT NOT NULL,
    SaleID INT NOT NULL, 
    ProductID INT NOT NULL, 
    Quantity INT NOT NULL
)

/* Add Primary Key to Tables */
GO

ALTER TABLE Class 
ADD PRIMARY KEY (ID);

ALTER TABLE GuestStatus 
ADD PRIMARY KEY (ID);

ALTER TABLE Received 
ADD PRIMARY KEY (ID);

ALTER TABLE Product 
ADD PRIMARY KEY (ID);

ALTER TABLE Locations
ADD PRIMARY KEY (ID);

ALTER TABLE Services
ADD PRIMARY KEY (ID);

ALTER TABLE ServiceStatus
ADD PRIMARY KEY (ID);

ALTER TABLE RoomStay
ADD PRIMARY KEY (ID);

ALTER TABLE RoomAvail
ADD PRIMARY KEY (ID);

ALTER TABLE Room
ADD PRIMARY KEY (ID);

ALTER TABLE RoomStatus
ADD PRIMARY KEY (ID);

ALTER TABLE GuestClass
ADD PRIMARY KEY (GuestID, ClassID);

ALTER TABLE Guest
ADD PRIMARY KEY (ID);

ALTER TABLE Supply
ADD PRIMARY KEY (ID);

ALTER TABLE Inventory 
ADD PRIMARY KEY (ID);

ALTER TABLE Users 
ADD PRIMARY KEY (ID);

ALTER TABLE Roles
ADD PRIMARY KEY (ID);

ALTER TABLE Tavern 
ADD PRIMARY KEY (ID);

ALTER TABLE Orders
ADD PRIMARY KEY (ID);

ALTER TABLE Sale
ADD PRIMARY KEY (ID);

ALTER TABLE SuppliesSale
ADD PRIMARY KEY (ID);


/* Add Constraints/Foreign Key */

ALTER TABLE Supply 
ADD CONSTRAINT FK_Supply_ProductID 
FOREIGN KEY (ProductID) REFERENCES Product(ID);

ALTER TABLE Inventory 
ADD CONSTRAINT FK_Inventory_SupplyID 
FOREIGN KEY (SupplyID) REFERENCES Supply(ID),
CONSTRAINT FK_Inventory_ProductID 
FOREIGN KEY (ProductID) REFERENCES Product(ID),
CONSTRAINT FK_Inventory_ReceivedID
FOREIGN KEY (ReceivedID) REFERENCES Received(ID);

ALTER TABLE Users
ADD CONSTRAINT FK_Users_TavernID 
FOREIGN KEY (TavernID) REFERENCES Tavern(ID),
CONSTRAINT FK_Users_RolesID 
FOREIGN KEY (RolesID) REFERENCES ROles(ID);

ALTER TABLE Tavern 
ADD CONSTRAINT FK_Tavern_InventoryID 
FOREIGN KEY (InventoryID) REFERENCES Inventory(ID),
CONSTRAINT FK_Tavern_LocationsID 
FOREIGN KEY (LocationsID) REFERENCES Locations(ID);

ALTER TABLE RoomAvail 
ADD CONSTRAINT FK_RoomAvail_RoomID 
FOREIGN KEY (RoomID) REFERENCES Room(ID),
CONSTRAINT FK_RoomAvail_RoomStatusID
FOREIGN KEY (RoomStatusID) REFERENCES RoomStatus(ID);

ALTER TABLE Orders 
ADD CONSTRAINT FK_Orders_SupplyID
FOREIGN KEY (SupplyID) REFERENCES Supply(ID),
CONSTRAINT FK_Orders_TavernID 
FOREIGN KEY (TavernID) REFERENCES Tavern(ID),
CONSTRAINT FK_Orders_ReceivedID
FOREIGN KEY (ReceivedID) REFERENCES Received(ID);

ALTER TABLE Received 
ADD CONSTRAINT FK_Received_ProductID
FOREIGN KEY (ProductID) REFERENCES Product(ID);

ALTER TABLE Sale 
ADD CONSTRAINT FK_Sale_GuestID
FOREIGN KEY (GuestID) REFERENCES Guest(ID),
CONSTRAINT FK_Sale_TavernID 
FOREIGN KEY (TavernID) REFERENCES Tavern(ID),
CONSTRAINT FK_Sale_ServicesID 
FOREIGN KEY (ServicesID) REFERENCES Services(ID),
CONSTRAINT FK_Sale_ServiceStatusID 
FOREIGN KEY (ServiceStatusID) REFERENCES ServiceStatus(ID);

ALTER TABLE Guest 
ADD CONSTRAINT FK_Guest_GuestStatusID 
FOREIGN KEY (GuestStatusID) REFERENCES GuestStatus(ID);

ALTER TABLE GuestCLass 
ADD CONSTRAINT FK_GuestClass_GuestID
FOREIGN KEY (GuestID) REFERENCES Guest(ID),
CONSTRAINT FK_GuestClass_ClassID
FOREIGN KEY (ClassID) REFERENCES Class(ID);

ALTER TABLE RoomStay
ADD CONSTRAINT FK_RoomStay_SaleID
FOREIGN KEY (SaleID) REFERENCES Sale(ID),
CONSTRAINT FK_RoomStay_GuestID
FOREIGN KEY (GuestID) REFERENCES Guest(ID),
CONSTRAINT FK_RoomStay_RoomAvailID
FOREIGN KEY (RoomAvailID) REFERENCES RoomAvail(ID);

ALTER TABLE SuppliesSale 
ADD CONSTRAINT FK_SuppliesSale_InventoryID
FOREIGN KEY (InventoryID) REFERENCES Inventory(ID),
CONSTRAINT FK_SuppliesSale_SaleID 
FOREIGN KEY (SaleID) REFERENCES Sale(ID),
CONSTRAINT FK_SuppliesSale_ProductID
FOREIGN KEY (ProductID) REFERENCES Product(ID);

GO


/* Insert Data to tables */ 

INSERT INTO Locations(Name)
VALUES ('33 Coffee Avenue, Mechanicsville, VA 23111'),
('380 Glenwood St., Phoenix, AZ 85021'),
('63 Oxford Avenue, North Olmsted, OH 44070'),
('501 West Constitution Court, Westbury, NY 11590'),
('7931 Big Rock Cove St., Howell, NJ 07731'),
('1234 6th St., Marquette, MI 49855'),
('7619 Main Dr., Windsor Mill, MD 21244'),
('77 53rd Ave., Amityville, NY 11701'),
('9124 Woodland St., Bristol, CT 06010'),
('348 Vale Lane, Oakland Gardens, NY 11364');

INSERT INTO Product(Name, Unit) 
VALUES ('Rosemary Pear', 'ounce'),
('Minneapolis', 'ounce'),
('Hawaiian Mule', 'ounce'),
('Bluebeery Pomegranate', 'ounce'),
('Peanut Butter Bulldog', 'ounce'),
('Blackberry Long Island', 'ounce');

INSERT INTO Supply(ProductID, Quantity)
VALUES (1, 12),
(2, 20),
(2, 49),
(3, 50),
(2, 11),
(4, 60),
(6, 100);

INSERT INTO Received (ProductID, Quantity, DateReceived)
VALUES (1, 12, '20210112'),
(2, 20, '20210111'),
(2, 49, '20210110'),
(3, 50, '20210109'),
(2, 11, '20210108'),
(4, 60, '20210107'),
(6, 100, '20210103');

INSERT INTO Inventory (SupplyID, ProductID, Quantity, ReceivedID)
VALUES (1, 1, 12, 1),
(2, 2, 20, 2),
(3, 2, 49, 3),
(4, 3, 50, 4),
(5, 2, 11, 4),
(6, 4, 60, 5);

INSERT INTO Roles (Name) 
VALUES ('Admin'),
('Owner'),
('Manager'),
('IT');


INSERT INTO Tavern(Name, InventoryID, LocationsID) 
VALUES ('Tavern1', 1, 1),
('Tavern2', 1, 2),
('Tavern3', 2, 3),
('Tavern4', 3, 4),
('Tavern5', 2, 5),
('Tavern6', 3, 6),
('Tavern7', 3, 7),
('Tavern8', 1, 8);

INSERT INTO Users (FullName, TavernID, RolesID)
VALUES ('Rose Davis', 1, 1),
('Latoya Moore', 1, 1),
('Maria Lewis', 1, 2),
('Eric Vaughn', 1, 3),
('Stuart Gray', 1, 4),
('Sean Kelly', 1, 4),
('Shannon Peterson', 1, 4);


INSERT INTO ServiceStatus (Name)
VALUES ('Active'),
('Inactive'),
('Out of Stock'),
('Discontinued');

INSERT INTO Services (Name) 
VALUES ('Pool'),
('Weapon Sharpening'),
('Dart');

INSERT INTO GuestStatus (Name)
VALUES ('Sick'),
('Fine'),
('Hangry'),
('Raging'),
('Placid');

INSERT INTO Class (Name)
VALUES ('Fighter'),
('Mage'),
('Archer'),
('Swordman'),
('Summoner'),
('Assassin'),
('Enchanter');

INSERT  INTO Guest(FullName, Note, Birthday, Cakeday, GuestStatusID) 
VALUES ('Santos Vaughn', 'None', '19700102', '20100404', 1),
('Domingo Keller', 'None', '19730302', '20110404', 3),
('Cary Fox', 'None', '19711122', '20130404', 2),
('Elijah Sandoval', 'None', '19800115', '20130502', 2),
('Elisa Schmidt', 'None', '19901222', '20151104', 2),
('Charlie West', 'None', '19990909', '20200401', 2),
('Mabel Nelson', 'None', '20000810', '20120101', 4),
('Wanda Palmer', 'None', '19850605', '20171204', 5),
('Taylor Clark', 'None', '20020419', '20160809', 2),
('Taylor Clark', 'None', '19980429', '20150209', 2);

INSERT INTO GuestClass(GuestID, ClassID, Level)
VALUES (1, 1, 1),
(1, 3, 99),
(2, 2, 50),
(2, 3, 11),
(2, 4, 60),
(3, 3, 30),
(4, 3, 15),
(5, 2, 19);

INSERT INTO Orders (SupplyID, TavernID, Cost, AmountReceived, ReceivedID)
VALUES (1, 1, 100.10, 12, 1),
(2, 2, 200.20, 20, 2),
(3, 3, 223.33, 49, 3),
(4, 4, 333.10, 50, 4),
(5, 5, 222.90, 11, 4),
(6, 5, 444.44, 60, 5);


INSERT INTO Sale (GuestID, TavernID, ServicesID, ServiceStatusID, Price, AmountPurchased, DatePurchased)
VALUES (1, 1, 1, 1, 10, 10, '20210113'),
(2, 2, 1, 1, 90, 90, '20210113'),
(3, 3, 2, 1, 80, 80, '20210113'),
(4, 2, 1, 1, 110, 110, '20210113'),
(5, 1, 1, 1, 200, 200, '20210113'),
(6, 3, 2, 1, 30, 30, '20210113'),
(7, 1, 1, 1, 600, 600, '20210113'),
(8, 6, 1, 1, 50, 50, '20210113'),
(1, 5, 1, 1, 70, 70, '20210113'),
(1, 4, 1, 1, 110, 110, '20210113'),
(1, 4, 1, 1, 20, 20, '20210113'),
(2, 4, 1, 1, 50, 50, '20210113'),
(3, 5, 1, 1, 60, 60, '20210113'),
(4, 6, 1, 1, 50, 50, '20210113');

INSERT INTO SuppliesSale (InventoryID, SaleID, ProductID, Quantity)
VALUES (1, 1, 1, 2),
(1, 2, 1, 2),
(1, 3, 2, 1),
(1, 4, 4, 7),
(1, 5, 3, 5),
(1, 6, 2, 4),
(1, 7, 1, 23),
(1, 8, 4, 2);

INSERT INTO RoomStatus (Name)
VALUES ('Occupied'),
('Vacant & Clean'),
('Vacant & Dirty'),
('Check Out'),
('Out of Order');

INSERT INTO Room (TavernID) 
VALUES  (1),(1),(1),(1),(1),(1),(1);

INSERT INTO RoomAvail (RoomID, RoomStatusID, CurrentDate)
VALUES (1, 1, '20210101'),
(2, 2, '20210101'),
(3, 2, '20210101'),
(4, 2, '20210101'),
(5, 3, '20210101'),
(6, 5, '20210101'),
(7, 5, '20210101'),
(1, 1, '20210106'),
(2, 2, '20210106'),
(3, 2, '20210106'),
(4, 2, '20210106'),
(5, 3, '20210106'),
(6, 5, '20210106'),
(7, 5, '20210106'),
(1, 1, '20210131'),
(2, 2, '20210131'),
(3, 2, '20210131'),
(4, 2, '20210131'),
(5, 3, '20210131'),
(6, 5, '20210131'),
(7, 5, '20210131');


INSERT INTO RoomStay (SaleID, GuestID, RoomAvailID, StayDate, Rate)
VALUES (1, 1, 1, '20210101', 8.00),
(2, 2, 2, '20210106', 9.00),
(3, 3, 3, '20210131', 10.00);



/* Insertion failed due to constraint */
/*
INSERT INTO SuppliesSale (InventoryID, SaleID, ProductID, Quantity)
VALUES (10, 1, 1, 2);*/

/* Insertion failed due to invalid input */
/*
INSERT INTO Sale (GuestID, TavernID, ServicesID, ServiceStatusID, Price, AmountPurchased, DatePurchased)
VALUES (1, 1, 1, 1, 10, 10, '20212113');*/

/*Insertion failed due to mismatch columns and values*/
/*
INSERT INTO Orders (SupplyID, TavernID, Cost, AmountReceived, ReceivedID)
VALUES (1, 1, 100.10, 12);*/