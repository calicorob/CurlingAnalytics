USE landing;

SELECT 
	COUNT(*) AS ScoresCount
FROM Scores;

SELECT MAX(EventID) AS LatestEventID 
FROM Scores;


SELECT 
	COUNT(*) AS ExceptionsCount
FROM Exceptions;

