extends Resource
class_name GameData

var points_saved = 0
var games_saved = 0
var deaths_saved = 0
var shots_saved = 0
var kills_saved = 0

func save(points,games,deaths,shots,kills):
	points_saved =points
	games_saved  =games
	deaths_saved =deaths
	shots_saved  =shots 
	kills_saved  =kills
	#look they are lined :D
	#this code is stupid as hell.
