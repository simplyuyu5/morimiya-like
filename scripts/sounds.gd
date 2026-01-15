extends Node

var sex:String = "man"
var can_scream := true
#fem/man/ang

@onready var parent = get_parent()
@onready var audio_scream = $"/root/Node2D/tpo_npc/audio"
@onready var HELP = $"/root/Node2D/tpo_npc/audio/randi_sound"




func _on_randi_sound_timeout() -> void:
	HELP.start()
