extends CharacterBody2D
@onready var agent = $Area2D/NavigationAgent2D
var goal= null
@onready var that_guy_who_i_hate = $CollisionShape2D
@onready var help = $Area2D
@onready var my_time = $Timer
@onready var wander_goal = $wander
@onready var idle_goal = $idle
@onready var body = $Area2D
@export var state = states_coward.WANDER
var danger: Area2D
var acceleration = 0.90

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
	#goal = idle_goal
	agent.target_position = goal.global_position

func _process(_delta: float) -> void:

	debug()

	var nav_point_dir = (agent.get_next_path_position() - global_position).normalized()

	velocity =velocity.lerp(nav_point_dir * help.hp, acceleration)
	#velocity = nav_point_dir * (help.hp)
	help.rotation = velocity.angle()
	that_guy_who_i_hate.rotation = velocity.angle() #npc rotates where he goes
	
	move_and_slide()


	#walk()


func walk():
	pass

func states():
	match state:

		states_coward.CALM:
			var i = randi_range(2,10)
			print(i)
			await get_tree().create_timer(i).timeout
			state = states_coward.WANDER
			states()

		states_coward.WANDER:
			change_goal_rand()
			await get_tree().create_timer(3).timeout
			if agent.distance_to_target() <= 10:
				change_goal_rand()

		states_coward.PANIC:
			wander_goal.position -= self.position.direction_to(danger.position) * help.hp
			goal = wander_goal
			if agent.distance_to_target() <= 10:
				wander_goal.position -= self.position.direction_to(danger.position) * help.hp

		#var i = randi_range(0,1)
		#print(i," chance")
		#if i == 1:
			#change_goal()
		#else:
			#state = states_coward.CALM

func change_goal_rand():
	wander_goal.position = Vector2i(randi_range(-300,300),randi_range(-200,200)) + Vector2i(position)
	goal = wander_goal

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
		states()
	else: 
		state = states_coward.WANDER
		


func _on_panic_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("danger"):
		print("phew")
		state = states_coward.WANDER
		change_goal_rand()

func death():
	$panic_area/CollisionShape2D.disabled = true
	
