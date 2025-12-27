extends Area2D

var is_dead :bool = false
@onready var dead = $dead
@onready var alive = $alive
#@onready var agent = $NavigationAgent2D
var hp = 100

@export var goal :Node = null

func _physics_process(_delta: float) -> void:

	if hp <= 1:
		hp = 0

	if hp == 0 and is_dead == false:
		is_dead = true
		die()

func die():
	get_parent().death()
	dead.rotate(randf_range(0,360))
	dead.show()
	$CollisionShape2D2.disabled = true
	$NavigationAgent2D.target_position = global_position
	alive.queue_free()
