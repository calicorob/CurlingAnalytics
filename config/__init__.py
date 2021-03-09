"""
    Misc. file for holding database connection parameters
    Author: Robert Currie
    Date: Feb 24, 2021

"""


## library imports
from sqlalchemy import create_engine

## default values
USER = 'scraper'
PASSWORD = 'scraper'
HOST = 'localhost'



def get_con_string(database,user=USER,password=PASSWORD,host=HOST):
    """
        Return a pymysql connection string
    
    """
    
    return "mysql+pymysql://{}:{}@{}/{}".format(user,password,host,database)


def get_engine(database,user=USER,password=PASSWORD,host=HOST):
    """
        Return a SQL alchemy engine
    
    """
    
    conn_string = get_con_string(database=database,user=user,password=password,host=host)
    
    return create_engine(conn_string)
    