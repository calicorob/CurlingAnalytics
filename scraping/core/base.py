## scraping
from bs4 import BeautifulSoup 

## also scraping 
import requests 


def get_soup(url,parser='html.parser',verify=True):
    """
        Gets the Beautifulsoup object which holds the data to be scrapped
        
        Args:
            url (str): URL of the page to be scrapped
            parser (str): Type of parser to be used 
        Returns:
            BeautifulSoup object
    
    
    """
    request = get_request_response(url,verify=verify)
    
    return BeautifulSoup(request.content,parser)

def get_request_response(url,verify=True):
    """
    
        Requests the content to be scrapped
        
        Args:
            url (url): URL of the page to be scrapped
            
        Returns:
            request object
    
    """
    
    return requests.get(url,verify=verify)



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


