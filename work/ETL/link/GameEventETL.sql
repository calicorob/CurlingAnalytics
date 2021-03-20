USE dnorm;

INSERT INTO link.GameEvent
(
	 GameID
	,EventID
)
WITH GameEvents AS
(
	SELECT 
		 GameID
		,EventID
	FROM dnorm.Linescore
	GROUP BY
		 GameID
		,EventID

)
SELECT
	 s.GameID
	,s.EventID
FROM GameEvents s
LEFT JOIN link.GameEvent t
ON t.GameID = s.GameID AND t.EventID = s.EventID
WHERE t.GameID IS NULL;



