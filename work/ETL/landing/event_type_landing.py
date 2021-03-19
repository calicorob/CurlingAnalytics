"""
	Misc script for pushing Event type info to SQL

"""

## library imports 

## db connection
from config import get_engine

## data IO / manipulation
import pandas as pd

## columns to import from CSV
columns = ['EventID','Classification']

## file name
file_name = 'EventDataWithClasses.csv'

## misc parameters
if_exists='append'
index=False
table_name = 'EventType'

## db engine
database='landing'
engine = get_engine(database=database)

## read in CSV
df = pd.read_csv(file_name,usecols=columns)

## push to SQL 
df.to_sql(table_name,con=engine,if_exists=if_exists,index=index)
