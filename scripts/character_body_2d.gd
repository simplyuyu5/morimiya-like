extends CharacterBody2D

@onready var ray = $ray_long
@onready var weapon = $weapons
@onready var ray_pick = $pickup_ray
@onready var body = $Mc

@onready var pew = $ray_long/pew
@onready var store = $store

var weapon_under :bool = false
var pickup_under :bool = false
var under_name

var health = 200
var speed_fin = 300
#const SPEED = 300.0

func _ready() -> void:
	pew.play("nothing")

func _physics_process(_delta: float) -> void:

	#if ray.is_colliding():
		#print("collision ray")
		#var target = ray.get_collider()
		#end.global_position = ray.get_collision_point()
		#if target.is_in_group("living"):
			#target.hp -= damage
			#ray.enabled = false
			
		#else:
			#end.global_position = ray.cast_to()

	#if not ray.is_colliding():
		#print("no collision")

	equip_ult()
	change()
	shoot()
	reload()
	move()
	move_anim()
	gui()



	look_at(get_global_mouse_position())

	move_and_slide()

func shoot():
	var target = ray.get_collider()
	if Input.is_action_just_pressed("lmb") and weapon.rounds >= 1:
		gun_smoke(weapon.style)
		weapon.rounds -= weapon.shots
		if ray.is_colliding() and target.is_in_group("living"):
			target.hp -= weapon.damage


func reload():
	if Input.is_action_just_pressed("r"):
		if weapon.mags > 0:
			weapon.mags -=1
			weapon.rounds = weapon.rounds_max

func  move():
	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.determinant() * Vector2(input_dir.x, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed_fin
		velocity.y = direction.y * speed_fin
	else:
		velocity.x = move_toward(velocity.x, 0, speed_fin)
		velocity.y = move_toward(velocity.y, 0, speed_fin)

func change():
	if Input.is_action_just_pressed("q") and weapon.current != null:
		if weapon.in_hands == weapon.current_prim:
			weapon.in_hands = weapon.current_sec
			weapon.weapon_change()
		else:
			weapon.in_hands = weapon.current_prim
			weapon.weapon_change()

func equip_ult():
	var target = ray_pick.get_collider()
	if ray_pick.is_colliding() and target.is_in_group("weapon_pick"):
		equip_weapon()
	if ray_pick.is_colliding() and target.is_in_group("weapons_desk"):
		if Input.is_action_just_pressed("p"):
			store.init()

func equip_weapon():
	var target = ray_pick.get_collider()
	if Input.is_action_just_pressed("p"):
			print(target.name, " target")
			weapon.in_hands = target.name
			print("picked up weapon! ", weapon.in_hands)
			weapon.weapon_change()
			target.queue_free()
			ray_pick.enabled = false
			await get_tree().create_timer(1.0).timeout
			ray_pick.enabled = true
			
	else:
		pass







func move_anim():
	if Input.is_action_pressed("moving"):
		body.play("walk")
	else:
		body.play("idle")

func gun_smoke(style):
	if style == 0:
		pew.play("pew_small")
	elif style == 1:
		pew.play("pew_medium")
	elif style == 2:
		pew.play("pew_big")

@onready var label_rou = $gui/rounds
@onready var label_mag = $gui/mags

func gui():
	label_rou.text = str(weapon.rounds) + " rounds"
	label_mag.text = str(weapon.mags) + " mags"
#func _on_pick_range_area_entered(area: Area2D):
	#if area.is_in_group("weapon_pick"):
		#print(area.name)
		#weapon_under = true
		#under_name = area.name
		#if Input.is_action_just_pressed("p"):
			#weapon.current = area.name
			#print(weapon.current)
			#area.queue_free()
