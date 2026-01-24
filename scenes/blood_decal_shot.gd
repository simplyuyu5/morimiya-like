extends Node2D

var type:String
var fram:int

@onready var bleed_sprite = $bleed

func _ready() -> void:
	bleed()

func bleed():
	match type:
		"bleed":
			bleed_sprite.animation = type
			bleed_sprite.show()
			bleed_sprite.set_frame(fram)
			
