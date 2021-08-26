/*
Begriffe aus dem Bereich DB Design

Normalisierung  vs Redundanz
 1NF 2 NF 3 NF

 Tabellen Kunden:

 KdNr  Pkey  --Beziehung -- FKey
 FamName  varchar(50)
 Vorname
 GebDat  date
 Ort varchar(50)
 Plz
 Strasse
 Hnr

 DATUM
 date
 datetime (ms)
 datetime2 (ns)

 Char(100) 100  'Otto'  100
 varchar(100) 'otto' 4 
 nchar od nvarchar  .. doppelte menge

 nvarchar(100) otto...  4*2 = 8
 nchar(100) otto    100*2 = 200

 !!. Die HDD ist groﬂ genug

 !! Aber .. alles was du von der HDD holst kommt 1:1 in RAM

 unsinnige Datentypen:  datetime auf ms bei GebDat?

 Das Diagramm hilft Schwachpunkte in der logischen struktur zu finden

 Allerdings bedarf es auch der Untersuchung der physikalische Struktur


*/