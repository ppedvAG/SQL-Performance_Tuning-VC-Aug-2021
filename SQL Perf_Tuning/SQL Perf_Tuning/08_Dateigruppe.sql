--Dateigruppe

create table test(id int) on HOT--kursdb2.ndf


--Dateigruppen sind ein Alias für den Ort, wo SQL Server
--weiter Datendateien abgelegt 

--wie können wir Tabellen verschieben von einer DGruppe (PIRMARY)
--auf eine andere DGruppe

--Über Entwurfsansicht kann man das machen, aber Vorsicht--> Beziehungen..
--alle Tabellen werden gesperrt

--per default ist die PRIMARY Dateigruppe (=mdf) standard


--Vorsicht: beim Verschieben einer Tabellen von DGr zu Dgr
--wird im SSMS die Tabelle interim gelöscht

--Trick. Würde man einen CLUSTERED IX anlegen und diesen auf
--eine andere Dateigruppe legen, wäre dies nicht mit einem Löschen verbunden
--Den CL IX könnte man anschliessend auch wieder löschen..

--einfachste Form um auf HDD Performance zu bringen


