"""
	Script for extracting event info data from the db
	Date: March 18, 2021

"""

## library imports

import pandas as pd
from config import get_engine

## misc parameters
database = "event"

## engine db
engine = get_engine(database=database)


## sql query
sql = """

	SELECT *
	FROM Event;

      """

## read in data 
df = pd.read_sql(sql,con=engine)

## export to csv 
df.to_csv("EventData.csv",index=False)
