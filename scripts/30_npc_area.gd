extends Area2D

var hp = 120
var bleed := 0
var is_bleeding := false
var is_dead := false

func _ready() -> void:
	skins(randi_range(0,3))

func _process(_delta:float):
	if hp <= 0:
		hp = 0

	if hp <= 120:
		bleed = randi_range(0,2)

	if bleed >= 0 and is_bleeding == false:
		bleeding()
		await get_tree().create_timer(bleed * -1).timeout
		is_bleeding = false
	

	if hp <= 1 and is_dead != true:
		die()

@onready var dead = $dead
@onready var alive = $alive

func skins(num):
	dead.frame = num
	alive.frame = num

func die():
	is_dead = true
	$CollisionShape2D2.disabled = true
	alive.hide()
	dead.rotation_degrees = randf_range(0,360)
	dead.show()


func bleeding():
	if is_dead == true:
		is_bleeding = true
		hp -= bleed
	else:
		bleed = 0
