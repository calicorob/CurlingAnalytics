DELIMITER $

CREATE PROCEDURE dnorm.spGamesForAnalysis 
(
	EventClass INT

)

BEGIN


	WITH RelGames AS
	(

		SELECT
			 pl.PivotedScoreID
			,pl.GameID
			,pl.EndNum
			,pl.EndResult
			,pl.Hammer
			,pl.Score
			,pl.TeamID
			,e.EventName
			,e.Year
			,e.EndMonth
			,l.FinalScore
		FROM dnorm.PivotedLinescore pl
		INNER JOIN link.GameEvent ge
		ON pl.GameID = ge.GameID
		INNER JOIN event.Event e 
		ON e.EventID = ge.EventID
		INNER JOIN event.EventType et
		ON et.EventID = e.EventID AND et.Classification = EventClass
		INNER JOIN dnorm.Linescore l
		ON l.GameID = pl.GameID AND l.TeamID = pl.TeamID
		

	),
	RelGamesSituation AS
	(
		SELECT 
			 rg1.*
			,rg1.Score - rg2.Score AS EndSituation
			,rg2.TeamID AS OpponentTeamID
			,rg2.FinalScore AS OpponentFinalScore
			,CASE
				WHEN rg1.FinalScore > rg2.FinalScore
					THEN 1 
				WHEN rg2.Finalscore > rg1.FinalScore
					THEN 0
			 END AS Win
		FROM RelGames rg1
		INNER JOIN RelGames rg2
		ON rg1.GameID = rg2.GameID and rg1.EndNum = rg2.EndNum
		WHERE rg1.TeamID <> rg2.TeamID
	)
	SELECT *
	FROM RelGamesSituation;

END; 

DELIMITER;



