USE staging;

INSERT INTO dnorm.Ranking
(
	 RankingID
	,TeamLink 
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
		 ROW_NUMBER() OVER(ORDER BY(SELECT 1)) + (SELECT IFNULL(MAX(RankingID),0) FROM dnorm.Ranking) AS RankingID
		,TeamLink
		,TeamID
		,Name
		,YTDPoints
		,PointTotal
		,Rank
		,Year
	FROM Ranking

)
SELECT
	 rr.RankingID
	,rr.TeamLink
	,rr.TeamID
	,rr.Name
	,rr.YTDPoints
	,rr.PointTotal
	,rr.Rank
	,rr.Year
FROM Ranks rr
LEFT JOIN dnorm.Ranking r
ON rr.TeamID = r.TeamID
WHERE r.TeamID IS NULL;
