"""
    Misc module for helping win pct analysis
    Date: March 20, 2021
"""

## library imports

## db con
from config import get_engine

## data manipulation
import pandas as pd


## con
database = 'dnorm'
engine= get_engine(database=database)

def get_scores(classification=0):
    sql = "CALL spGamesForAnalysis({})".format(classification)
    
    return pd.read_sql(sql,con=engine)

def get_win_pcts(classification=0):
    df = get_scores(classification=classification)
    
    cols = ['EndNum','EndSituation','Hammer','Win']
    
    assert all(
        
        [col in df.columns for col in cols]
        
    )
    
    col = cols.pop()
    
    return df.groupby(cols)[[col]].aggregate(['count','mean'])
