extends Node2D

var shell_look :int = 0
@onready var parent = get_parent()

@onready var fmj = $fmj
@onready var g12 = $g12
@onready var smol = $smol

func _ready() -> void:
	looks()

func _process(delta: float) -> void:
	looks()

func looks():
	match shell_look:
		0: fmj.show(); g12.hide(); smol.hide();
		1: fmj.hide(); g12.show(); smol.hide();
		2: fmj.hide(); g12.hide(); smol.show();
