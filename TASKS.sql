-- TASK 1 -- CREATE, INSERT

CREATE TABLE user_details (
    UserID INT PRIMARY KEY, 
    Name VARCHAR(255), 
    Email VARCHAR(255) UNIQUE, 
    Password VARCHAR(255), 
    ContactNumber VARCHAR(20), 
    Address TEXT 
);

INSERT INTO user_details (UserID, Name, Email, Password, ContactNumber, Address) VALUES
(100,'Ross Geller','ross04@gmail.com','ROSS123',7865433787,'New York'),
(101,'Rachel Green','rachelgreen@gmail.com','Rachel387',7747294659,'Central Perk'),
(102,'Monica Geller','monicageller@gmail.com','Monica421','9845353781','Apartment 20, Grove Street'),
(103,'Chandler Bing','chandlerbing@gmail.com','chandler@32','8748684468','Apartment 19, Grove Street');

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

INSERT INTO Courier (CourierID, UserID, SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate) VALUES
(200, 100, 'Ross Geller', 'New York', 'Joey Tribbiani', 'Los Angeles', 5, 'dispatched', 77457644827, '2024-05-02'),
(202, 101, 'Rachel Green', 'Central Perk', 'Phoebe Buffay', 'Las Vegas', 3.5, 'on the way', 77457743891, '2024-04-29'),
(205, 102, 'Monica Geller', 'Apartment 20, Grove Street', 'Janice Hosenstein', 'Chicago', 7, 'delivered', 57457244807, '2024-04-22'),
(207, 103, 'Chandler Bing', 'Apartment 19, Grove Street', 'Nora Bing', 'Boston', 6.15, 'reached the nearest hub', 95757624828, '2024-05-01'),
(208, 102, 'Monica Geller', 'Apartment 20, Grove Street', 'Richard Burke', 'Miami', 4.25, 'delivered', 57457244817, '2024-05-23'),
(201, 100, 'Ross Geller', 'New York', 'Joey Tribbiani', 'London', 5, 'dispatched', 77457644857, '2024-05-10');


CREATE TABLE  CourierServices 
(ServiceID INT PRIMARY KEY, 
ServiceName VARCHAR(100), 
Cost DECIMAL);

INSERT INTO CourierServices(ServiceID,ServiceName,Cost)VALUES
(001,'STANDARD SHIPPING',70),
(002,'EXPRESS SHIPPING',140),
(003,'SAME DAY DELIVERY',210),
(004,'INTERNATIONAL',1050);

CREATE TABLE CourierServiceMapping (
         CourierID INT,
         ServiceID INT,
         FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
         FOREIGN KEY (ServiceID) REFERENCES CourierServices(ServiceID)
     );

INSERT INTO CourierServiceMapping(CourierID,ServiceID)VALUES
(200,001),(202,001),(205,003),(207,001),(208,003),(201,004);


CREATE TABLE Employee
(EmployeeID INT PRIMARY KEY, 
Name VARCHAR(255), 
Email VARCHAR(255) UNIQUE, 
ContactNumber VARCHAR(20), 
Role VARCHAR(50), 
Salary DECIMAL);

INSERT INTO Employee(EmployeeID,Name,Email,ContactNumber,Role,Salary)VALUES
(7001,'Joey Tribbiani','joeytribbiani@gmail.com',9088333557,'Actor',40000),
(7005,'Phoebe Buffay','phoebe04@gmail.com',9188333333,'Musician',24000),
(7006,'Richard Burke','richardburke@gmail.com',8537454888,'Doctor',18000),
(7007,'Nora Bing','norabing@gmail.com',7246624999,'Writer',35000),
(7008,'Monica Geller','monicageller@gmail.com',9047435139,'Chef',20000),
(7009,'Chandler Bing','chandlerb@gmail.com',9947435139,'Advertising',20000);

CREATE TABLE EmployeeCourier (
         EmployeeID INT,
         CourierID INT,
         FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
         FOREIGN KEY (CourierID) REFERENCES Courier(CourierID)
     );

INSERT INTO EmployeeCourier(EmployeeID,CourierID)VALUES
(7001,200),(7005,202),(7006,205),(7007,207),(7009,208),(7008,201);


CREATE TABLE Location 
(LocationID INT PRIMARY KEY, 
LocationName VARCHAR(100), 
Address TEXT);

INSERT INTO Location(LocationID,LocationName,Address)VALUES
(31838,'Los Angeles','Los Angeles, California'),
(21764,'Las Vegas','Las Vegas, Nevada'),
(52838,'Chicago','Chicago, Illinois'),
(23176,'Boston','Boston, Massachusetts'),
(53883,'Miami','Miami, Florida'),
(67376,'London','London, United Kingdom');

CREATE TABLE payment
(PaymentID INT PRIMARY KEY, 
CourierID INT, 
LocationId INT, 
Amount DECIMAL, 
PaymentDate DATE, 
FOREIGN KEY (CourierID) REFERENCES Courier(CourierID), 
FOREIGN KEY (LocationID) REFERENCES Location(LocationID));

