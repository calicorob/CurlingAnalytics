USE staging;


INSERT INTO dnorm.Linescore 
(
	 LinescoreID
	,GameID
	,EventID
	,TeamID
	,EventName
	,Draw
	,End1
	,End2
	,End3
	,End4
	,End5
	,End6
	,End7
	,End8
	,End9
	,End10
	,End11
	,End12
	,Hammer
	,FinalScore
	,Team
	,URL
	,TeamLink
	,DrawNum
	,Year
	,StartMonth
	,EndMonth
	,EventDayStart
	,EventDayEnd
)

WITH Groups AS
(
	SELECT
		 GameID
		,ROW_NUMBER() OVER(ORDER BY(SELECT 1)) + (SELECT IFNULL(MAX(GameID),0) FROM dnorm.Linescore)  AS NewGameID
	FROM staging.Linescore
	GROUP BY
		GameID
		
), 
Games AS
(
	SELECT 
		 ROW_NUMBER() OVER(ORDER BY(SELECT 1)) + (SELECT IFNULL(MAX(GameID),0) FROM dnorm.Linescore )AS LinescoreID
		,gr.NewGameID AS GameID
		,vs.EventID
		,vs.TeamID
		,vs.EventName
		,vs.Draw
		,vs.End1
		,vs.End2
		,vs.End3
		,vs.End4
		,vs.End5
		,vs.End6
		,vs.End7
		,vs.End8
		,vs.End9
		,vs.End10
		,vs.End11
		,vs.End12
		,vs.Hammer
		,vs.FinalScore
		,vs.Team
		,vs.URL
		,vs.TeamLink
		,vs.DrawNum
		,vs.Year
		,vs.StartMonth
		,vs.EndMonth
		,vs.EventDayStart
		,vs.EventDayEnd
	FROM staging.Linescore vs
	LEFT JOIN Groups gr
	ON gr.GameID = vs.GameID
)

SELECT
	 ga.LinescoreID
	,ga.GameID
	,ga.EventID
	,ga.TeamID
	,ga.EventName
	,ga.Draw
	,ga.End1
	,ga.End2
	,ga.End3
	,ga.End4
	,ga.End5
	,ga.End6
	,ga.End7
	,ga.End8
	,ga.End9
	,ga.End10
	,ga.End11
	,ga.End12
	,ga.Hammer
	,ga.FinalScore
	,ga.Team
	,ga.URL
	,ga.TeamLink
	,ga.DrawNum
	,ga.Year
	,ga.StartMonth
	,ga.EndMonth
	,ga.EventDayStart
	,ga.EventDayEnd
FROM Games ga
LEFT JOIN dnorm.Linescore l
ON l.TeamID = ga.TeamID AND l.EventID = ga.EventID AND l.DrawNum = ga.DrawNum
WHERE l.TeamID IS NULL ;






