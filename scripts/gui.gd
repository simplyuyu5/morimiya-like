extends CanvasLayer

@onready var label_rou = $rounds
@onready var label_mag = $mags
@onready var label_chance = $chance
@onready var weapon_icon = $weapon
@onready var reloadbar = $reloadbar
@onready var killed = $stats/killed
@onready var injured = $stats/injured
@onready var fleed = $stats/fleed
@onready var parent = $"/root/Node2D/CharacterBody2D"
@onready var weapon = $"/root/Node2D/CharacterBody2D/weapons"
@onready var base = $"/root/Node2D/CharacterBody2D"
@onready var stats = $"/root/Node2D/CharacterBody2D/game_data"

@onready var loadout_scr = $loadout_screen
@onready var weapons_load = $loadout_screen/Panel/weapons


var progress_reload
var hidet := false


func gui():
	label_rou.text = str(weapon.rounds) + " rounds"
	label_mag.text = str(weapon.mags) + " mags"
	label_chance.text = str(weapon.chance_hit) +" %"
	weapon_icon.play(weapon.in_hands)

	if reloadbar.value >= 100:
		reloadbar.value = 0
		reloadbar.hide()
	else:
		pass

	killed.text = "Killed : " +str(stats.temp_killed)
	injured.text = "Injured : " +str(stats.temp_injured)
	fleed.text = "Fleed : " +str(stats.temp_fleed)

func gui_reload(time):
	hidet = false
	var tween = create_tween()
	reloadbar.show()
	tween.tween_property(reloadbar,"value",100,time)

func loadout():
	weapons_load.text = "Primary: " +str(weapon.current_prim)+ "\nSecondary: " +str(weapon.current_sec)+ "\nMeelee: " +str(weapon.current_melee)+ "\nExplosives: " + str(weapon.current_gren)
	loadout_scr.show()


func _on_close_loadout_pressed():
	loadout_scr.hide()


func _on_proceed_pressed() -> void:
	parent.proceed()
