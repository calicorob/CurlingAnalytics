USE team;


INSERT INTO team.Team
(
	 TeamID
	,TeamName


)
WITH TeamInfo AS
(
	SELECT
		 l.TeamID
		,l.Team AS TeamName
		,l.Year
		,ml.MonthNumber
	FROM dnorm.Linescore l
	LEFT JOIN lookup.MonthLookup ml
	ON ml.Month = l.EndMonth
	GROUP BY
		 l.TeamID
		,l.Team
		,l.Year
		,ml.MonthNumber

),
SortedTeamInfo AS
(
	SELECT
		 *
		,ROW_NUMBER() OVER(PARTITION BY TeamID ORDER BY Year DESC, MonthNumber DESC) AS rid
	FROM TeamInfo
),
FilteredTeamInfo AS
(
	SELECT
		 TeamID
		,TeamName
	FROM SortedTeamInfo
	WHERE rid = 1
)
SELECT
	 s.TeamID
	,s.TeamName
FROM FilteredTeamInfo s 
LEFT JOIN team.Team t
ON t.TeamID = s.TeamID
WHERE t.TeamID IS NULL;

