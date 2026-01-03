extends Node
@onready var parent = get_parent()

var open :bool = false


func init():
	if Input.is_action_just_pressed("p") and open == false:
		print("Wewcome")
		open = true
		Input.mouse_mode =Input.MOUSE_MODE_VISIBLE
		$Panel.show()
	#elif Input.is_action_just_pressed("p") and open == true: 
		#open = false
		#$Panel.hide()


func _on_button_pressed() -> void:
		open = false
		$Panel.hide()


func _on_sub_button_pressed() -> void:
		$Panel/skills_shop.hide()
		$Panel/weapons_shop.hide()


func _on_itemlist_prim_item_selected(index: int) -> void:
	var prim_icon = $Panel/weapons_shop/prim_buy/weapon
	var list = $Panel/weapons_shop/prim_buy/itemlist_prim
	var i:String = list.get_item_text(index)
	var weapons = $"/root/Node2D/CharacterBody2D/weapons"
	var prim = weapons.primaries
	prim_icon.play(i)

	#text and descr :c
	$Panel/weapons_shop/prim_buy/damage.text = str("damage - ", prim[i]["sdamage"])
	$Panel/weapons_shop/prim_buy/roundsmax.text = str("mag size - ", prim[i]["srounds_max"])
	$Panel/weapons_shop/prim_buy/mags.text = str("mags - ", prim[i]["smags_max"])
	$Panel/weapons_shop/prim_buy/reloadtype.text = str("reload type - ", prim[i]["sreload_type"])
	$Panel/weapons_shop/prim_buy/recoil.text = str("recoil - ", prim[i]["srecoil"])
	$Panel/weapons_shop/prim_buy/description.text = str(prim[i]["sdesc"])

#omagah progress barsss
	$Panel/weapons_shop/prim_buy/damage/prog.value = prim[i]["sdamage"]
	$Panel/weapons_shop/prim_buy/roundsmax/prog.value =prim[i]["srounds_max"]
	$Panel/weapons_shop/prim_buy/mags/prog.value =prim[i]["smags_max"]
	$Panel/weapons_shop/prim_buy/recoil/prog.value =prim[i]["srecoil"]

	#var i:String = prim[index] 
	#print(i)


func _on_buy_prim_pressed() -> void:
	$Panel/weapons_shop.show()
	$Panel/weapons_shop/prim_buy.show()
	$Panel/skills_shop.hide()
