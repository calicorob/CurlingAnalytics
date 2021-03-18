DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.schemata WHERE schema_name = 'lookup') THEN
		SELECT 1 AS LookupSchemaExists;
	ELSE
		CREATE DATABASE lookup;
		GRANT ALL PRIVILEGES ON dnorm.* TO scraper@'%' IDENTIFIED BY 'scraper';
		FLUSH PRIVILEGES;
	END IF;
END $
DELIMITER ;

USE lookup;

DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MonthLookup' AND TABLE_SCHEMA = 'lookup') THEN
		SELECT 1 AS MonthLookupTableExists;
	ELSE
		CREATE TABLE MonthLookup
		(
				 
			 Month VARCHAR(32) NOT NULL
			,MonthNumber INT NOT NULL
			,PRIMARY KEY(Month)
	
		
		);
	END IF; 
END $
DELIMITER ;

INSERT INTO lookup.MonthLookup
(
	 Month
	,MonthNumber


)
SELECT
	 'Jan' AS Month
	,1 AS MonthNumber
UNION ALL
SELECT
	 'Feb' AS Month
	,2 AS MonthNumber
UNION ALL
SELECT
	 'Mar' AS Month
	,3 AS MonthNumber
UNION ALL
SELECT
	 'Apr' AS Month
	,4 AS MonthNumber
UNION ALL
SELECT
	 'May' AS Month
	,5 AS MonthNumber
UNION ALL
SELECT
	 'Jun' AS Month
	,6 AS MonthNumber
UNION ALL
SELECT
	 'Jul' AS Month
	,7 AS MonthNumber
UNION ALL
SELECT
	 'Aug' AS Month
	,8 AS MonthNumber
UNION ALL
SELECT
	 'Sep' AS Month
	,9 AS MonthNumber
UNION ALL
SELECT
	 'Oct' AS Month
	,10 AS MonthNumber
UNION ALL
SELECT
	 'Nov' AS Month
	,11 AS MonthNumber
UNION ALL
SELECT
	 'Dec' AS Month
	,12 AS MonthNumber
