extends CanvasLayer

@onready var label_rou = $rounds
@onready var label_mag = $mags
@onready var label_chance = $chance
@onready var weapon_icon = $weapon
@onready var reloadbar = $reloadbar
@onready var weapon = $"/root/Node2D/CharacterBody2D/weapons"

var progress_reload

#func _process(_delta: float):
	

func gui():
	label_rou.text = str(weapon.rounds) + " rounds"
	label_mag.text = str(weapon.mags) + " mags"
	label_chance.text = str(weapon.chance_hit) +" %"
	weapon_icon.play(weapon.in_hands)

	progress_reload; #unfinished, must tween here
	reloadbar.value = progress_reload

func gui_reload(time):
	var progress = 0
	var goal_prog = 100
	reloadbar.show()
	reloadbar.value = progress
	#lerp()