INSERT INTO payment(PaymentID,CourierID,LocationId,Amount,PaymentDate)VALUES
(0001,200,31838,70,'2024-04-25'),
(0002,202,21764,85,'2024-04-24'),
(0004,205,52838,240,'2024-04-22'),
(0005,207,23176,75,'2024-04-27'),
(0006,208,53883,240,'2024-04-25'),
(0007,201,67376,2500,'2024-04-23');
select * from payment

--TASK 2
--SELECT,WHERE
--1
SELECT senderName FROM Courier;
--2
SELECT courierID FROM Courier
WHERE SenderName='Akash';
--3
SELECT * FROM Courier;
--4
SELECT * FROM CourierServices;
--5
SELECT receiverName,ReceiverAddress FROM Courier
WHERE CourierID=200;
--6
SELECT status FROM Courier
where status <> 'delivered';
--7
SELECT Status FROM Courier
WHERE DeliveryDate =CAST( GETDATE() AS date);
--8
SELECT ReceiverName,Status FROM Courier
WHERE Status='reached the nearest hub'; 
--9
SELECT sendername,count(courierID) FROM Courier
GROUP BY SenderName;
--10
SELECT avg(datediff(day,'2024-04-27',deliverydate))FROM Courier
GROUP BY CourierID;
--11
SELECT weight FROM Courier
WHERE Weight=5;
--12
SELECT name FROM Employee
WHERE name like '%john%';
--13
SELECT amount FROM payment
WHERE Amount>100;

--TASK 3
--14
SELECT employeeID,count(*) FROM employee
GROUP BY EmployeeID;
--15
SELECT locationID,sum(amount) FROM payment
GROUP BY LocationID;
--16
SELECT LocationID, COUNT(CourierID) AS TotalDeliveries
FROM payment
GROUP BY LocationID;

--17
SELECT TOP 1 courierID,avg(datediff(day,'2024-04-27',deliverydate))
FROM Courier
GROUP BY CourierID
ORDER BY avg(datediff(day,'2024-04-27',deliverydate)) DESC
--18
SELECT locationID,amount from payment
WHERE amount>200;
--19
SELECT locationID , sum(amount) FROM payment
GROUP BY LocationId;
--20
SELECT c.CourierID, c.SenderName, SUM(p.Amount) AS TotalPayments
FROM courier c
JOIN payment p ON c.CourierID = p.CourierID
WHERE p.LocationID = 52838
GROUP BY c.CourierID, c.SenderName
HAVING SUM(p.Amount) > 1000;
--21
SELECT CourierID, SUM(Amount) AS TotalPayment
FROM Payment
WHERE PaymentDate > '2024-04-22'
GROUP BY CourierID
HAVING SUM(Amount) > 1000;

--22
SELECT l.LocationID, l.LocationName, SUM(p.Amount) AS TotalAmountReceived
FROM location l
JOIN payment p ON l.LocationID = p.LocationID
WHERE p.PaymentDate > '2024-04-22'
GROUP BY l.LocationID, l.LocationName
HAVING SUM(p.Amount) > 80;
--Task 3
--23
SELECT p.PaymentID, p.Amount, p.PaymentDate, c.CourierID, c.sendername
FROM payment p
JOIN courier c ON p.CourierID = c.CourierID;
--24
SELECT p.PaymentID, p.Amount, p.PaymentDate, l.LocationID, l.LocationName
FROM payment p
JOIN location l ON p.LocationID = l.LocationID;
--25
SELECT p.PaymentID, p.Amount, p.PaymentDate, c.CourierID, c.sendername, l.LocationID, l.LocationName
FROM payment p
JOIN courier c ON p.CourierID = c.CourierID
JOIN location l ON p.LocationID = l.LocationID;
--26
SELECT p.PaymentID, p.Amount, p.PaymentDate, c.CourierID, c.SenderName
FROM payment p
JOIN courier c ON p.CourierID = c.CourierID;
--27
SELECT c.CourierID, c.SenderName, SUM(p.Amount) AS TotalPaymentsReceived
FROM courier c
JOIN payment p ON c.CourierID = p.CourierID
GROUP BY c.CourierID, c.SenderName;
--28
SELECT *
FROM payment
WHERE PaymentDate = '2024-04-25';
--29
SELECT p.PaymentID, p.Amount, p.PaymentDate, c.CourierID, c.SenderName
FROM payment p
JOIN courier c ON p.CourierID = c.CourierID;
--30
SELECT p.PaymentID, p.Amount, p.PaymentDate, l.LocationID, l.LocationName
FROM payment p
JOIN location l ON p.LocationID = l.LocationID;
--31
SELECT c.CourierID, c.SenderName, SUM(p.Amount) AS TotalPayments
FROM courier c
JOIN payment p ON c.CourierID = p.CourierID
GROUP BY c.CourierID, c.SenderName;
--32
SELECT *
FROM payment
WHERE PaymentDate >= '2024-04-24' AND PaymentDate <= '2024-04-26';
--33
SELECT U.UserID, U.Name, C.CourierID
FROM [User] U
LEFT JOIN Courier C ON U.UserID = C.UserID;

