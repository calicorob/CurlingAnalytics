
DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.schemata WHERE schema_name = 'dnorm') THEN
		SELECT 1 AS DNormSchemaExists;
	ELSE
		CREATE DATABASE dnorm;
		GRANT ALL PRIVILEGES ON dnorm.* TO scraper@'%' IDENTIFIED BY 'scraper';
		FLUSH PRIVILEGES;
	END IF;
END $
DELIMITER ;


USE dnorm;

DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Linescore' AND TABLE_SCHEMA = 'dnorm') THEN
		SELECT 1 AS LinescoreTableExists;
	ELSE
		CREATE TABLE Linescore
		(
				 
				 LinescoreID INT NOT NULL
				,GameID INT NOT NULL
				,EventID INT NOT NULL
				,TeamID INT NOT NULL
				,EventName TEXT NOT NULL
				,Draw VARCHAR(32) NOT NULL
				,End1 SMALLINT NULL
				,End2 SMALLINT NULL
				,End3 SMALLINT NULL
				,End4 SMALLINT NULL
				,End5 SMALLINT NULL
				,End6 SMALLINT NULL
				,End7 SMALLINT NULL
				,End8 SMALLINT NULL
				,End9 SMALLINT NULL
				,End10 SMALLINT NULL
				,End11 SMALLINT NULL
				,End12 SMALLINT NULL
				,Hammer BOOLEAN NOT NULL
				,FinalScore INT NOT NULL
				,Team TEXT NOT NULL
				,URL TEXT NOT NULL
				,TeamLink TEXT NOT NULL
				,DrawNum INT NOT NULL
				,Year INT NOT NULL
				,StartMonth VARCHAR(32) NOT NULL
				,EndMonth VARCHAR(32) NOT NULL
				,EventDayStart INT NOT NULL
				,EventDayEnd INT NOT NULL
				,PRIMARY KEY(TeamID,EventID,DrawNum)
	
				 
		
		
		);
	END IF; 
END $
DELIMITER ;
