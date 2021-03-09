"""
    Module for misc transformations of linescore data
    Author: Robert Currie
    Date: Feb 25, 2021

"""

import numpy as np


def strip(text):
    """
        Strips a string. If the passed arguement is not a string, return it. 
        
        Args:
            text (str): string to be stripped
        Returns:
            Stripped text, or original variable. 
    
    """
    
    if text and isinstance(text,str):
        return text.strip()
    else:
        return text
    
def replace_empty_string(text):
    """
        Replaces an empty string with a null value
        
        Args:
            text (str): string to be replaced
        Returns:
            Original arguement or np.nan
                
    """
    if text == '':
        return np.nan
    else:
        return text
    
def replace_finished_game_vals(text,vals_to_be_replaced=['X']):
    if text in vals_to_be_replaced:
        return np.nan
    else:
        return text
    
def map_season(year,month):
    if month >= 8:
        return "{}-{}".format(str(year),str(year+1))
    else:
        return "{}-{}".format(str(year-1),str(year))
    
    
if __name__=='__main__':
    ## misc tests
    
    ## strip
    assert strip(7) == 7
    assert strip('7 ') == '7'
    assert strip('')==''
    assert strip(None) == None
    assert np.isnan(strip(np.nan))
    
    ## replace_empty_string
    assert np.isnan(replace_empty_string(''))
    assert replace_empty_string('5') == '5'
    assert replace_empty_string(5) == 5
    assert replace_empty_string(True) 
    
    
    
    
    
    
    