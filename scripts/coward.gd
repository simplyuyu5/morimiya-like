extends CharacterBody2D
@onready var agent = $NavigationAgent2D
var goal= null
@onready var help = $Area2D
@onready var my_time = $Timer
@onready var wander_goal = $wander
@onready var idle_goal = $idle
@export var state = states_coward.WANDER

enum states_coward {
	PANIC,
	CALM,
	WANDER,
	HERO
}

var speed = 100

func _ready() -> void:
	
	goal = idle_goal
	#my_time.start()
	agent.target_position = goal.global_position
	
func _process(_delta: float) -> void:

	var nav_point_dir = to_local(agent.get_next_path_position()).normalized()
	velocity = nav_point_dir * (help.hp)
	
	
	
	move_and_slide()


	#walk()


func walk():
	pass

func states():
#idea :D:
	#print(state)
# have Goal node, in WANDER state put it somewhere randomly instead of picking goal as some coordinate.!!!!
	if state == states_coward.CALM:
		await get_tree().create_timer(randi_range(1,5)).timeout
		state = states_coward.WANDER
	if state == states_coward.WANDER:
		var i = randi_range(0,1)
		if i == 1:
			wander_goal.position = Vector2i(randi_range(-200,200),randi_range(-200,200))
			goal = wander_goal
		else:
			state = states_coward.CALM
			




func _on_timer_timeout():
	if agent.target_position != goal.global_position:
		agent.target_position = goal.global_position
	
	if agent.distance_to_target() <= 10:
		states()
	#states()
	my_time.start()
