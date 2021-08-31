----Tools zum Aufzeichnen
/*
Windows Perfmon  Leistungsüberwachung
Grafische Auswertung
Protzen!
20 Messwerte im Sekundetakt  4 h --> 20MB


SQL Server Profiler (Aufzeichnen von SQL Statements)
Sparta!

1 User 1h  10MB
4 User  1H  40MB

Hier besser filtern


Live: Aktivitätsmonitor
XEvents
Taskmanager
DMVs

*/

select * from sys.dm_os_performance_counters

--SQL Server, wo tuts dir weh?

--Messungen im Hintergrund werden nach Neustart auf NULL restet


select * from sys.dm_db_index_usage_stats --Verwendung von Indizes
--Seek oder Scans... sollte eigtl immer Seek sein
--Warum werden Indizes geupdatet, aber nie geseekt oder gescant????


select * from sys.dm_os_wait_stats -- worauf muss ich warten


---Abfrage-->WORKER-->Ressourcenanfragen--->Auftrag für CPU (Mach mal)
--im Taskmanager zu beobachten

--0----------------50ms-------70ms-->
--SUSPENED ........RUNNABLE.........|RUNNING

--Wait_time = 70ms
--signal_time: 20ms.. Wartezeit auf CPU  >25% CPU Engpass der wait_time
--wait_time-Signal_time= Wartezeit auf Ressource= 50ms


--DMV Glen Berry...

select * from sys.dm_os_wait_stats order by wait_time_ms desc

--Werte seit Neustart kumulierend

--eigtl regelm messen und wegschreiben (10min Takt etwa)
--um Probleme zeitlich besser eingrenzen zu können
--und nicht durch einen Neustart Infos zu verlieren

