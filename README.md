# Curling Analytics
## Author: Robert Currie
## Last Update: March 27, 2021

This repository holds code used to scrape and process [CurlingZone](http://www.curlingzone.com) linescores for analytics development. 

General setup of the repository is as follows:
* The home directories, e.g. config, analysis, scraping, pivoting...etc. contain the Python libraries / modules wrote to support scraping, ETL, analysis, etc. 
* The work directory contains the work done, e.g. ETL, analysis. 

General process was:
* Scrape linescores / rankings / team information off of the website. 
* Store in a MariaDB MySQL database on a raspberry pi. 
* Clean-up, validate, ETL information.
* Analyze. 

Medium articles written: 
1. [Scoring in Curling — Do Games From Different Events Look Different?](https://medium.com/@robert.art.currie/scoring-in-curling-do-games-from-different-events-look-different-90c3588c46d7)

## Directory
* [config](/config): Module with DB connection and other misc. parameters.
* [analysis](/analysis): Module with helper functions used for during analysis. 
* [scraping](/scraping): Custom library for scraping linescores. 
* [processing](/processing): Module with helper functions for ETL / data clean-up work.
* [pivoting](/pivoting): Module for pivoting linescores into analysis-friendly format.
* [work](/work): Contains scripts / notebooks for carrying out the work. 
	* [ETL](/work/ETL): Contains DDL & ETL scripts for scraping, transforming and cleaning up the data.
	* [Analysis](/work/Analysis): Contains notebooks / scripts for carrying out analysis. 
	
## Interesting Files
* [Scoring in Curling - Medium article notebook](/work/Analysis/LinescoreAnalysis/LinescoreAnalysis.ipynb)
* [Scenario win percentages notebook](/work/Analysis/WinPcts/ScenarioWinPct.ipynb)
* [Linescore scraping notebook](/work/ETL/landing/ScrapingNotebook-Linescores.ipynb)





