USE processing;

INSERT INTO staging.Ranking
(
	 TeamLink 
	,TeamID 
	,Name 
	,YTDPoints 
	,PointTotal 
	,Rank 
	,Year 



)
WITH Ranks AS 
(
	SELECT
		 TeamLink
		,TeamID
		,Name
		,YTDPoints
		,PointTotal
		,Rank
		,Year
		,ROW_NUMBER() OVER(PARTITION BY TeamID ORDER BY(SELECT 1)) AS rid
	FROM Ranking

),
Staging AS
(
	SELECT
		 TeamLink
		,TeamID
		,Name
		,YTDPoints
		,PointTotal
		,Rank
		,Year
	FROM Ranks 
	WHERE rid = 1

)
SELECT
	 st.TeamLink
	,st.TeamID
	,st.Name
	,st.YTDPoints
	,st.PointTotal
	,st.Rank
	,st.Year
FROM Staging st
LEFT JOIN staging.Ranking r
ON r.TeamID = st.TeamID
WHERE r.TeamID IS NULL;
