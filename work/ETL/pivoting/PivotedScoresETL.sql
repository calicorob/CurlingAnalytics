USE landing;

INSERT INTO staging.PivotedLinescore
(
	
	 GameID
	,EndNum
	,EndResult
	,Hammer
	,Score
	,TeamID




)
WITH Games AS
(
	SELECT
		 GameID
		,EndNum
		,EndResult
		,Hammer
		,Score
		,Team AS TeamID
		,ROW_NUMBER() OVER (PARTITION BY TeamID,GameID,EndNum ORDER BY(SELECT 1)) as rid
	FROM landing.PivotedLinescore

),
Staging AS
(
	SELECT
		 GameID
		,EndNum
		,EndResult
		,Hammer
		,Score
		,TeamID
	FROM Games
	WHERE rid = 1


)
SELECT
	 st.GameID
	,st.EndNum
	,st.EndResult
	,st.Hammer
	,st.Score
	,st.TeamID
FROM Staging st
LEFT JOIN staging.PivotedLinescore s
ON s.TeamID = st.TeamID AND s.GameID = st.GameID AND s.EndNum = st.EndNum
WHERE s.TeamID IS NULL;

INSERT INTO dnorm.PivotedLinescore
(
	 PivotedScoreID
	,GameID
	,EndNum
	,EndResult
	,Hammer
	,Score
	,TeamID


)

WITH Games AS
(
	SELECT
		 ROW_NUMBER() OVER(ORDER BY(SELECT 1)) + (SELECT IFNULL(MAX(PivotedScoreID),0) FROM dnorm.PivotedLinescore) AS PivotedScoreID
		,GameID
		,EndNum
		,EndResult
		,Hammer
		,Score
		,TeamID
	FROM staging.PivotedLinescore

)
SELECT
	 ga.PivotedScoreID
	,ga.GameID
	,ga.EndNum
	,ga.EndResult
	,ga.Hammer
	,ga.Score
	,ga.TeamID
FROM Games ga
LEFT JOIN dnorm.PivotedLinescore t
ON ga.GameID = t.GameID AND ga.EndNum = t.EndNum AND ga.TeamID = t.TeamID
WHERE t.GameID IS NULL;
