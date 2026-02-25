extends Node

@export var player :CharacterBody2D
@export var gui:bool
@export var shoot:bool
@export var move:bool
@export var equipnu:bool


func _enter_tree() -> void:
	translate()
	print(self.get_class())

func translate():
	player.gui_show = gui
	player.homicidin = shoot
	player.movable = move
	player.equip = equipnu
	queue_free()
