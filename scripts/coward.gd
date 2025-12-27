extends CharacterBody2D
@onready var agent = $Area2D/NavigationAgent2D
var goal= null
@onready var help = $Area2D
@onready var my_time = $Timer
@onready var wander_goal = $wander
@onready var idle_goal = $idle
@onready var body = $Area2D
@export var state = states_coward.WANDER
var danger: Area2D


#debug
@onready var state_label = $state_debug

func debug():
	state_label.text = str(state)

enum states_coward {
	PANIC,
	CALM,
	WANDER,
	HERO
}

var speed = 100

func _ready() -> void:
	
	states()
	var nav_point_dir = to_local(agent.get_next_path_position()).normalized()
	goal = idle_goal
	#my_time.start()
	agent.target_position = goal.global_position
	
func _process(_delta: float) -> void:

	debug()

	var nav_point_dir = to_local(agent.get_next_path_position()).normalized()
	velocity = nav_point_dir * (help.hp)
	help.rotation = velocity.angle()
	
	move_and_slide()


	#walk()


func walk():
	pass

func states():
#idea :D:
	#print(state)
# have Goal node, in WANDER state put it somewhere randomly instead of picking goal as some coordinate.!!!!
	if state == states_coward.CALM:
		var i = randi_range(2,10)
		print(i)
		await get_tree().create_timer(i).timeout
		state = states_coward.WANDER
		states()
	if state == states_coward.WANDER:
		change_goal()
	if state == states_coward.PANIC:
		goal = danger
		#var i = randi_range(0,1)
		#print(i," chance")
		#if i == 1:
			#change_goal()
		#else:
			#state = states_coward.CALM

func change_goal():
	wander_goal.position = Vector2i(randi_range(-300,300),randi_range(-200,200)) + Vector2i(position)
	goal = wander_goal


func looks():
	pass
	#look_at(goal.position)
	#var nav_point_dir = to_global(agent.get_next_path_position()).normalized()
	#velocity = nav_point_dir * (help.hp)


func _on_timer_timeout():
	if agent.target_position != goal.global_position:
		agent.target_position = goal.global_position

	my_time.start()


func _on_navigation_agent_2d_target_reached():
	#change_goal()
	states()


func _on_panic_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("danger"):
		print(area.name, " danger spotted")
		state = states_coward.PANIC
		danger = area


func _on_panic_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("danger"):
		print("phew")
		state = states_coward.WANDER
		change_goal()

func death():
	$panic_area/CollisionShape2D.disabled = true
	
