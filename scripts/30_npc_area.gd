extends Node

var blood = preload("res://scenes/blood_decal_shot.tscn").instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
@onready var parent = get_parent()
var hp = 120
var bleed := 0
var is_bleeding:bool= false
var is_dead:bool= false
var hp_saved = 120

func _ready():
	pass

func _process(_delta:float):
	if hp <= 0:
		hp = 0
	hp = parent.hp 

func hp_func():
	if hp != hp_saved and bleed == 0:
		parent.add_child(blood)
		print("blood1")
		blood.position = parent.local_position - Vector2(10,0)
		bleed = randi_range(0,2)
	else:# hp != hp_saved and bleed >= 1:
		print("blood2")
		bleed -=1

	if bleed >= 0 and is_bleeding == false:
		bleeding()
		await get_tree().create_timer(2 - bleed).timeout
		is_bleeding = false
	

	if hp <= 1 and is_dead != true:
		parent.die()



func bleeding():
	if is_dead == false:
		is_bleeding = true
		hp -= bleed
		hp_saved = hp
		print(bleed, " bleed!")
	else:
		bleed = 0
