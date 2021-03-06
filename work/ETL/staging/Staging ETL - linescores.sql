USE validated;


INSERT INTO staging.Linescore 
(
	 
	 GameID
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
/*
WITH Groups AS
(
	SELECT
		 GameID
		,ROW_NUMBER() OVER(ORDER BY(SELECT 1)) + (SELECT IFNULL(MAX(GameID),0) FROM Scores.Scores)  AS NewGameID
	FROM ValidatedScores
	GROUP BY
		GameID
		
), */
WITH Games AS
(
SELECT 
	 vs.GameID
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
	,ROW_NUMBER() OVER(PARTITION BY TeamID, EventID, DrawNum ORDER BY (SELECT 1)) AS rid
FROM validated.Linescore vs
),
Staging AS
(
SELECT 
	
	 GameID
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
FROM Games 
WHERE rid = 1
)
SELECT
	 st.GameID
	,st.EventID
	,st.TeamID
	,st.EventName
	,st.Draw
	,st.End1
	,st.End2
	,st.End3
	,st.End4
	,st.End5
	,st.End6
	,st.End7
	,st.End8
	,st.End9
	,st.End10
	,st.End11
	,st.End12
	,st.Hammer
	,st.FinalScore
	,st.Team
	,st.URL
	,st.TeamLink
	,st.DrawNum
	,st.Year
	,st.StartMonth
	,st.EndMonth
	,st.EventDayStart
	,st.EventDayEnd
FROM Staging st
LEFT JOIN staging.Linescore l
ON l.TeamID = st.TeamID AND l.EventID = st.EventID AND l.DrawNum = st.DrawNum
WHERE l.GameID IS NULL ;





