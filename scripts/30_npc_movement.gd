extends CharacterBody2D

var hp = 120
var bleed = 0
var acceleration = 1
var walking := false
var direction = Vector2(0,0)


@onready var collision = $CollisionShape2D3
@onready var dead = $dead
@onready var alive = $alive
@onready var audio = $audio
@onready var eyes_ray = $eyes
@onready var hp_man = $hp
@onready var agent = $NavigationAgent2D
@onready var goal_node = $goal_node

@onready var player= $"/root/Node2D/CharacterBody2D"

@onready var timer_nav = $NavigationAgent2D/nav_timer
@onready var timer_sound = $audio/randi_sound

var goal# = goal_node
var danger


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
	skins(randi_range(0,4))
	goal = goal_node
	agent.target_position = goal.global_position

func _process(_delta:float):

	var nav_point_dir = (agent.get_next_path_position() - global_position).normalized()
	velocity = velocity.lerp(nav_point_dir * hp, acceleration)
	alive.rotation = velocity.angle()
	direction = goal_node.position.direction_to(player.position)

	hp_man.hp_func()
	eyes()
	state()

	move_and_slide()

func state():

	match state_cur:
		
		states.CALM:
			await get_tree().create_timer(1).timeout
			state()
		states.WANDER:
			if walking == false and agent.is_target_reachable() == true:
				goal_randi()
				walking = true
			elif agent.is_target_reachable() == false:
				goal_randi()
			else:
				pass
			if agent.is_target_reached() == true:
				walking = false
			else:
				pass
			
		states.RUN:

			if walking == false and agent.is_target_reachable() == true:
				goal_player_away()
				walking = true
			elif agent.is_target_reachable() == false:
				goal_reset()
				walking = false
			else:
				pass

			if agent.is_target_reached() == true:
				walking = false
			else:
				pass

		states.ATTACK:
			goal_node.position = player.position

func goal_randi():
	goal_node.position = Vector2i(randi_range(-300,300),randi_range(-200,200)) + Vector2i(position)
	goal = goal_node

func goal_player_away():
	goal_node.position -= direction*5 + Vector2(randf_range(-1,1),randf_range(-1,1))
	goal = goal_node

func goal_reset():
	goal_node.position = Vector2(0,0)
	goal = goal_node 

func skins(num):
	dead.frame = num
	alive.frame = num

func eyes():
	eyes_ray.enabled = true
	var target = eyes_ray.get_collider()
	eyes_ray.look_at(player.position)
	if eyes_ray.is_colliding() and target.is_in_group("wall"):
		eyes_ray.enabled = false
	elif eyes_ray.is_colliding() and target.is_in_group("danger"):
		danger = target
		state_cur = states.RUN


func die():
	eyes_ray.enabled = false
	eyes_ray.queue_free()
	hp_man.is_dead = true
	collision.free()
	alive.hide()

	dead.rotation_degrees = randf_range(0,360)
	dead.show()


func decal_bleed():
	var blood = preload("res://scenes/blood_decal_shot.tscn").instantiate()
	blood.position = position + Vector2(randi_range(-30,30),randi_range(-30,30))
	blood.rotation = randi_range(0,360)
	blood.type = "bleed"
	blood.fram = randi_range(0,6)
	#add_sibling(blood)
	get_tree().current_scene.add_child(blood)

func _on_nav_timer_timeout() -> void:
	if agent.target_position != goal_node.global_position:
		agent.target_position = goal_node.global_position

	timer_nav.start()
