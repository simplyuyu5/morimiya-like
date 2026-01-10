extends CharacterBody2D

var hp = 120
@onready var collision = $CollisionShape2D3
@onready var dead = $dead
@onready var alive = $alive
@onready var audio = $audio
@onready var eyes_ray = $eyes
@onready var hp_man = $hp



enum states {
	CALM,
	CROWD,
	RUN,
	ATTACK
}
var state_cur

var persons = {
	"Null":{
		"perc_":0
	},
	"Agressive":{
		"":0,
	},
}

@export var personality = persons["Agressive"]

func _ready() -> void:
	state_cur = states.CALM
	skins(randi_range(0,3))

func _process(_delta:float):
	eyes()
	state()

func state():
	match state_cur:
		states.CALM:
			print("calm")
	

func skins(num):
	dead.frame = num
	alive.frame = num

func eyes():
	eyes_ray.enabled = true
	var target = eyes_ray.get_collider()
	eyes_ray.look_at($"/root/Node2D/CharacterBody2D".global_position)
	if eyes_ray.is_colliding() and target.is_in_group("wall"):
		eyes_ray.enabled = false
	elif eyes_ray.is_colliding() and target.is_in_group("danger"):
		state_cur = states.RUN

func die():
	eyes_ray.enabled = false
	eyes_ray.target_position = Vector2(0,0)
	hp_man.is_dead = true
	collision.disabled = true
	alive.hide()
	dead.rotation_degrees = randf_range(0,360)
	dead.show()
