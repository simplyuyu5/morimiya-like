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
@onready var weapon =weapons #$"/root/Node2D/CharacterBody2D/weapons"
@onready var base = $"/root/Node2D/CharacterBody2D"
@onready var stats = saveMain

@onready var loadout_scr = $loadout_screen
@onready var weapons_load = $loadout_screen/Panel/weapons


var progress_reload
var hidet := false

func _process(_delta: float) -> void:
	
	killed.text = "Killed : " +str(stats.temp_killed)
	#print(saveMain.temp_injured)
	injured.text = "Injured : " +str(saveMain.temp_injured)
	fleed.text = "Fleed : " +str(stats.temp_fleed)

func gui():
	label_rou.text = str(weapon.rounds) + " rounds"
	label_mag.text = str(weapon.mags) + " mags"
	label_chance.text = str(weapon.chance_hit) +" %"
	weapon_icon.play(weapons.in_hands)


	if reloadbar.value >= 100:
		reloadbar.value = 0
		reloadbar.hide()
	else:
		pass


func gui_reload(time):
	hidet = false
	var tween = create_tween()
	reloadbar.show()
	tween.tween_property(reloadbar,"value",100,time)

func loadout():
	weapons_load.text = "Primary: " +str(weapon.current_prim)+ "\nSecondary: " +str(weapon.current_sec)+ "\nMeelee: " +str(weapon.current_melee)+ "\nExplosives: " + str(weapon.current_gren)
	loadout_scr.show()

func icon_populate():
	var weap_icons = SpriteFrames.new()
	weapon_icon.sprite_frames = weap_icons
	for Name in weapons.primaries:
		var icon_path = weapons.primaries[Name]["sicon"]
		var path_cooked: CompressedTexture2D = load(icon_path)
		var full_image = path_cooked.get_image()
		#var texture_raw = Image.create(150,50,false,full_image.get_format())
		var texture = ImageTexture.create_from_image(full_image)#texture_raw)
		weap_icons.add_animation(Name)
		weap_icons.set_animation_loop(Name, false)
		weap_icons.set_animation_speed(Name, 1)
		weap_icons.add_frame(Name,texture)
		if weap_icons.has_animation(Name) == true:
			continue
		else: print(Name, " Failure!")
	for Name in weapons.secondaries:
		var icon_path = weapons.secondaries[Name]["sicon"]
		var path_cooked: CompressedTexture2D = load(icon_path)
		var full_image = path_cooked.get_image()
		#var texture_raw = Image.create(150,50,false,full_image.get_format())
		var texture = ImageTexture.create_from_image(full_image)#texture_raw)
		weap_icons.add_animation(Name)
		weap_icons.set_animation_loop(Name, false)
		weap_icons.set_animation_speed(Name, 1)
		weap_icons.add_frame(Name,texture)
		if weap_icons.has_animation(Name) == true:
			continue
		else: print(Name, " Failure!")
			

func end_show():
	$end_screen.show()
	$end_screen/Panel/points.text = "Points earned: " + str(saveMain.temp_points)
	$end_screen/Panel/stats_texts/kill.text = "Killed - "
	$end_screen/Panel/stats_texts/inj.text = "Injured - "
	$end_screen/Panel/stats_texts/flee.text = "Fleed - "
	#$end_screen/Panel/stats_texts/special
	$end_screen/Panel/info/weap.text = "weapon primary: " + weapon.current_prim + "\nweapon secondary: " + weapon.current_sec + "\ngrenades: " + weapon.current_gren + "\nmeelee: " + weapon.current_melee

func _on_close_loadout_pressed():
	loadout_scr.hide()


func _on_proceed_pressed() -> void:
	parent.proceed()
