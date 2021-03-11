USE Scores;

CREATE VIEW PivotedScoresInfo AS
	WITH Scores AS
	(
		SELECT
			 PivotedScoreID
			,GameID
			,EndNum
			,EndResult
			,Hammer
			,Score
			,TeamID
		FROM PivotedScores
	
	),
	ScoresWithEndResult AS 
	(
		SELECT
			 s1.*
			,s1.Score - s2.Score AS EndSituation
		FROM Scores s1
		INNER JOIN Scores s2
		ON s1.GameID = s2.GameID AND s1.EndNum = s2.EndNum
		WHERE s1.TeamID <> s2.TeamID
	),
	ScoresWithInfo AS
	(
		SELECT
			 s.*
			,ls.Team
			,ls.EventName
			,ls.Draw
			,ls.FinalScore
			,ls.Year
			,ls.StartMonth
			,ls.EndMonth
			,ls.EventDayStart
			,ls.EventDayEnd
		FROM ScoresWithEndResult s
		INNER JOIN Scores.Scores ls
		ON ls.GameID = s.GameID AND ls.TeamID = s.TeamID

	)
	SELECT
		*
	FROM ScoresWithInfo;
		
