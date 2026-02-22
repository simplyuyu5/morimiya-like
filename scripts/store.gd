extends Node
@onready var parent = get_parent()

var open :bool = false
var inder = 0

@onready var prim_icon = $Panel/weapons_shop/prim_buy/weapon
@onready var equip_icon = $Panel/weapons_shop/equip/equipicon
@onready var list_equip = $Panel/weapons_shop/equip/itemlist_eq
@onready var list_buy_prim = $Panel/weapons_shop/prim_buy/itemlist_prim
@onready var weapons = $"/root/Node2D/CharacterBody2D/weapons"
@onready var prim = weapons.primaries
@onready var sec = weapons.secondaries



func init():
	
	if Input.is_action_just_pressed("p") and open == false:
		open = true
		$Panel.show()
		populate_shop()
		populate_equip()


func populate_shop():
	list_buy_prim.clear()
	for i in prim:
		if i in prim and prim[i]["sbought"] == false and prim[i]["cost"] is int:
			list_buy_prim.add_item(i)


func populate_equip():
	list_equip.clear()
	for i in prim:
		if i in prim and prim[i]["sbought"] == true:
			list_equip.add_item(i)
	for i in sec:
		if i in sec and sec[i]["sbought"] == true:
			list_equip.add_item(i)


func _on_button_pressed() -> void:
		open = false
		$Panel.hide()


func _on_sub_button_pressed() -> void:
		$Panel/skills_shop.hide()
		$Panel/weapons_shop.hide()
		$Panel/weapons_shop/equip.hide()
		$Panel/weapons_shop/prim_buy.hide()



func _on_itemlist_prim_item_selected(index: int) -> void:
	var i:String = list_buy_prim.get_item_text(index)
	inder = index
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
	$Panel/weapons_shop/prim_buy/recoil/prog.value =prim[i]["srecoil"]


func _on_buy_prim_pressed():
	$Panel/weapons_shop.show()
	$Panel/weapons_shop/prim_buy.show()
	$Panel/weapons_shop/equip.hide()
	$Panel/skills_shop.hide()


func _on_buy_button_shop_pressed():
	var i:String = list_buy_prim.get_item_text(inder)
	if i in prim:
		prim[i]["sbought"] = true
	else:
		pass
	populate_shop()


func _on_equip_prim_pressed() -> void:
	$Panel/weapons_shop.show()
	$Panel/weapons_shop/prim_buy.hide()
	$Panel/weapons_shop/equip.show()
	$Panel/skills_shop.hide()
	populate_equip()


func _on_equip_pressed() -> void:
	if inder in prim:
		weapons.current_prim = inder
		weapons.assign_weapon_rounds(1)
	elif inder in weapons.secondaries:
		weapons.current_sec = inder
		weapons.assign_weapon_rounds(2)
	print(weapons.current_sec," ",weapons.current_prim)


func _on_itemlist_eq_item_selected(index: int) -> void:
	var i = list_equip.get_item_text(index)
	inder = i
	equip_icon.play(i)

	if i in prim:
	#text and descr :c
		$Panel/weapons_shop/equip/damage.text = str("damage - ", prim[i]["sdamage"])
		$Panel/weapons_shop/equip/roundsmax.text = str("mag size - ", prim[i]["srounds_max"])
		$Panel/weapons_shop/equip/mags.text = str("mags - ", prim[i]["smags_max"])
		$Panel/weapons_shop/equip/reloadtype.text = str("reload type - ", prim[i]["sreload_type"])
		$Panel/weapons_shop/equip/recoil.text = str("recoil - ", prim[i]["srecoil"])
		$Panel/weapons_shop/equip/description.text = str(prim[i]["sdesc"])

		#omagah progress barsss
		$Panel/weapons_shop/equip/damage/prog.value = prim[i]["sdamage"]
		$Panel/weapons_shop/equip/roundsmax/prog.value =prim[i]["srounds_max"]
		$Panel/weapons_shop/equip/recoil/prog.value =prim[i]["srecoil"]
	elif i in sec:
		$Panel/weapons_shop/equip/damage.text = str("damage - ", sec[i]["sdamage"])
		$Panel/weapons_shop/equip/roundsmax.text = str("mag size - ", sec[i]["srounds_max"])
		$Panel/weapons_shop/equip/mags.text = str("mags - ", sec[i]["smags_max"])
		$Panel/weapons_shop/equip/reloadtype.text = str("reload type - ", sec[i]["sreload_type"])
		$Panel/weapons_shop/equip/recoil.text = str("recoil - ", sec[i]["srecoil"])
		$Panel/weapons_shop/equip/description.text = str(sec[i]["sdesc"])

		#HELP OH MY GOD THIS CODE IS ($1%7$YgkdHU(WH3wd3dxCF>?XFPKvd#R#VasdDsafVGV:(acxcfsefV>jxiq:m@?q<l:3.ef,jvnklw:3IJDfvwmj,ogkn jl
		$Panel/weapons_shop/equip/damage/prog.value = sec[i]["sdamage"]
		$Panel/weapons_shop/equip/roundsmax/prog.value =sec[i]["srounds_max"]
		$Panel/weapons_shop/equip/recoil/prog.value =sec[i]["srecoil"]
