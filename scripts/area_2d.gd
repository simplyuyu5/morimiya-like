extends Area2D

var hp = 100


func _process(delta: float) -> void:
	if hp <= 0:
		queue_free()
