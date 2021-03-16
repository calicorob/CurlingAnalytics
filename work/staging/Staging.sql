
DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.schemata WHERE schema_name = 'staging') THEN
		SELECT 1 AS StagingSchemaExists;
	ELSE
		CREATE DATABASE staging;
		GRANT ALL PRIVILEGES ON staging.* TO scraper@'%' IDENTIFIED BY 'scraper';
		FLUSH PRIVILEGES;
	END IF;
END $
DELIMITER ;



USE staging;

DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Linescore' AND TABLE_SCHEMA = 'staging') THEN
		SELECT 1 AS LinescoreTableExists;
	ELSE
		CREATE TABLE Linescore
		(
				 
				 GameID INT NOT NULL
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

DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PivotedLinescore' AND TABLE_SCHEMA = 'staging') THEN
		SELECT 1 AS PivotedLinescoreTableExists;
	ELSE
		CREATE TABLE PivotedLinescore
		(	 
			 GameID INT NOT NULL
			,EndNum INT NOT NULL
			,EndResult INT NOT NULL
			,Hammer BOOLEAN NOT NULL
			,Score INT NOT NULL
			,TeamID INT NOT NULL
			,PRIMARY KEY (GameID, EndNum,TeamID)
		
		

		);
	END IF;
END $
DELIMITER ;



