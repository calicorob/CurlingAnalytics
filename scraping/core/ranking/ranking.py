"""
    Module for scraping Curlingzone.com ranking
    Author: Robert Currie
    Date: March 14, 2021

"""

## library imports 

## data handling
import pandas as pd 

## regex
import re 

## scraping
from scraping.core.base import get_soup,find_all,find



def find_all_teams(soup):
    return find_all(soup=soup,name='td',attrs={'data-th':'Team'})
def find_all_ranks(soup):
    return find_all(soup=soup,name='td',attrs={'data-th':'Rank'})
def find_all_totals(soup):
    return find_all(soup=soup,name='td',attrs={'data-th':'Total'})
def find_all_ytds(soup):
    return find_all(soup=soup,name='td',attrs={'data-th':'YTD'})
    
def get_team_ranks(tags):
    return {
        
         "Rank":[tag.string.strip() for tag in tags]
        ,"TeamElementHash":[tag.parent.__hash__() for tag in tags]
        
        
    }

def get_team_ranks_from_soup(soup):
    tags = find_all_ranks(soup=soup)
    return get_team_ranks(tags=tags)

def get_team_ranks_frame_from_soup(soup):
    return get_frame(get_team_ranks_from_soup(soup=soup))

def get_team_totals(tags):
    return{
        
         "PointTotal":[tag.string.strip() for tag in tags]
        ,"TeamElementHash":[tag.parent.__hash__() for tag in tags]
        
    }

def get_team_totals_from_soup(soup):
    tags = find_all_totals(soup=soup)
    return get_team_totals(tags=tags)

def get_team_totals_frame_from_soup(soup):
    return get_frame(get_team_totals_from_soup(soup=soup))
    
def get_team_ytds(tags):
    return {
        
         "YTDPoints":[tag.string.strip() for tag in tags]
        ,"TeamElementHash":[tag.parent.__hash__() for tag in tags]
        
        
    }
def get_team_ytds_from_soup(soup):
    tags = find_all_ytds(soup=soup)
    return get_team_ytds(tags=tags)

def get_team_ytds_frame_from_soup(soup):
    return get_frame(get_team_ytds_from_soup(soup=soup))

def get_team_links(tags):
    return {
        
         "TeamLink":[tag.a['href'] for tag in tags if tag.a.string]
        ,"Name":[tag.a.string for tag in tags if tag.a.string]
        ,"TeamElementHash":[tag.parent.__hash__() for tag in tags if tag.a.string]
        
    }

def get_team_links_from_soup(soup):
    tags = find_all_teams(soup=soup)
    return get_team_links(tags=tags)

def get_team_links_frame_from_soup(soup):
    return get_frame(get_team_links_from_soup(soup=soup))

def get_frame(data,index=True):
    
    df = pd.DataFrame(data=data)
    
    if index:
        df=df.set_index(keys='TeamElementHash',drop=True)
        
    return df 

def scrape_all_rankings(url,year=None):
    soup = get_soup(url=url)
    
    team_links = get_team_links_frame_from_soup(soup)
    team_ytds = get_team_ytds_frame_from_soup(soup)
    team_totals = get_team_totals_frame_from_soup(soup)
    team_ranks = get_team_ranks_frame_from_soup(soup)
    
    df = pd.concat([team_links,team_ytds,team_totals,team_ranks],axis=1)
    
    df['Year'] = year

    
    return df
