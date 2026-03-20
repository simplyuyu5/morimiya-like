extends Area2D

func interaction(source):
	if Input.is_action_just_pressed("p"):
		print(source)
		source.gui.loadout()
