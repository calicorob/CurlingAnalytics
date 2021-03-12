"""
    Module for scraping Curlingzone.com linescores
    Author: Robert Currie
    Date: January 31, 2021

"""

## library imports 

## data handling
import pandas as pd 

## regex
import re 

## scraping
from scraping.core.base import get_soup,find_all,find


def get_event_id_from_url(url):
    """
        Search and return the eventid from the curlingzone url
        
        Args:
            url (str): URL of the page to be scrapped
            
        Returns:
            string, event id of the webpage 
    
    
    """
    
    return re.search(r"(?<=eventid=)(\d+)",url)[0]


def find_all(soup,**kwargs):
    """
        Returns all the PagElements which match a given criteria
        See BeautifulSoup find_all documentation
        
        Args:
            soup (BeautifulSoup): BeautifulSoup object containing the web page content
            
        Returns:
            list of PageElements
    
    
    """
    return soup.find_all(**kwargs)

def find(soup,**kwargs):
    return soup.find(**kwargs)

def find_all_linescorehammers(soup):
    
    return find_all(soup,name='td',attrs={'class':['linescorehammer']})

def find_all_linescoreteams(soup):
    return find_all(soup,name='td',attrs={'class':['linescoreteam']})

def find_all_linescorefinals(soup):
    return find_all(soup,name='td',attrs={'class':['linescorefinal']})

def find_all_linescores(soup):
    return find_all(soup,name='td',attrs={'class':['linescoreend']})

def find_all_linescoreheads(soup):
    return find_all(soup,name='td',attrs={'class':'linescorelogo'})

def get_draw_from_soup(soup):
    return find(soup,name='option',attrs={'selected':'selected'}).string.strip()

def get_event_dates_from_soup(soup):
    return find(soup,name='div',attrs={'class':"badge-widget"}).string.strip()

def get_event_name_from_soup(soup):
    return find(soup,name='title').string.strip()

def get_num_draws_from_soup(soup):
    return len(find_all(soup,name='option'))

def get_team_names_from_soup(soup):
    tags = find_all_linescoreteams(soup)
    return get_team_names(tags)

def get_team_names_frame_from_soup(soup):
    return get_frame(get_team_names_from_soup(soup))

def get_final_scores_from_soup(soup):
    tags = find_all_linescorefinals(soup)
    
    return get_final_scores(tags)

def get_final_scores_frame_from_soup(soup):
    return get_frame(get_final_scores_from_soup(soup))

def get_linescore_hammers_from_soup(soup):
    tags = find_all_linescorehammers(soup)
    
    return get_linescorehammers(tags)

def get_linescore_hammers_frame_from_soup(soup):
    return get_frame(get_linescore_hammers_from_soup(soup))


def get_team_links_from_soup(soup):
    tags = find_all_linescoreheads(soup=soup)
    return get_team_links(tags)

def get_team_links_frame_from_soup(soup):
    return get_frame(data=get_team_links_from_soup(soup))

def get_linescores_from_soup(soup):
    tags = find_all_linescores(soup)
    
    return get_linescores(tags)

def get_linescores_frame_from_soup(soup):
    return get_frame(get_linescores_from_soup(soup),index=False)

def get_transformed_linescores_frame_from_soup(soup):
    return transform_scores_frame(get_linescores_frame_from_soup(soup))

def get_team_names(tags):
    return {
        
         'Team':[tag.b.string.strip() for tag in tags]
        ,'TeamElementHash':[tag.__hash__() for tag in tags]
        
    }

def get_team_links(tags):
    parents = [find(tag.parent,name='td',attrs={'class':['linescoreteam']}) for tag in tags]

    return {
        
        "TeamLink":[tag.a['href'] for tag in tags]
        ,"TeamElementHash":[parent.__hash__() for parent in parents]


    }

def get_final_scores(tags):
    
    parents = [find(tag.parent,name='td',attrs={'class':['linescoreteam']}) for tag in tags]
    return{
        
         'FinalScore':[tag.b.string.strip() for tag in tags]
        ,'TeamElementHash':[parent.__hash__() for parent in parents]
        
    }

