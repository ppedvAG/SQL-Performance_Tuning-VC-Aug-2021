/*
Indizes haben überall ihre Finger drin..

Abfragen dauern plötzlich nur Bruchteile der normalen Zeit

Indizes haben große Auswirkung auf Sperrniveaus

row
page
Extent
Tab


extreme Reduzierung der IO--> RAM-->CPU

--bei schlechter Wartung
aber auch .. langsamer und mehr Ressourcen


Nicht gr Index

besonders gut bei rel geringer Ergebnismenge
kann auch 1% sein 
where = id  
ca 1000 / Tab


Gruppierter Index
hat seine Vorzüge bei Bereichssuchen
where >  < between like A%  =
= Tabelle also nur 1mal / Tab

Faustregel: lege immer zuerst den GR IX fest.. 
.alles andere kann nur noch NON CL IX sein

--------------------------
eindeutiger Index x
zusammengesetzter IX x
IX mit eingschl. Spalten x
abdeckenden Index x = der ideale Index reiner Seek
part. Index ..rein physikalisch in Teilchen ablegen
ind. Sicht -- reine DevGeschichte
gefilterter Index -- nicht mehr alle Datensätze im Index
--------------------------
columnstore IX


*/

set statistics io, time on


select * from ku --T scan
select * from ku where ID = 10-- Table Scan


select ID from ku where id=100 
--Optmieren: 
--zuerst legen wir den CL IX fest: Orderdate

--mit NIX_ID
--statt 62000 Seiten 200ms CPU  40ms Dauer
--IX SEEK

--jetzt IX Seek mit 0 ms und 3 Seiten


--jetzt brauchen wir TelAnruf = Lookup
select ID, freight from ku where id=100 


--Lookup mit 99%
select id , freight from ku where id < 100 

--Lookup.. ist weg.. nun Table Scan
select id , freight from ku where id < 13000 

select id , freight from ku where id < 11924 --Grenze für Seek

--das muss besser werden.. am besten Infos zum Index dazunehmen
--NIX_IDFR

select id , freight from ku where id < 13000 
--auch hier seek und sogar bei 600000 ebenfalls 
--zusammengestzter IX eindeutig


--wieder Lookup
select id , freight, shipcity from ku where id < 1000 

--Idee alle spalten rein in IX
--blöde Idee: der zusammeng kann nur max 16 Spalten haben

--besser iX mit eingeschl Spalten
--NIX_ID_i_SCFR

select country, city, SUM(unitprice*quantity) 
from ku 
where EmployeeID = 5 and ShipCity = 'Berlin'
group by Country, City

--NIX_

CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210827-144854] ON 
[dbo].[KU]
(
	[EmployeeID] ASC,[ShipCity] ASC
)
INCLUDE([City],[Country],[UnitPrice],[Quantity]) 

CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[KU] ([EmployeeID],[ShipCity])
INCLUDE ([City],[Country],[UnitPrice],[Quantity])



where EmployeeID = 5 and ShipCity = 'Berlin'
group by Country, City


select country, city, SUM(unitprice*quantity) 
from ku 
where EmployeeID = 5 OR ShipCity = 'Berlin'
group by Country, City

--2 Indizes.. 

--Puuhh wie finde ich die beste IX stratgie

select * from ku where freight < 1


select * into ku1 from ku


select country, SUM(quantity) from ku1 
where OrderDate between '1.1.1998' and '31.12.1998' 
group by country 
