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

def _get_scores(classification=0):
    sql = "CALL spGamesForAnalysis({})".format(classification)
    
    return pd.read_sql(sql,con=engine)

def get_scores(classification):
    if classification.lower() == 'women 10 end':
        return _get_scores(classification=0)
    elif classification.lower()  == 'men 10 end':
        return _get_scores(classification=1)
    elif classification.lower() == 'women 8 end':
        return _get_scores(classification=2)
    elif classification.lower() == 'men 8 end':
        return _get_scores(classification=3,)
    else:
        raise NotImplementedError("Invalid classification passed, soz")


def get_win_pcts(classification='men 8 end'):
    
    df = get_scores(classification=classification)
    
    cols = ['EndNum','EndSituation','Hammer','Win']
    
    assert all(
        
        [col in df.columns for col in cols]
        
    )
    
    col = cols.pop()
    
    return df.groupby(cols)[[col]].aggregate(['count','mean'])

def _get_win_pcts_matrix(classification,hammer=0):
    df = get_win_pcts(classification=classification)
    
    
    return df.loc(axis=0)[:,-5:5,hammer].reset_index(drop=False).pivot(index='EndNum',columns='EndSituation',values=('Win','mean'))


def get_win_pcts_matrix(classification,hammer):
    if classification.lower() == 'women 10 end':
        return _get_win_pcts_matrix(classification=classification,hammer=hammer)
    elif classification.lower()  == 'men 10 end':
        return _get_win_pcts_matrix(classification=classification,hammer=hammer)
    elif classification.lower() == 'women 8 end':
        return _get_win_pcts_matrix(classification=classification,hammer=hammer)
    elif classification.lower() == 'men 8 end':
        return _get_win_pcts_matrix(classification=classification   ,hammer=hammer)
    else:
        raise NotImplementedError("Invalid classification passed, soz")
        
