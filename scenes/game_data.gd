extends Node

#stats for run/temporary:
var temp_injured:int = 0
var temp_killed:int = 0
var temp_fleed:int = 0

var injured:bool

var hangman:bool
var special_npc2:bool
var special_npc3:bool

var strange:bool #have to do smth w cultist i guess

var temp_shots:int = 0
var temp_throws:int = 0

var temp_points:int = 0

enum bonuses {
	mori, #no suicide
	hangman, #special npc kill
	untouched, #injured is false, no dmg received
	cultist #second char >:D
}

#global statssss:
var total_killed:int = 0
var total_injured:int = 0
var total_fleed:int = 0
var total_shots:int = 0
var total_throws:int = 0
var deaths:int = 0

var total_points:int = 0

func save():
	pass

func temporary_save():
	temp_fleed += total_fleed
	temp_injured += total_injured
	temp_killed += total_killed
	temp_points += total_points
	temp_shots += total_shots
	temp_throws += total_throws

func run_points():
	temp_points = (temp_killed*10) + (temp_injured*5) + (temp_shots*3) - (temp_fleed*5)  
	if hangman == true:
		temp_points += 500
	if special_npc2 == true:
		temp_points += 5000
	if special_npc3 == true:
		temp_points += 5000
	if strange == true:
		temp_points = temp_points/2
	temporary_save()
