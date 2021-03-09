## library imports

## default dict
from collections import defaultdict

## file IO, data processing
import pandas as pd

## linear algebra
import numpy as np

## class code

class Hammer(object):
	
	def __init__(self,hammer):
	
		## check if two teams are passed
		if len(hammer.items()) != 2:
			raise KeyError('Invalid hammer, {} entries passed'.format(len(hammer.items())))
			
		keys,values = tuple(hammer.keys()), tuple(hammer.values())
		
		## check team names are different
		assert values[0] != values[1],"Team names are not different"
		
		## check 1 and 0 is passed
		assert not all(keys),"Invalid hammer values passed"
		
		self.hammer= hammer.copy()
		
		
	def get_hammer(self):
		return self.hammer.copy()
			
	def get_next_hammer(self,end_result_obj):
		end_result = end_result_obj.get_end_result()
		current_hammer = self.get_hammer()
			
		## check teams match up
        
		hammer_teams = [team for team in current_hammer.values()]
		end_result_teams = [team for team in end_result.keys()]
			
		## I don't think I have to check the opposite 
		assert all(
			
			[team in end_result_teams for team in hammer_teams]
			
			
		),"Team mismatch"
			
		next_hammer = {}
			
		if end_result[current_hammer[1]] > 0:
			next_hammer[0] = current_hammer[1]
			next_hammer[1] = current_hammer[0]
		else:
			next_hammer[1] = current_hammer[1]
			next_hammer[0] = current_hammer[0]
				
				
		return Hammer(next_hammer)
		
	def to_frame(self):
		hammer = self.get_hammer()
		columns = ['Hammer','Team']
		situation = list(hammer.items())
			
		return pd.DataFrame(data=situation,columns=columns)
		
class EndResult(object):
	def __init__(self,end_result):
		
		## check two results (1 for each team)
		if len(end_result.items()) != 2:
			raise KeyError("Invalid end result {} entries passed".format(len(end_result.items())))
		
		self.end_result = end_result.copy()
	
	def get_end_result(self):
		return self.end_result.copy()
		
	def to_frame(self):
		end_result = self.get_end_result()
		
		columns = ['Team','EndResult']
		
		results = [[team,result] for team,result in end_result.items()]
        
		if results[0][1] > results[1][1]:
			results[1][1] = results[0][1]*-1
		else:
			results[0][1] = results[1][1]*-1
            
    
		return pd.DataFrame(data=results,columns=columns)
        
class Score(object):
	def __init__(self,score):
		## check two scores are passed (1 for each team)
		
		if len(score.items()) != 2:
			raise KeyError('Invalid score {} entries passed'.format(len(score.items())))
			
		teams,scores = tuple(score.keys()),tuple(score.values())
        
        
        ## check scores are higher than 0 
		assert all(
        
			[_score >= 0 for _score in scores]
        
		), "Invalid scores passed" 
        
		self.score =score.copy()
        
        
	def get_score(self):
		return self.score.copy()
		
	def to_frame(self):
		score = self.get_score()
		
		columns = ['Team','Score']
		
		situation = list(score.items())
		return pd.DataFrame(data=situation,columns=columns)
		
class End(object):
	def __init__(self,score_obj,hammer_obj,end_result_obj=None,end_num=1):
		
		self.end_num = end_num
		self.score_obj = score_obj
		self.hammer_obj = hammer_obj
		self.end_result_obj = end_result_obj
		
	def get_end_num(self):
		return self.end_num
		
	def get_score_obj(self):
		return self.score_obj
		
	def get_hammer_obj(self):
		return self.hammer_obj
		
	def get_end_result_obj(self):
		return self.end_result_obj
	
	def get_next_end(self,end_result_obj):
		end_result = end_result_obj.get_end_result()
		
		score_obj = self.get_score_obj()
		score = score_obj.get_score()
		
		hammer_obj = self.get_hammer_obj()
		next_hammer_obj = hammer_obj.get_next_hammer(end_result_obj=end_result_obj)
		
		for team in score.keys():
			score[team] += end_result[team]
			
		next_score_obj = Score(score)
		self.end_result_obj = end_result_obj
		
		end_num = self.get_end_num()
		
		next_end_num = end_num + 1
		
		return End(score_obj = next_score_obj,hammer_obj=next_hammer_obj,end_result_obj=None,end_num=next_end_num)
		
	def to_frame(self):
		kwargs = {'how':'inner','on':'Team'}
		
		hammer_obj = self.get_hammer_obj()
		score_obj = self.get_score_obj()
		
		df = hammer_obj.to_frame()
		df['EndNum'] = self.get_end_num()
		
		end_result_obj = self.get_end_result_obj()
		
		if end_result_obj:
			df = df.merge(score_obj.to_frame(),**kwargs).merge(end_result_obj.to_frame(),**kwargs)
			
		else:
			df = df.merge(score_obj.to_frame(),**kwargs)
			df['EndResult'] = np.nan
		
		return df[['Team','EndNum','Hammer','Score','EndResult']]
		
class Game(object):
	def __init__(self,teams,game_id,final_score_obj=None):
		## check two teams are passed in list
		if len(teams) != 2:
			raise KeyError('Invalid number of teams passed, {} teams passed'.format(len(teams)))
		
		## check only distinct team names have been passed
		team_dict = defaultdict(int)
        
		for team in teams:
			team_dict[team] +=1
            
		assert all(
        
			[count == 1 for count in team_dict.values()]
        
        
		), "Same team is named twice"
        
		self.teams = teams.copy()
		self.game_id = game_id
		self.ends = []
        
		if final_score_obj:
			score = final_score_obj.get_score()
			score_teams = score.keys()
            
            ## I don't think I have to check the opposite 
			assert all(
        
				[team in score_teams for team in teams]
        
			),"Team mismatch"
        
        
			self.final_score_obj = final_score_obj
		else:
			self.final_score_obj = final_score_obj
            
	def get_ends(self):
		return self.ends.copy()
		
	def get_game_id(self):
		return self.game_id
		
	def add_end(self,end_obj):
		ends = self.get_ends()
		ends.append(end_obj)
		self.ends = ends.copy()
		
	def to_frame(self):
		df = pd.concat([end.to_frame() for end in self.get_ends()],axis=0,sort=True).reset_index(drop=True)
		df['GameID'] = self.get_game_id()
		return df
		
		
def create_game(game_id,games):
	ends = [1,2,3,4,5,6,7,8,9,10,11,12]
	ends = list(map(str,ends))
    
	df = games.loc[games.GameID == game_id]
	assert len(df) == 2
    
	teams = []
	final_score = {}
	hammer_situation = {}
    
	for score,team,hammer in df[['FinalScore','Team','Hammer']].values:
		teams.append(team)
		final_score[team] = score
		hammer_situation[hammer] = team
        
	
	final_score_obj = Score(final_score)
	hammer_obj = Hammer(hammer_situation)
	game_obj = Game(teams=teams,game_id = game_id,final_score_obj = final_score_obj)
	end = End(score_obj=Score({team:0 for team in teams}),hammer_obj = hammer_obj)
	

	for e in ends:
		
		if end.get_score_obj().get_score() == final_score_obj.get_score():
			break
		result = EndResult({team:score for score,team in df[["End{}".format(e),'Team']].values})
		game_obj.add_end(end)
		end = end.get_next_end(end_result_obj=result)
		
	return game_obj
