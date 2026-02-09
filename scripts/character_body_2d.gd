extends CharacterBody2D

@onready var ray = $ray_long
@onready var nothing_body = $ray_long/nothin
@onready var weapon = $weapons
@onready var ray_pick = $pickup_ray
@onready var body = $Mc
@onready var pos = $shell_pos
@onready var audio_shoot = $sounds/shoot
@onready var audio_reload = $sounds/reload
@onready var audio = $sounds/sounds_misc
@onready var gui = $gui
var shells = preload("res://scenes/shells.tscn")#.instantiate()
var gren = preload("res://scenes/grenade.tscn")
var shell_look :int = 0
var can_shoot := true
var can_reload := true
var movable := true

@onready var pew = $ray_long/pew
@onready var store = $store

var spread :bool = false
var weapon_under :bool = false
var pickup_under :bool = false
var under_name
var gui_show:bool = true
var homicidin:bool = false
var equip:bool = false

var health = 200
var speed_fin = 300
var strength = 20

func _ready() -> void:
	pew.play("nothing")
	#preload("res://scenes/shells.tscn")

func _process(_delta: float) -> void:
	if health <= -1:
		health = 0
	if equip == true:
		equip_ult()
	if movable == true:
		move()
		move_anim()
	else: pass
	
	if gui_show == true:gui.gui()
	else:gui.hide()


func _physics_process(_delta: float) -> void:
	
	if homicidin == true:
		change()
		shoot()
		reload()
		grenade()
	


	move_and_slide()

func shoot():
	ray.enabled = true
	var target = ray.get_collider()
	if Input.is_action_just_pressed("lmb") and weapon.rounds >= 1 and can_shoot == true:
		ray.target_position.x = weapon.dist
		nothing_body.position.x = weapon.dist - 1
		audio_shoot.play()
		gun_smoke(weapon.style)
		shell_eject(weapon.shell)

		if ray.is_colliding() and target.is_in_group("wall"):
			ray.enabled = false
		elif ray.is_colliding() and target.is_in_group("living"):
			if randf_range(0,100.0) <= float(weapon.chance_hit):
				target.hp -=weapon.damage
				target.bleed += randi_range(0,weapon.bleed_max)
		else:
			#print("miss lol")
			pass
		recoil()

		weapon.rounds -= weapon.shots
		if weapon.in_hands == weapon.current_prim:
			weapon.bank.rounds_prim = weapon.rounds
		elif weapon.in_hands == weapon.current_sec:
			weapon.bank.rounds_sec = weapon.rounds
		can_shoot = false
		await get_tree().create_timer(weapon.delay).timeout
		can_shoot = true


func reload():
	if Input.is_action_just_pressed("r") and weapon.mags >= 1 and can_reload == true:
		can_reload = false
		audio_reload.play(1)
		gui.gui_reload(weapon.reload_time)
		await get_tree().create_timer(weapon.reload_time).timeout
		if weapon.in_hands == weapon.current_prim:
			weapon.bank.mags_prim = weapon.mags - 1
		elif weapon.in_hands == weapon.current_sec:
			weapon.bank.mags_sec = weapon.mags - 1
		reloading_types()
	else:pass

func grenade():
	var gren_inst = gren.instantiate()
	if Input.is_action_just_pressed("g"):
		gren_inst.global_transform = pos.global_transform
		gren_inst.scale = Vector2(1,1)
		gren_inst.velocity_throw = strength
		#gren_inst.throw(weapon.current_gren)
		 
		add_sibling(gren_inst)



func reloading_types():
	can_reload = true
	match weapon.reload_type:
		"mag":
			if weapon.mags > 0:
				weapon.mags -=1
				weapon.rounds = weapon.rounds_max
		"pump":
			if weapon.mags > 0 and weapon.rounds <= weapon.rounds:
				weapon.mags -=1
				weapon.rounds += 1

func recoil():
	spread = true
	weapon.chance_hit -= weapon.recoil
	await get_tree().create_timer(3).timeout
	spread = false

func move():
	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.determinant() * Vector2(input_dir.x, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed_fin
		velocity.y = direction.y * speed_fin
	else:
		velocity.x = move_toward(velocity.x, 0, speed_fin)
		velocity.y = move_toward(velocity.y, 0, speed_fin)

func change():
	if Input.is_action_just_pressed("1"):
		weapon.in_hands = weapon.current_prim
		#weapon.assign_weapon_rounds(1)
		weapon.weapon_change(1)
	if Input.is_action_just_pressed("2"):
		weapon.in_hands = weapon.current_sec
		#weapon.assign_weapon_rounds(2)
		weapon.weapon_change(2)
	if Input.is_action_just_pressed("3"):
		weapon.in_hands = weapon.current_melee
		weapon.weapon_change(3)

func equip_ult():
	var target = ray_pick.get_collider()
	if ray_pick.is_colliding() and target.is_in_group("weapon_pick"):
		equip_weapon()
	if ray_pick.is_colliding() and target.is_in_group("weapons_desk"):
		store.init()
	if ray_pick.is_colliding() and target.is_in_group("interactable"):
		target.interaction()

func equip_weapon():
	var target = ray_pick.get_collider()
	if Input.is_action_just_pressed("p"):
			#print(target.name, " target")
			weapon.in_hands = target.name
			#print("picked up weapon! ", weapon.in_hands)
			weapon.weapon_change()
			target.free()
			ray_pick.enabled = false
			await get_tree().create_timer(1.0).timeout
			ray_pick.enabled = true
			
	else:
		pass






func move_anim():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("moving"):
		body.play("walk")
	else:
		body.play("idle")

func shell_eject(shell):
	var shell_inst = shells.instantiate()
	shell_inst.shell_look = shell

	shell_inst.global_transform = pos.global_transform
	shell_inst.position = pos.global_position + Vector2(randi_range(-5,5),randi_range(-5,5));
	shell_inst.rotation_degrees = pos.rotation_degrees
	shell_inst.rotation_degrees += randi_range(0,70)

	add_sibling(shell_inst)

func gun_smoke(style):
	match style:
		0:pew.play("pew_small")
		1:pew.play("pew_medium")
		2:pew.play("pew_big")
		5:pew.play("slash")

#func _on_pick_range_area_entered(area: Area2D):
	#if area.is_in_group("weapon_pick"):
		#print(area.name)
		#weapon_under = true
		#under_name = area.name
		#if Input.is_action_just_pressed("p"):
			#weapon.current = area.name
			#print(weapon.current)
			#area.queue_free()
