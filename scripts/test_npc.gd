extends CharacterBody2D

@onready var eyes_ray = $eyes
@onready var player= $"/root/Node2D/CharacterBody2D"

@onready var dea_s = $dead
@onready var alive = $alive


@onready var bake_time = $baker
@onready var agent = $NavigationAgent2D
var wanderPoint = preload("res://scenes/npc/wander_node.tscn")
@export var wanderPointsAmt:int
@export var baker_sec:float
var number:int = 1


var BaseSpeed = 100
var hp:int = 200
var bleed = 0
var down:bool = false
var dead:bool = false

@export var state = states.run
var danger
var goal
@onready var goal_node = $goal_help
var isBaked:bool = false

enum states {
	run,
	wander,
	idle,
	flee,
	attack,
	hide,
}

func _ready() -> void:
	bake_time.start(baker_sec)


func _process(_delta: float) -> void:
	state_machine()
	eyes()

	move_and_slide()

func state_machine():
	match state:
		states.run:
			#print(player.position.distance_to(position))
			var dir_dang = position.direction_to(player.position)
			goal_node.position += dir_dang*-1
			walk_to(goal_node.position)
			pass #run away from threat
		states.wander:
			pass 
		states.idle:
			pass #be a punching bag :D
		states.flee:
			pass #seek exit
		states.attack:
			pass #CHARGE!
		states.hide:
			pass #seek safe place

func bake_Wander():
	if isBaked == false:
		var bakedAmt:=0
		while wanderPointsAmt < bakedAmt:
		#for i in wanderPointsAmt:
			rand_goal()
			bakedAmt +=1
			var point = get_node("Wander" + str(number-1))
			agent.target_position = point.global_position
			if agent.is_target_reachable():
				pass
				print("reachable :3")
			else: point.queue_free();number-=1;print("deleted");bakedAmt-=1
	isBaked = true


func walk_to(pos:Vector2):
	var nav_point_dir = (agent.get_next_path_position() - global_position).normalized()
	velocity = velocity.lerp(nav_point_dir * hp, 1)
	agent.target_position = pos

func rand_goal():
	var newPoint = wanderPoint.instantiate()
	newPoint.position = self.position
	newPoint.position += Vector2(randi_range(-1000,1000),randi_range(-1000,1000))
	newPoint.name = "Wander" + str(number)
	add_child(newPoint)
	number +=1



func eyes():
	eyes_ray.enabled = true
	var target = eyes_ray.get_collider()
	eyes_ray.look_at(player.position)
	if eyes_ray.is_colliding() and target.is_in_group("wall"):
		eyes_ray.enabled = false
	elif eyes_ray.is_colliding() and target.is_in_group("danger"):
		danger = target
		state = states.run


func _on_baker_timeout() -> void:
	bake_Wander()


func _on_thinker_timeout() -> void:
	if agent.target_position != goal_node.global_position:
		agent.target_position = goal_node.global_position

	$NavigationAgent2D/thinker.start()
