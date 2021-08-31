/*
Indizes haben überall ihre Finger drin..

Abfragen dauern plötzlich nur Bruchteile der normalen Zeit

Indizes haben große Auswirkung auf Sperrniveaus

row
page
Extent
Tab
-ohne Indizes wird der LOCK entweder mind auf eine Partition sein, 
--falls vorhanden oder die gesamte Tabelle.
--!! also auch beim Ändern eines Datensatzes wird evtl die gesamte Tabelle gesperrt!!

-->Verhindern von forward_record_counts durch CLustered Indizes


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

--ColumnStore

select * into ku1 from ku -- exakte Kopie hat keinerlei Indizes


select country, SUM(quantity) from ku
where OrderDate between '1.1.1998' and '31.12.1998' 
group by country 

CREATE NONCLUSTERED INDEX NIXDEMO
ON [dbo].[KU] ([OrderDate])
INCLUDE ([Country],[Quantity])

--1750 Seiten 30ms CPU und Dauer

--reiner IX SEEK (abdeckender IX)
select country, SUM(quantity) from ku1
where OrderDate between '1.1.1998' and '31.12.1998' 
group by country 



CREATE CLUSTERED COLUMNSTORE INDEX [CSIX] 
ON [dbo].[ku1] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)

select country, SUM(quantity) from ku1
where OrderDate between '1.1.1998' and '31.12.1998' 
group by country 

--KU Tabelle Gesamt 500MB

--KU1: Tabelle Gesamt: 4.2 MB ???
-- stimmts oder stimmts nicht?
--Es stimmt!

--Gründe gibts für kleiner?
--Kompression.. normalerweise 40-60%

--nun Archivkompression... nun 3,2 MB statt 4,2 MB statt 500MB

--und das kommt so in den RAM

select country, city, SUM(quantity) from ku
where freight < 0.2
group by country , city

--GENIAL!!!

--Wo ist der Haken....????!!!!!

--Problem bei INS UP DEL... HEAP !

-- Wartung

--REBUILD REORG
--Fragmentierungsgrad bei normalen IX
-- ReOrg ab 10%
--Rebuild ab 30%
--bei CS IX eher der deltastore

--Wartungsplan.. kann es bei Express nicht geben
--SSIS Paket

--Wie finde ich die richtige Strategie-- Datenbankoptimierungsratgeber
