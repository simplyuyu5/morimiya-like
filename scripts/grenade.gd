extends RigidBody2D

@onready var weapons = $"/root/Node2D/CharacterBody2D/weapons"

#@onready var shat_sprite = $shatter_ray/grenade_shatter
@onready var gren_sprite = $grenade_sprite

var dec_boom = preload("res://scenes/explosio_decal.tscn")
@onready var expl_sprite = $dmg_rad/explosin

@onready var shatter_ray = $shatter_ray
@onready var damage_radius = $dmg_rad
@onready var danger_area = $danger_area
@onready var ticker = $Timer
@onready var sound = $boom

var kill
var velocity_throw
var type_sv
var scan = 360

func _ready() -> void:
	throw(weapons.current_gren)

func _process(delta: float) -> void:
	if velocity_throw <= -1:velocity_throw = 0
	else:
		velocity_throw -=1


func throw(type):
	type_sv = type
	visual_look()
	match weapons.fuse_rand:
		true:
			ticker.wait_time = weapons.fuse - randf_range(-1.5,1.8)
		false:
			ticker.wait_time = weapons.fuse

	#apply_impulse(Vector2(0, 0), Vector2(10, 0).rotated(rotation)) 
	apply_central_impulse(Vector2(velocity_throw *100,0).rotated(rotation))
	ticker.start()

func visual_look():
	var greni = randi_range(0,2)
	gren_sprite.animation = type_sv
	gren_sprite.frame = greni

func explode():
	var decal = dec_boom.instantiate()
	gren_sprite.hide()
	sound.play()
	explode_actual()



	#expl_sprite.play(str(randi_range(1,3))) uncomment when have 3 explosion animations!!!
	expl_sprite.play("1")

	decal.global_transform = self.global_transform
	decal.scale = Vector2(5,5)
	decal.rotation = randi_range(0,359)
	decal.animation = "set1"
	decal.frame = randi_range(0,3)
	add_sibling(decal)

func explode_actual():

	$dmg_rad/CollisionShape2D.shape.radius = weapons.radius
	#add_child(shatter_ray.duplicate())
	#shatter_ray.look_at(shatter_ray.target)
	#shatter_ray.enabled = true
	#shatter_ray.shatter(weapons.radius,weapons.radius,weapons.damage_rad,"default")
	$dmg_rad/CollisionShape2D.disabled = false


	if weapons.shatter == true:
		var i = randi_range(weapons.shatter_amt_min,weapons.shatter_amt_max)
		for a in i:
			shatter_ray.name += str(a)
			shatter_ray.rotation = randi_range(0,360)
			add_child(shatter_ray.duplicate())
			shatter_ray.enabled = true
			shatter_ray.shatter(weapons.shatter_dst_min,weapons.shatter_dst_max,weapons.damage_shat,type_sv)
	else:pass


	await get_tree().create_timer(0.1).timeout
	queue_free()


func _on_timer_timeout() -> void:
	explode()


func _on_dmg_rad_body_entered(body: CharacterBody2D):
	print("hi")
	if body.is_in_group("living"):
		body.hp -=weapons.damage_rad
		print("diie")
	elif body.is_in_group("player"):
		body.health -= weapons.damage_rad
	else:
		pass
