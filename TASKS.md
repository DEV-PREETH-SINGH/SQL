# Friends Series Database SQL Script

## Task 1: Create Tables and Insert Data

```sql
-- User Details Table
CREATE TABLE user_details (
    UserID INT PRIMARY KEY, 
    Name VARCHAR(255), 
    Email VARCHAR(255) UNIQUE, 
    Password VARCHAR(255), 
    ContactNumber VARCHAR(20), 
    Address TEXT 
);

-- Insert Data into User Details
INSERT INTO user_details (UserID, Name, Email, Password, ContactNumber, Address) VALUES
(100,'Ross Geller','ross04@gmail.com','ROSS123',7865433787,'New York'),
(101,'Rachel Green','rachelgreen@gmail.com','Rachel387',7747294659,'Central Perk'),
(102,'Monica Geller','monicageller@gmail.com','Monica421','9845353781','Apartment 20, Grove Street'),
(103,'Chandler Bing','chandlerbing@gmail.com','chandler@32','8748684468','Apartment 19, Grove Street');

-- Courier Table
CREATE TABLE Courier (
    CourierID INT PRIMARY KEY,
    UserID INT,
    SenderName VARCHAR(255),
    SenderAddress TEXT,
    ReceiverName VARCHAR(255),
    ReceiverAddress TEXT,
    Weight DECIMAL,
    Status VARCHAR(50),
    TrackingNumber VARCHAR(20) UNIQUE,
    DeliveryDate DATE,
    FOREIGN KEY (UserID) REFERENCES user_details(UserID)
);

-- Insert Data into Courier
INSERT INTO Courier (CourierID, UserID, SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate) VALUES
(200, 100, 'Ross Geller', 'New York', 'Joey Tribbiani', 'Los Angeles', 5, 'dispatched', 77457644827, '2024-05-02'),
(202, 101, 'Rachel Green', 'Central Perk', 'Phoebe Buffay', 'Las Vegas', 3.5, 'on the way', 77457743891, '2024-04-29'),
(205, 102, 'Monica Geller', 'Apartment 20, Grove Street', 'Janice Hosenstein', 'Chicago', 7, 'delivered', 57457244807, '2024-04-22'),
(207, 103, 'Chandler Bing', 'Apartment 19, Grove Street', 'Nora Bing', 'Boston', 6.15, 'reached the nearest hub', 95757624828, '2024-05-01'),
(208, 102, 'Monica Geller', 'Apartment 20, Grove Street', 'Richard Burke', 'Miami', 4.25, 'delivered', 57457244817, '2024-05-23'),
(201, 100, 'Ross Geller', 'New York', 'Joey Tribbiani', 'London', 5, 'dispatched', 77457644857, '2024-05-10');

-- Courier Services Table
CREATE TABLE CourierServices (
    ServiceID INT PRIMARY KEY, 
    ServiceName VARCHAR(100), 
    Cost DECIMAL
);

-- Insert Data into Courier Services
INSERT INTO CourierServices (ServiceID, ServiceName, Cost) VALUES
(001, 'STANDARD SHIPPING', 70),
(002, 'EXPRESS SHIPPING', 140),
(003, 'SAME DAY DELIVERY', 210),
(004, 'INTERNATIONAL', 1050);

-- Courier Service Mapping Table
CREATE TABLE CourierServiceMapping (
    CourierID INT,
    ServiceID INT,
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
    FOREIGN KEY (ServiceID) REFERENCES CourierServices(ServiceID)
);

-- Insert Data into Courier Service Mapping
INSERT INTO CourierServiceMapping (CourierID, ServiceID) VALUES
(200, 001),
(202, 001),
(205, 003),
(207, 001),
(208, 003),
(201, 004);

-- Employee Table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY, 
    Name VARCHAR(255), 
    Email VARCHAR(255) UNIQUE, 
    ContactNumber VARCHAR(20), 
    Role VARCHAR(50), 
    Salary DECIMAL
);

-- Insert Data into Employee
INSERT INTO Employee (EmployeeID, Name, Email, ContactNumber, Role, Salary) VALUES
(7001, 'Joey Tribbiani', 'joeytribbiani@gmail.com', 9088333557, 'Actor', 40000),
(7005, 'Phoebe Buffay', 'phoebe04@gmail.com', 9188333333, 'Musician', 24000),
(7006, 'Richard Burke', 'richardburke@gmail.com', 8537454888, 'Doctor', 18000),
(7007, 'Nora Bing', 'norabing@gmail.com', 7246624999, 'Writer', 35000),
(7008, 'Monica Geller', 'monicageller@gmail.com', 9047435139, 'Chef', 20000),
(7009, 'Chandler Bing', 'chandlerb@gmail.com', 9947435139, 'Advertising', 20000);

-- Employee Courier Table
CREATE TABLE EmployeeCourier (
    EmployeeID INT,
    CourierID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID)
);

-- Insert Data into Employee Courier
INSERT INTO EmployeeCourier (EmployeeID, CourierID) VALUES
(7001, 200),
(7005, 202),
(7006, 205),
(7007, 207),
(7009, 208),
(7008, 201);

-- Location Table
CREATE TABLE Location (
    LocationID INT PRIMARY KEY, 
    LocationName VARCHAR(100), 
    Address TEXT
);

-- Insert Data into Location
INSERT INTO Location (LocationID, LocationName, Address) VALUES
(31838, 'Los Angeles', 'Los Angeles, California'),
(21764, 'Las Vegas', 'Las Vegas, Nevada'),
(52838, 'Chicago', 'Chicago, Illinois'),
(23176, 'Boston', 'Boston, Massachusetts'),
(53883, 'Miami', 'Miami, Florida'),
(67376, 'London', 'London, United Kingdom');

-- Payment Table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY, 
    CourierID INT, 
    LocationId INT, 
    Amount DECIMAL, 
    PaymentDate DATE, 
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID), 
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

-- Insert Data into Payment
INSERT INTO Payment (PaymentID, CourierID, LocationId, Amount, PaymentDate) VALUES
(0001, 200, 31838, 70, '2024-04-25'),
(0002, 202, 21764, 85, '2024-04-24'),
(0004, 205, 52838, 240, '2024-04-22'),
(0005, 207, 23176, 75, '2024-04-27)