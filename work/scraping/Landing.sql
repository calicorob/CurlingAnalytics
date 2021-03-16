
DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.schemata WHERE schema_name = 'landing') THEN
		SELECT 1 AS LandingSchemaExists;
	ELSE
		CREATE DATABASE landing;
		GRANT ALL PRIVILEGES ON landing.* TO scraper@'%' IDENTIFIED BY 'scraper';
		FLUSH PRIVILEGES;
	END IF;
END $
DELIMITER ;


USE landing;

DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Linescore' AND TABLE_SCHEMA = 'landing') THEN
		SELECT 1 AS LinescoreTableExists;
	ELSE
		CREATE TABLE Linescore
		(
			
			 GameID INT NOT NULL
			,EventID INT NOT NULL
			,EventDates TEXT NOT NULL
			,EventName TEXT NOT NULL
			,Draw TEXT NOT NULL
			,End1 VARCHAR(2)
			,End2 VARCHAR(2)
			,End3 VARCHAR(2)
			,End4 VARCHAR(2)
			,End5 VARCHAR(2)
			,End6 VARCHAR(2)
			,End7 VARCHAR(2)
			,End8 VARCHAR(2)
			,End9 VARCHAR(2)
			,End10 VARCHAR(2)
			,End11 VARCHAR(2)
			,End12 VARCHAR(2)
			,Hammer BOOLEAN NOT NULL
			,FinalScore INT NOT NULL
			,Team TEXT NOT NULL
			,URL TEXT NOT NULL
            ,TeamLink TEXT NOT NULL
			,DrawNum INT NOT NULL

		);
	END IF;
END $
DELIMITER ;


DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'LinescoreException' AND TABLE_SCHEMA = 'landing') THEN
		SELECT 1 AS LinescoreExceptionTableExists;
	ELSE
		CREATE TABLE LinescoreException
		(
			 ExceptionType TEXT NOT NULL
			,EventID INT NOT NULL
			,URL TEXT NOT NULL
			,DrawNum INT NOT NULL
		
		
		
		
		
		);
	END IF;
END $
DELIMITER ;

DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PivotedLinescore' AND TABLE_SCHEMA = 'landing') THEN
		SELECT 1 AS PivotedLinescoreTableExists;
	ELSE
		CREATE TABLE PivotedLinescore
		(
			 GameID INT NOT NULL
			,EndNum INT NOT NULL
			,EndResult INT NOT NULL
			,Hammer BOOLEAN NOT NULL
			,Score INT NOT NULL
			,Team INT NOT NULL
		
		

		);
	END IF;
END $
DELIMITER ;


DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Team' AND TABLE_SCHEMA = 'landing') THEN
		SELECT 1 AS TeamTableExists;
	ELSE
		CREATE TABLE Team
		(
			 TeamID INT NOT NULL
			,Player VARCHAR(256) NULL
			,Position VARCHAR(8) NOT NULL
			,TeamClub VARCHAR(256) NOT NULL
			,TeamLink TEXT NOT NULL

		);
	END IF;
END $
DELIMITER ;

DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Ranking' AND TABLE_SCHEMA = 'landing') THEN
		SELECT 1 AS RankingTableExists;
	ELSE
		CREATE TABLE Ranking
		(
			 TeamLink TEXT NOT NULL
			,Name VARCHAR(256) NOT NULL
			,YTDPoints FLOAT NOT NULL
			,PointTotal FLOAT NOT NULL
			,Rank VARCHAR(16) NOT NULL
			,Year INT NOT NULL

		);
	END IF;
END $
DELIMITER ;



