extends Node

@export var parent_help:CharacterBody2D
var blood = preload("res://scenes/blood_decal_shot.tscn").instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
@onready var parent = get_parent()
var hp = 120
var bleed = 0
var is_bleeding:bool= false
var is_dead:bool= false
var hp_saved = 120

func _ready():
	parent.hp = hp_saved
	hp = hp_saved
	pass

func _process(_delta:float):
	bleed = parent.bleed
	if parent.hp <= 0:
		parent.hp = 0
	hp = parent.hp 

func hp_func():
	if bleed > 0 and is_bleeding == false:
		bleeding()
		await get_tree().create_timer(2 - bleed/10).timeout
		is_bleeding = false
	else:
		pass
	

	if hp <= 1 and is_dead != true:
		parent.die()



func bleeding():
	if is_dead == false:
		is_bleeding = true
		hp -= bleed
		hp_saved = hp
		parent.bleed -=1

		parent.decal_bleed()

		print(bleed, " bleed!")
	else:
		bleed = 0
