extends Area2D

@onready var dead = $Dead
@onready var alive = $living
var hp = 100


func _process(_delta: float) -> void:
	if hp <= 0:
		dead.show()
		alive.hide()
		#queue_free()
