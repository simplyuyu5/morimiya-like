extends CharacterBody2D

var hp = 120
var bleed = 0
@onready var collision = $CollisionShape2D3
@onready var dead = $dead
@onready var alive = $alive
@onready var audio = $audio
@onready var eyes_ray = $eyes
@onready var hp_man = $hp
@onready var agent = $NavigationAgent2D
@onready var goal_node = $goal_node

@onready var timer_nav = $NavigationAgent2D/nav_timer
@onready var timer_sound = $audio/randi_sound

var goal = null
var player



enum states {
	CALM,
	WANDER,
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
	if hp_man.is_dead == false:
		hp_man.hp_func()
		eyes()
		state()
	else:
		pass

func state():
	match state_cur:
		states.CALM:
			await get_tree().create_timer(1).timeout
			state()
		states.WANDER:
			pass
		states.RUN:
			goal = goal_node
	

func skins(num):
	dead.frame = num
	alive.frame = num

func eyes():
	player= $"/root/Node2D/CharacterBody2D"

	eyes_ray.enabled = true
	var target = eyes_ray.get_collider()
	eyes_ray.look_at(player.position)
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


func _on_nav_timer_timeout() -> void:
	if agent.target_position != goal.global_position:
		agent.target_position = goal.global_position

	timer_nav.start()
