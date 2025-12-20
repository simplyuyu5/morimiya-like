extends CharacterBody2D
@onready var agent = $NavigationAgent2D
var goal= null
@onready var help = $Area2D
@onready var my_time = $Timer
@export var state = states_coward.CALM

enum states_coward {
	PANIC,
	CALM,
	WANDER,
	HERO
}

var speed = 100

#func _ready() -> void:
	#
	#my_time.start()
	#agent.target_position = goal.global_position
	
func _process(_delta: float) -> void:
	var nav_point_dir = to_local(agent.get_next_path_position()).normalized()
	velocity = nav_point_dir * (help.hp)
	move_and_slide()

	states()
	#walk()


func walk():
	pass

func states():


	if state == states_coward.CALM:
		my_time.start(1)
	if state == states_coward.WANDER:
		goal = to_global(Vector2(randi_range(-20,20),randi_range(-20,20)))


#func _on_timer_timeout():
	#if agent.target_position != goal.global_position:
		#agent.target_position = goal.global_position
	#my_time.start()
