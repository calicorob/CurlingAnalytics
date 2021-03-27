# Curling Analytics
## Author: Robert Currie
## Last Update: March 27, 2021

This repository holds code used to scrape and process [CurlingZone](http://www.curlingzone.com) linescores for analytics development. 

Medium articles written: 
1. [Differences in linescores article](https://medium.com/@robert.art.currie/scoring-in-curling-do-games-from-different-events-look-different-90c3588c46d7)

## Directory
* [config](/config): Module with DB connection and other misc. parameters.
* [analysis](/analysis): Module with helper functions used for during analysis. 
* [scraping](/scraping): Module for scraping linescores. 
* [processing](/processing): Module with helper functions for ETL / data clean-up work.
* [pivoting](/pivoting): Module for pivoting linescores into analysis-friendly format.
* [work](/work): Contains scripts / Notebooks for carrying out the work. 
	* [ETL](/work/ETL): Contains DDL / ETL scripts for scraping, transforming and cleaning up the data.
	* [Analysis](/work/Analysis): Contains Notebooks / scripts for carrying out analysis. 
	
## Articles
* [Differences in linescore article notebook](/work/Analysis/LinescoreAnalysis/LinescoreAnalysis.ipynb)



