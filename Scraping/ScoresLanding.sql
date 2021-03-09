USE landing;

DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Scores' AND TABLE_SCHEMA = 'landing') THEN
		SELECT 1 AS ScoresTableExists;
	ELSE
		CREATE TABLE Scores
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
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Exceptions' AND TABLE_SCHEMA = 'landing') THEN
		SELECT 1 AS ExceptionsTableExists;
	ELSE
		CREATE TABLE Exceptions
		(
			 ExceptionType TEXT NOT NULL
			,EventID INT NOT NULL
			,URL TEXT NOT NULL
			,DrawNum INT NOT NULL
		
		
		
		
		
		);
	END IF;
END $
DELIMITER $
