extends CharacterBody2D

var hp := 120
var bleed := 0
var acceleration := 0.5
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
@onready var game_data = $"/root/Node2D/CharacterBody2D/game_data"

@onready var player= $"/root/Node2D/CharacterBody2D"

@onready var timer_nav = $NavigationAgent2D/nav_timer
@onready var timer_sound = $audio/randi_sound

var goal
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
	goal_reset()
	state_cur = states.WANDER

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
			match walking:
				true:pass
				false:
					if agent.is_target_reachable() == true:
						goal_randi()
					else:
						goal_reset()
						walking = false

			if agent.is_target_reached() == true:
				walking = false
				goal_randi()
			else:pass


		states.RUN:

			match walking:
				true:pass
				false:
					if agent.is_target_reachable() == true:
						goal_player_away()
					else:
						goal_reset()
						walking = false

			if agent.is_target_reached() == true:
				walking = false
				goal_player_away()
			else:
				pass

			await get_tree().create_timer(10).timeout
			state_cur = states.WANDER

		states.ATTACK:
			goal_node.position = player.position

func goal_randi():
	goal_node.position = Vector2(randi_range(-200,200),randi_range(-200,200))
	goal = goal_node

func goal_player_away():
	goal_node.position -= direction
	goal = goal_node

func goal_reset():
	goal_node.position = self.global_position
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
	game_data.temp_injured += -1
	game_data.temp_killed += 1
	hp_man.injured = false
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
	get_tree().current_scene.add_child(blood)

func _on_nav_timer_timeout() -> void:
	if agent.target_position != goal_node.global_position:
		agent.target_position = goal_node.global_position

	timer_nav.start()
