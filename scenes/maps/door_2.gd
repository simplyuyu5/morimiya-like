extends StaticBody2D

var size = 2
@export var locked :bool = false
@export var is_open:bool = false
@export var type:String
@onready var sprite = $AnimatedSprite2D
@onready var doorc = $Closed
#@onready var openc = $open
#types: yel, grey

func _ready() -> void:
	if is_open == true:
		open()
	else:
		close()

func interact():
	match is_open:
		true:
			close()
		false:
			open()

func open():
	if locked == false:
		sprite.play("open_2_" + type)
		doorc.disabled = true
		is_open = true
func close():
	sprite.play("closed_2_" + type)
	doorc.disabled = false
	is_open = false
