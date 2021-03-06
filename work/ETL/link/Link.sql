

DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.schemata WHERE schema_name = 'link') THEN
		SELECT 1 AS LinkSchemaExists;
	ELSE
		CREATE DATABASE link;
		GRANT ALL PRIVILEGES ON link.* TO scraper@'%' IDENTIFIED BY 'scraper';
		FLUSH PRIVILEGES;
	END IF;
END $
DELIMITER ;


USE link;

DELIMITER $
BEGIN NOT ATOMIC
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GameEvent' AND TABLE_SCHEMA = 'link') THEN
		SELECT 1 AS GameEventTableExists;
	ELSE
		CREATE TABLE GameEvent
		(
				 
			
				  GameID INT NOT NULL
				 ,EventID INT NOT NULL
				 ,PRIMARY KEY(GameID,EventID)
	
				 
		
		
		);
	END IF; 
END $
DELIMITER ;