def get_linescorehammers(tags):
    parents = [find(tag.parent,name='td',attrs={'class':['linescoreteam']}) for tag in tags]
    
    return{
        
         "Hammer":[bool(tag.img) for tag in tags]
        ,"TeamElementHash":[parent.__hash__() for parent in parents]
        
        
    }

def get_linescores(tags):
    parents = [find(tag.parent,name='td',attrs={'class':['linescoreteam']}) for tag in tags]
    return {
        
        
         'Scores':[tag.string.strip() for tag in tags]
        ,"TeamElementHash":[parent.__hash__() for parent in parents]
        
        
    }

def get_opponents(tags):
    opponents = {}
    
    
    for tag in tags:
        if find(tag.parent.find_next_sibling(),name='td',attrs={'class':['linescoreteam']}):
            opponents[tag.__hash__()] = find(tag.parent.find_next_sibling(),name ='td',attrs={'class':['linescoreteam']}).__hash__()
        else:
            opponents[tag.__hash__()] = find(tag.parent.find_previous_sibling(),name='td',attrs={'class':['linescoreteam']}).__hash__()


    return {
        
         "TeamElementHash":[key for key in opponents.keys()]
        ,"OpponentElementHash":[opponents[key] for key in opponents.keys()]
        
        
    }

def get_opponents_frame_from_soup(soup):
    tags = find_all_linescoreteams(soup)
    return get_frame(get_opponents(tags))
            
def get_frame(data,index=True):
    
    df = pd.DataFrame(data=data)
    
    if index:
        df=df.set_index(keys='TeamElementHash',drop=True)
        
    return df 


def transform_scores_frame(scores_frame):
    dfs = []
    
    for hash_ in scores_frame.TeamElementHash.unique():
        df = scores_frame.loc[scores_frame.TeamElementHash == hash_].copy()
        df['End'] = ["".join(["End",str(end+1)]) for end in range(len(df))]
        dfs.append(df)
        
    assert len(dfs) > 0, "No linescores to stack"
        
    return pd.concat([df.pivot(index='TeamElementHash',values='Scores',columns='End') for df in dfs],sort=True,axis=0)



def scrape_all_games(url,verify=True,game_id=1):
    
    soup = get_soup(url,verify=verify)
    
    team_names = get_team_names_frame_from_soup(soup)
    final_scores = get_final_scores_frame_from_soup(soup)
    hammer = get_linescore_hammers_frame_from_soup(soup)
    linescores = get_transformed_linescores_frame_from_soup(soup)
    opponents = get_opponents_frame_from_soup(soup)
    team_links = get_team_links_frame_from_soup(soup)
    
    df = pd.concat([team_names,final_scores,hammer,linescores,opponents,team_links],axis=1)
    
    mapping = get_game_id_mapping(df,game_id=game_id)
    
    df = apply_game_id_mapping(df,mapping)
    
    df = df.reset_index(drop=True)
    
    df = df.drop('OpponentElementHash',axis=1)
    
    draw = get_draw_from_soup(soup)
    
    df['Draw'] = draw
    
    df['EventDates'] = get_event_dates_from_soup(soup)
    
    df['EventID'] = get_event_id_from_url(url)
    
    df['EventName'] = get_event_name_from_soup(soup)
    
    
    return df 
    
    
def get_game_id_mapping(scores_frame,game_id=1):
    df = scores_frame.copy()
    mapping = dict()
    
    assert df.index.name == 'TeamElementHash'
    assert 'OpponentElementHash' in df.columns
    
    
    for team_hash,opp_hash in zip(df.index,df.OpponentElementHash):
        if team_hash not in mapping.keys() and opp_hash not in mapping.keys():
            mapping[team_hash] = game_id

        elif team_hash not in mapping.keys() and opp_hash in mapping.keys():
            mapping[team_hash] = game_id
            game_id +=1 
            
    assert len(mapping) == len(df),"Error mapping GameIDs"
            
    return mapping


def apply_game_id_mapping(scores_frame,mapping):
    df = scores_frame.copy()
    
    assert df.index.name =='TeamElementHash',"TeamElementHash is not the linescore index"
    
    df['GameID'] = df.index.map(mapping)
    
    return df



