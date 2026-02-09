extends Node

@onready var player =  $"/root/Node2D/CharacterBody2D"
@export var gui:bool
@export var shoot:bool
@export var move:bool
@export var equipnu:bool


func _ready():
	player.gui_show = gui
	player.homicidin = shoot
	player.movable = move
	player.equip = equipnu
