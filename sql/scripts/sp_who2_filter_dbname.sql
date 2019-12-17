-- insert results of sp_who2 on Azure SQL DB in a temptable
-- this creates the ability to filter afterwards
--

CREATE TABLE #sp_who2 
	( SPID INT
	, Status VARCHAR(255)
	, Login  VARCHAR(255)
	, HostName  VARCHAR(255)
	, BlkBy  VARCHAR(255)
	, DBName  VARCHAR(255)
	, Command VARCHAR(255)
	, CPUTime INT
	, DiskIO INT
	, LastBatch VARCHAR(255)
    , ProgramName VARCHAR(255)
	, SPID2 INT
	, REQUESTID INT
	)
GO	

INSERT INTO #sp_who2 
	   EXEC sp_who2
GO

SELECT      * 
FROM        #sp_who2
-- Add any filtering of the results here :
WHERE       DBName = 'EDW'
AND         [Login] = 'InformaticaUser'
-- Add any sorting of the results here :
ORDER BY    DBName ASC
 
DROP TABLE #sp_who2

/* Killen van een proces
     Hieronder een statement wat gebruikt kan worden voor het killen van een statement
     op basis van de SPID
*/
/* KILL {SPID} */
