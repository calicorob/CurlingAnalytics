USE landing;

INSERT INTO staging.EventType
(
	 EventID
	,Classification


)

WITH OrderedClassification AS
(
	SELECT
		 EventID
		,Classification
		,ROW_NUMBER() OVER(PARTITION BY EventID ORDER BY LandingTime DESC) AS rid
	FROM EventType
),
EventTypes AS
(
	SELECT
		 EventID
		,Classification
	FROM OrderedClassification
	WHERE rid = 1

)
SELECT
	 EventID
	,Classification
FROM EventTypes
ON DUPLICATE KEY UPDATE
	Classification = VALUES(Classification);
