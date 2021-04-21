INSERT INTO event.Event
(
	 EventID
	,EventName
	,Year
	,StartMonth
	,EndMonth
	,EventDayStart
	,EventDayEnd
	,Season
	
)
WITH Events AS
(
	SELECT
		 EventID
		,EventName
		,Year
		,StartMonth
		,EndMonth
		,EventDayStart
		,EventDayEnd
	FROM dnorm.Linescore 
	GROUP BY
		 EventID
		,EventName
		,Year
		,StartMonth
		,EndMonth
		,EventDayStart
		,EventDayEnd

),
EventsWithMonthNumbers AS
(
	SELECT
		  e.EventID
		 ,e.EventName
		 ,e.Year
		 ,ml1.MonthNumber AS StartMonth
		 ,ml2.MonthNumber AS EndMonth
		 ,e.EventDayStart
		 ,e.EventDayEnd
		 ,CASE
			WHEN e.Year >= 6 
				THEN CONCAT(Year,'-',Year+1)
				ELSE CONCAT(Year-1,'-',Year+1)
		  END AS Season
	FROM Events e
	LEFT JOIN lookup.MonthLookup ml1
	ON ml1.Month = e.StartMonth
	LEFT JOIN lookup.MonthLookup ml2
	ON ml2.Month = e.EndMonth 
)
SELECT
	e.*
FROM EventsWithMonthNumbers e
LEFT JOIN event.Event ee
ON ee.EventID = e.EventID
WHERE ee.EventID IS NULL;
