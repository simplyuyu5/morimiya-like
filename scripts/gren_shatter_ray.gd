extends RayCast2D

@onready var parent = get_parent()
@onready var shat_sprite = $grenade_shatter
var dmg_loc = 1

func _process(_delta: float) -> void:
	var target = get_collider()
	if is_colliding() and target.is_in_group("wall"):
		enabled = false
	elif is_colliding() and target.is_in_group("living"):
		target.hp -=dmg_loc
	elif is_colliding() and target.is_in_group("player"):
		target.health -= dmg_loc
	else:
		pass

func shatter(dist_min,dist_max,dmg,type):
	dmg_loc = dmg
	var shati = randi_range(0,6)
	shat_sprite.animation = type
	shat_sprite.frame = shati
	var dist = randi_range(dist_min,dist_max)

	target_position.y = dist

	enabled = true


	await get_tree().create_timer(0.2).timeout
	enabled = false
	queue_free()
