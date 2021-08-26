/*


Seiten und Blöcke


DS werden in Seiten gespeichert
8 Seiten am Stück werden Block genannt

Page --> Extent


Eine Seite hat ein Volumen von 8192 bytes (immer gleich)
Eine Seite kann nicht mehr 700 DS beinhalten
I.d.R muss ein DS in eine Seite passen. (Summe aller Spalten mit fixen Datytpen)
1 DS kann nicht größer als 8060 werden
Von 8192bytes sind nur 8072 bytes nutzbar
Die Seiten werden 1:1 von HDD in RA gelesen


1 DS hat 4100
1 Mio DS
Wieviele Seiten--> 1 Mio Seiten
Wie voll sind die Seiten? >50%
Wie groß ist also die Tabelle? 8 GB
Wie groß ist der RAM Verbrauch? beim kompletten Lesen der Tabelle 8 GB

Läßt sich das herausfinden.. großen Verlust?

*/

create table t2 (id int, sp1 char(4100), sp2 char(4100))


dbcc showcontig('t1')

--- Gescannte Seiten.............................: 20000
--- Mittlere Seitendichte (voll).....................: 50.79%

--> 20000 * 8 KB = 160 MB

set statistics io, time on-- Anzahl der Seiten, CPU in ms und gesamte DAuer in ms
select * from t1 where ID=100 -- 20000.. für einen DS lesen wir 160MB in RAM von HDD

--Ohje: SCAN von a bis z alles durchsuchen vs SEEK.. das Herauspicken


dbcc showcontig()

--Was können wir tun ,um die Seitendichte zu erhöhen..
--Datentyp ändern von char in Varchar -- APP geht nicht  mehr

--Felder sehr breite Tabelle: Hobby1, Hobby2, Fax1 , Fax2, Fax3, Frau1, Frau2, Frau3, Frau4, Religion

--Was wäre wenn eine Tabelle Kunde in Kunde und Kundensonstiges

--4100 bytes vorher dann 4000 und 100 
--bei 1 MIO
--4 GB + 110MB => statt 8 GB (HDD und RAM)--> 4,1GB RAM und HDD.. aber APP geht nicht mehr

--Idee Kompression



