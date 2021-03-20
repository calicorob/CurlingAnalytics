USE staging;
INSERT INTO event.EventType
(
	  EventTypeID
	 ,EventID
	 ,Classification

)
SELECT
	 ROW_NUMBER() OVER(ORDER BY(SELECT 1)) + (SELECT IFNULL(MAX(EventTypeID),0) FROM event.EventType) AS EventTypeID
	,EventID
	,Classification
FROM EventType
ON DUPLICATE KEY UPDATE
	Classification = VALUES(Classification);
	
