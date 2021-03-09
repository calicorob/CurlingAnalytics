USE processingdev;

DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME ='Scores' AND TABLE_SCHEMA = 'processingdev') THEN
		SELECT 1 AS ScoresTableExists;
	ELSE
		CREATE TABLE Scores
			(
				 GameID INT NOT NULL
				,EventID INT NOT NULL
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
                ,TeamID INT NOT NULL
			
			
			
			
			);
	END IF;
END $
DELIMITER ;

DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PivotedScores' AND TABLE_SCHEMA = 'processingdev') THEN
		SELECT 1 AS PivotedScoresTableExists;
	ELSE
		CREATE TABLE PivotedScores
		(
			 GameID INT NOT NULL
			,Hammer BOOLEAN NOT NULL
			,Score INT NOT NULL
			,Team TEXT NOT NULL
			,EndResult INT NOT NULL
			,EndNum INT NOT NULL
		
		
		);
	END IF;
END $
DELIMITER ; 


DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ValidatedScores' AND TABLE_SCHEMA = 'processingdev') THEN
		SELECT 1 AS ValidatedScoresTableExists;
	ELSE
		CREATE TABLE ValidatedScores
		(
				 LinescoreID INT NOT NULL PRIMARY KEY
				,GameID INT NOT NULL
				,EventID INT NOT NULL
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
                ,TeamID INT NOT NULL
				 
		
		
		);
	END IF; 
END $
DELIMITER ;

DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PivotingExceptions' AND TABLE_SCHEMA = 'processingdev') THEN
		SELECT 1 AS PivotingExceptionsTableExists;
	ELSE
		CREATE TABLE PivotingExceptions
		(
				 LinescoreID INT NOT NULL 
				,GameID INT NOT NULL
				,EventID INT NOT NULL
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
				,TeamName TEXT NOT NULL
				,URL TEXT NOT NULL
                ,TeamLink TEXT NOT NULL
				,DrawNum INT NOT NULL
				,Year INT NOT NULL
				,StartMonth VARCHAR(32) NOT NULL
				,EndMonth VARCHAR(32) NOT NULL
				,EventDayStart INT NOT NULL
				,EventDayEnd INT NOT NULL
				,Team TEXT NOT NULL
				,ExceptionType TEXT 
				 
		
		
		);
	END IF; 
END $
DELIMITER ;

