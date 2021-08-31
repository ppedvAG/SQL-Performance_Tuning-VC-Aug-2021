/*
mdf ldf  Trenne die Daten von Log pro DB pyhsikalisch

Initialgröße der DB
			Daten     Log   Wachstumsrate
SQL 2014      5        2     Daten: 1 MB  Log: 10%    
SQL 2016      8        8     Daten: 64 MB  Log: 64 MB

--fast alle Werte sind  unsinnig
--korrekter wäre: mach die DB so groß , wie sie in 3 Jahren sein wird
--evtl messen mit Perfmon SQL Server:Datenbanken Größe der Dateien 1*täglich

--BACKUP? ist nicht von der Größe betroffen, sondern vom Inhalt



*/


create database KursDB

use KursDB


create table t1 (id int identity, spx char(4100));

insert into t1
select 'XY'
GO 20000 --dauert..30 Sekunden

--Wie groß ist die Tabelle: 4kb * 20000 = 80 MB

--Statt erwart 80 nun 160 MB Daten???

--Bericht Datenträgerverwendung
--es sollten keine häufigen vergrößerungen stattfinden
--schon gar nicht im Sekundebereich...

create table t2 (id int identity, spx char(4100));

insert into t2
select 'XY'
GO 20000


--CRM

--Felder sehr breite Tabelle: Hobby1, Hobby2, Fax1 , Fax2, Fax3, Frau1, Frau2, Frau3, Frau4, Religion







