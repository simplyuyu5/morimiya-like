extends CharacterBody2D
@onready var agent = $NavigationAgent2D
@export var goal :Node = null
@onready var help = $Area2D
@onready var my_time = $Timer

var speed = 100

func _ready() -> void:
	my_time.start()
	agent.target_position = goal.global_position
	
func _process(_delta: float) -> void:
	var nav_point_dir = to_local(agent.get_next_path_position()).normalized()
	velocity = nav_point_dir * (help.hp)
	move_and_slide()

	#walk()

#func walk():
	#if agent.is_target_reached():
		#var nav_point_dir = to_local(agent.get_next_path_position()).normalized()
		#velocity = nav_point_dir# * speed * (help.hp/10)
		#move_and_slide()


func _on_timer_timeout():
	if agent.target_position != goal.global_position:
		agent.target_position = goal.global_position
	my_time.start()
