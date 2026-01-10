extends Node

@onready var parent = get_parent()
var hp = 120
var bleed := 0
var is_bleeding := false
var is_dead := false
var hp_saved = 120

func _process(_delta:float):
	hp = parent.hp 
	hp_func()

func hp_func():
	if hp <= 0:
		hp = 0

	if hp != hp_saved and bleed == 0:
		bleed = randi_range(0,2)
	else:
		bleed -=1

	if bleed >= 0 and is_bleeding == false:
		bleeding()
		await get_tree().create_timer(2 - bleed).timeout
		is_bleeding = false
	

	if hp <= 1 and is_dead != true:
		parent.die()

@onready var dead = $dead
@onready var alive = $alive

func skins(num):
	dead.frame = num
	alive.frame = num



func bleeding():
	if is_dead == false:
		is_bleeding = true
		hp -= bleed
		hp_saved = hp
		print(bleed, " bleed!")
	else:
		bleed = 0
