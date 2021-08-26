/*

MAXDOP 

Abfragen können eine oder mehr CPUs verwenden

Wird eine Abfrage schneller fertig sein, wenn mehr CPUs sie verarbeiten?
Normalerweise schon .. macht Sinn!







*/
--Spieltabelle
SELECT Customers.CustomerID, Customers.CompanyName, Customers.ContactName, 
Customers.ContactTitle, Customers.City, Customers.Country, Orders.OrderDate, Orders.EmployeeID, Orders.
Freight, Orders.ShipName,Orders.ShipCity, Orders.ShipCountry, [Order Details].OrderID, [Order Details].
ProductID, [Order Details].UnitPrice, [Order Details].Quantity, 
Products.ProductName, Products.UnitsInStock, Employees.LastName, Employees.FirstName 
INTO KU 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID 
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID 
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID 


insert into KU
select * from ku --6 Sek... im Gegensatz zu 20000 mit Go  20 Sek

--SQL Server liebt Massenoperation

alter table ku add id int identity

set statistics io, time on


select country, city, SUM(freight) from ku  --62000 Seiten
group by country, city 

-- CPU-Zeit = 374 ms, verstrichene Zeit = 52 ms.
--nur ein Grund dafür.. mehr CPUs haben was getan.. schient SInn gemacht zu haben


select country, city, SUM(freight) from ku  --62000 Seiten
group by country, city  option (maxdop 8)

--Fakt: Am Ende zählt der MAXDOP, der näher an der Abfrage drnan ist
-- Server(4)-->DB(6)--Abfrage(8)-- es zählt 8


--Was sollte man einstellen: 
-- der Kostenschwellwert sollte bei 25 sein.. und dann experimentieren

--SQL 2012: 5 und 0 (alle CPUs)

--im Plan Doppelpfeil

--Dass SQL Server paralelisiert müssen 2 Bedingungen erfüllt sein
-- Bed 1: wenn der Kostenschwellwert überschritten wurde: default bei 5
--       dann werden rigoros alle CPUs verwendet

-- Seit SQL 2019 (Setup) wird folgendes vorgeschlagen: alle Prozessoren ,
---aber nicht mehr als 8 

--Wären nicht weniger besser gewesen?


