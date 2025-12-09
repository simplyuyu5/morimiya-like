extends CharacterBody2D
@onready var area = $Area2D

var hp = 100

func _physics_process(delta: float) -> void:
	if hp <= 0:
		print("dead")
		queue_free()