--34
SELECT
    C.CourierID, C.SenderName,
    CS.ServiceID, CS.ServiceName
FROM
    courier C
LEFT JOIN
    courierservicemapping CSM ON C.CourierID = CSM.CourierID
LEFT JOIN
    courierservices CS ON CSM.ServiceID = CS.ServiceID;

--35
SELECT
    E.EmployeeID, E.Name,
    P.PaymentID, P.Amount
FROM
    employee E
LEFT JOIN
    employeecourier EC ON E.EmployeeID = EC.EmployeeID
LEFT JOIN
    payment P ON EC.CourierID = P.CourierID;
--36
SELECT u.UserID, u.Name, c.CourierID, c.SenderName, s.ServiceID, s.ServiceName
FROM [user] u
CROSS JOIN courier c
CROSS JOIN CourierServices s;
--37
SELECT e.EmployeeID, e.Name, l.LocationID, l.LocationName
FROM employee e
CROSS JOIN location l;
--38
SELECT CourierID , sendername FROM Courier;
--39
SELECT CourierID , ReceiverName FROM Courier;
--40
SELECT 
    C.CourierID, C.senderName,
    CSM.ServiceID, CS.ServiceName
FROM 
    courier C
LEFT JOIN 
    courierservicemapping CSM ON C.CourierID = CSM.CourierID
LEFT JOIN 
    CourierServices CS ON CSM.ServiceID = CS.ServiceID;
--41
SELECT 
    E.EmployeeID, E.Name, COUNT(EC.CourierID) AS AssignedCouriers
FROM 
    employee E
LEFT JOIN 
    employeecourier EC ON E.EmployeeID = EC.EmployeeID
LEFT JOIN
    Courier c ON EC.CourierID=c.CourierID
GROUP BY 
    E.EmployeeID, E.Name;

--42
SELECT 
    L.LocationID, L.LocationName,
    SUM(P.Amount) AS TotalPaymentAmount
FROM 
    Location L
JOIN 
    Payment P ON L.LocationID = P.LocationID
GROUP BY 
    L.LocationID, L.LocationName;

--43
SELECT c1.CourierID, c1.SenderName
FROM courier c1
JOIN courier c2 ON c1.SenderName = c2.SenderName
WHERE c1.CourierID != c2.CourierID;
--44
SELECT EmployeeID, Name, Role
FROM employee
WHERE Role IN (
    SELECT Role
    FROM employee
    GROUP BY Role
    HAVING COUNT(*) > 1
);

--45
SELECT 
    P.PaymentID, P.Amount, P.PaymentDate,
    C.CourierID,
    L.LocationID, L.LocationName
FROM 
    Payment P
JOIN 
    Courier C ON P.CourierID = C.CourierID
JOIN 
    Location L ON P.LocationID = L.LocationID
JOIN 
    Payment P2 ON P.CourierID = P2.CourierID AND P.LocationID = P2.LocationID
ORDER BY 
    P.PaymentDate;

--46
SELECT c1.CourierID, c1.SenderName, c1.SenderAddress
FROM courier c1
JOIN courier c2 ON c1.SenderAddress LIKE c2.SenderAddress
WHERE c1.CourierID != c2.CourierID;
--47
SELECT
    E.EmployeeID,
    E.Name,
    COUNT(EC.CourierID) AS DeliveredCouriers
FROM
    employee E
LEFT JOIN
    employeecourier EC ON E.EmployeeID = EC.EmployeeID
GROUP BY
    E.EmployeeID,
    E.Name;

--48
SELECT p.courierID from payment p
inner join CourierServiceMapping cs on p.CourierID=cs.CourierID
inner join CourierServices c on cs.ServiceID=c.ServiceID
where Amount>Cost

--scope
--49
SELECT CourierID, SenderName, Weight
FROM courier
WHERE Weight > (SELECT AVG(Weight) FROM courier);
--50
SELECT Name
FROM employee
WHERE Salary > (SELECT AVG(Salary) FROM employee);
--51
SELECT SUM(Cost) AS TotalCost
FROM CourierServices
WHERE Cost < (SELECT MAX(Cost) FROM CourierServices);
--52
select courierid , amount from payment
where Amount is not null; 
--53doubt
SELECT * from location 
where LocationID =(SELECT locationID from payment
where amount =(select max(amount) from payment))

--54
SELECT CourierID, SenderName, Weight
FROM courier
WHERE Weight > (
    SELECT MAX(Weight)
    FROM courier
    WHERE SenderName = 'Akash'
);