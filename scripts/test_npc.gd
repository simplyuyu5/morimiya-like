extends CharacterBody2D

@onready var eyes_ray = $eyes
@onready var player= $"/root/Node2D/CharacterBody2D"


var BaseSpeed = 100
var hp:int = 200
var down:bool = false
var dead:bool = false

var state
var danger

enum states {
	run,
	idle,
	flee,
	attack,
	hide,
}

func state_machine():
	match state:
		states.run:
			pass #run away from threat
		states.idle:
			pass #be a punching bag :D
		states.flee:
			pass #seek exit

var target = eyes_ray.get_collider()
func eyes():
	eyes_ray.enabled = true

	eyes_ray.look_at(player.position)
	if eyes_ray.is_colliding() and target.is_in_group("wall"):
		eyes_ray.enabled = false
	elif eyes_ray.is_colliding() and target.is_in_group("danger"):
		danger = target
		state = states.run
