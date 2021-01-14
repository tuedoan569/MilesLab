/************************************************************/
/* Author:          Tue Doan                                */
/* Creation Date:   Jan 13, 2021                            */
/* Due Date:        Jan 14, 2021                            */
/* Course:          Miles Training Lab                      */
/* Assignment:      #1                                      */
/* Filename:        inventory.sql                           */
/* Purpose: This script for keeping track of supply and sale*/
/************************************************************/

/* Drop tables in order opposite of constraints*/
DROP TABLE IF EXISTS Sale;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Tavern;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Supply;

DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Statuses;
DROP TABLE IF EXISTS Services;

DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Received;
/* Create tables */

CREATE TABLE Locations (
    ID INT IDENTITY(1, 1),
    Name VARCHAR(250),
    PRIMARY KEY (ID)
)

CREATE TABLE Product (
    ID INT IDENTITY(1, 1),
    Name VARCHAR(250),
    Unit VARCHAR(50),
    PRIMARY KEY (ID)
)

CREATE TABLE Supply (
    ID INT IDENTITY(1, 1),
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (ID)
)

CREATE TABLE Received (
    ID INT IDENTITY(1, 1),
    DateReceived DATE,
    PRIMARY KEY (ID)
)

CREATE TABLE Inventory (
    ID INT IDENTITY(1, 1),
    SupplyID INT,
    ProductID INT,
    Quantity INT,
    ReceivedID INT,
    PRIMARY KEY (ID)
)

CREATE TABLE Tavern (
    ID INT IDENTITY(1, 1),
    Name VARCHAR(100),
    InventoryID INT,
    LocationsID INT,
    PRIMARY KEY (ID)
)

CREATE TABLE Orders (
    ID INT IDENTITY(1, 1),
    SupplyID INT,
    TavernID INT,
    Cost DEC,
    AmountReceived INT,
    ReceivedID INT,
    PRIMARY KEY (ID)
)

CREATE TABLE Statuses (
    ID INT IDENTITY(1, 1),
    Name VARCHAR(50),
    PRIMARY KEY (ID)
)

CREATE TABLE Services (
    ID INT IDENTITY(1, 1),
    Name VARCHAR(50),
    PRIMARY KEY (ID)
)

CREATE TABLE Users (
    ID INT IDENTITY(1, 1),
    Name VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    PRIMARY KEY (ID)
)

CREATE TABLE Sale (
    ID INT IDENTITY(1, 1),
    UsersID INT,
    TavernID INT,
    ServicesID INT,
    StatusesID INT,
    Price DEC,
    AmountPurchased INT,
    DatePurchased DATE,
    PRIMARY KEY (ID)
)

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

ALTER TABLE Tavern 
ADD CONSTRAINT FK_Tavern_InventoryID 
FOREIGN KEY (InventoryID) REFERENCES Inventory(ID),
CONSTRAINT FK_Tavern_LocationsID 
FOREIGN KEY (LocationsID) REFERENCES Locations(ID);

ALTER TABLE Orders 
ADD CONSTRAINT FK_Orders_SupplyID
FOREIGN KEY (SupplyID) REFERENCES Supply(ID),
CONSTRAINT FK_Orders_TavernID 
FOREIGN KEY (TavernID) REFERENCES Tavern(ID),
CONSTRAINT FK_Orders_ReceivedID
FOREIGN KEY (ReceivedID) REFERENCES Received(ID);

ALTER TABLE Sale 
ADD CONSTRAINT FK_Sale_UsersID
FOREIGN KEY (UsersID) REFERENCES Users(ID),
CONSTRAINT FK_Sale_TavernID 
FOREIGN KEY (TavernID) REFERENCES Tavern(ID),
CONSTRAINT FK_Sale_ServicesID 
FOREIGN KEY (ServicesID) REFERENCES Services(ID),
CONSTRAINT FK_Sale_StatusesID 
FOREIGN KEY (StatusesID) REFERENCES Statuses(ID);

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

INSERT INTO Received (DateReceived)
VALUES ('20210112'),
('20210111'),
('20210110'),
('20210109'),
('20210108'),
('20210107'),
('20210106'),
('20210105'),
('20210104'),
('20210103');

INSERT INTO Inventory (SupplyID, ProductID, Quantity, ReceivedID)
VALUES (1, 1, 12, 1),
(2, 2, 20, 2),
(3, 2, 49, 3),
(4, 3, 50, 4),
(5, 2, 11, 4),
(6, 4, 60, 5);

INSERT INTO Tavern(Name, InventoryID, LocationsID) 
VALUES ('Tavern1', 1, 1),
('Tavern2', 1, 2),
('Tavern3', 2, 3),
('Tavern4', 3, 4),
('Tavern5', 2, 5),
('Tavern6', 3, 6),
('Tavern7', 3, 7),
('Tavern8', 1, 8);

INSERT INTO Statuses (Name)
VALUES ('Active'),
('Inactive'),
('Out of Stock'),
('Discontinued');

INSERT INTO Services (Name) 
VALUES ('Pool'),
('Weapon Sharpening'),
('Dart');

INSERT  INTO Users(Name, Phone, Email) 
VALUES ('Santos Vaughn', '3099349081', 'ejepylludd-3082@yopmail.com'),
('Domingo Keller', '2315467303', 'ozunnemmym-1545@yopmail.com'),
('Cary Fox', '9149957176', 'qigigegy-3879@yopmail.com'),
('Elijah Sandoval', '4092661048', 'uxorufarru-3601@yopmail.com'),
('Elisa Schmidt', '7702924545', 'omofeke-5683@yopmail.com'),
('Charlie West', '7349151027', 'rubequtif-3425@yopmail.com'),
('Mabel Nelson', '4155204264', 'kavarizode-5703@yopmail.com'),
('Wanda Palmer', '5802458817', 'cirrirrefity-4276@yopmail.com'),
('Taylor Clark', '5183699086', 'imellegis-6286@yopmail.com');

INSERT INTO Orders (SupplyID, TavernID, Cost, AmountReceived, ReceivedID)
VALUES (1, 1, 100.10, 12, 1),
(2, 2, 200.20, 20, 2),
(3, 3, 223.33, 49, 3),
(4, 4, 333.10, 50, 4),
(5, 5, 222.90, 11, 4),
(6, 5, 444.44, 60, 5);

INSERT INTO Sale 
VALUES (1, 1, 1, 1, 10, 10, '20210113'),
(2, 2, 1, 1, 10, 10, '20210113'),
(3, 3, 2, 1, 10, 10, '20210113'),
(4, 2, 1, 1, 10, 10, '20210113'),
(5, 1, 1, 1, 10, 10, '20210113'),
(6, 3, 2, 1, 10, 10, '20210113'),
(7, 1, 1, 1, 10, 10, '20210113'),
(8, 1, 1, 1, 10, 10, '20210113');



