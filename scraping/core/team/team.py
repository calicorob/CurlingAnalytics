"""
    Module for scraping Curlingzone.com teams
    Author: Robert Currie
    Date: March 11, 2021

"""

## library imports 

## data handling
import pandas as pd 

## regex
import re 

## scraping
from scraping.core.base import get_soup,find_all,find


def find_teamlist(soup):
	return find_all(soup=soup,name='td',attrs={'class':'teamlist'})

def get_players(tags):
	return [tag.find_next_sibling() for tag in tags if tag.find_next_sibling()]

def get_player_tags_from_soup(soup):
	tags = find_teamlist(soup)

	return get_players(tags=tags)

def get_player_info_from_soup(soup):
	tags = get_player_tags_from_soup(soup)

	return {
		  
		 "TeamHash":[tag.parent.parent.__hash__() for tag in tags]
		,"TeamLink":[find(tag.parent.parent,name='a',attrs={'class':'teamlink'})['href'].strip() for tag in tags]
		,"TeamClub":[find(tag.parent.parent,name='font',attrs={'class':'teamclubtown'}).string.strip() for tag in tags]
		,"Position":[tag.find_previous_sibling().b.string.strip() for tag in tags]
		,"Player":[tag.b.string.strip() for tag in tags]


	}
def get_player_info_frame_from_soup(soup):
	return pd.DataFrame(data=get_player_info_from_soup(soup))
	
def scrape_all_teams(url,verify=True,team_id =1,year=None):
	soup = get_soup(url=url,verify=verify)
	
	df = get_player_info_frame_from_soup(soup=soup)
	df['TeamID'] = df.groupby(['TeamHash']).ngroup() + team_id
	df['Year'] = year
	df = df.drop(['TeamHash'],axis=1)
	
	return df 
