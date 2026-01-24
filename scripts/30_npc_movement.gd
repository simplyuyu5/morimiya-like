extends CharacterBody2D

var hp = 120
var bleed = 0
var acceleration = 1
var walking := false
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

var goal# = goal_node


enum states {
	CALM,
	WANDER,
	RUN,
	ATTACK
}
var state_cur = states.CALM

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
	skins(randi_range(0,3))
	goal = goal_node
	agent.target_position = goal.global_position

func _process(_delta:float):

	var nav_point_dir = (agent.get_next_path_position() - global_position).normalized()
	velocity = velocity.lerp(nav_point_dir * hp, acceleration)
	alive.rotation = velocity.angle()

	if hp_man.is_dead == false:
		hp_man.hp_func()
		eyes()
		state()
	else:
		pass

	move_and_slide()

func state():

	var player= $"/root/Node2D/CharacterBody2D"

	match state_cur:
		states.CALM:
			await get_tree().create_timer(1).timeout
			state()
		states.WANDER:
			#print(velocity, " ", walking)
			if walking == false and agent.is_target_reachable() == true:
				goal_randi()
				walking = true
				await get_tree().create_timer(3).timeout
				if agent.is_target_reached() == true:
					walking = false
					#state()
				else:
					pass
			elif agent.is_target_reachable() == false:
				goal_randi()
		states.RUN:
			goal_node.position = position.direction_to(player.position)
			goal = goal_node
		states.ATTACK:
			pass

func goal_randi():
	goal_node.position = Vector2i(randi_range(-300,300),randi_range(-200,200)) + Vector2i(position)
	goal = goal_node

func skins(num):
	dead.frame = num
	alive.frame = num

func eyes():
	var player= $"/root/Node2D/CharacterBody2D"

	eyes_ray.enabled = true
	var target = eyes_ray.get_collider()
	eyes_ray.look_at(player.position)
	if eyes_ray.is_colliding() and target.is_in_group("wall"):
		eyes_ray.enabled = false
	elif eyes_ray.is_colliding() and target.is_in_group("danger"):
		state_cur = states.WANDER

func die():
	eyes_ray.enabled = false
	eyes_ray.target_position = Vector2i(0,0)
	hp_man.is_dead = true
	collision.disabled = true
	alive.hide()

	dead.rotation_degrees = randf_range(0,360)
	dead.show()



func decal_bleed():
	var blood = preload("res://scenes/blood_decal_shot.tscn").instantiate()
	blood.position = position + Vector2(randi_range(-30,30),randi_range(-30,30))
	blood.rotation = randi_range(0,360)
	blood.type = "bleed"
	blood.fram = randi_range(0,6)
	add_sibling(blood)

func _on_nav_timer_timeout() -> void:
	if agent.target_position != goal_node.global_position:
		agent.target_position = goal_node.global_position

	timer_nav.start()
