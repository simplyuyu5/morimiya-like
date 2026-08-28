extends Node
@onready var parent = get_parent()

var open :bool = false
var inder = 0

@onready var prim_icon = $Panel/weapons_shop/prim_buy/weapon
@onready var sec_icon = $Panel/weapons_shop/sec_buy/weapon
@onready var equip_icon = $Panel/weapons_shop/equip/equipicon
@onready var list_equip = $Panel/weapons_shop/equip/itemlist_eq
@onready var list_buy_prim = $Panel/weapons_shop/prim_buy/itemlist_prim
@onready var list_buy_sec = $Panel/weapons_shop/sec_buy/itemList_sec

#@onready var weapons = $"/root/Node2D/CharacterBody2D/weapons"
#@onready var prim = weapons.primaries
#@onready var sec = weapons.secondaries
@onready var saves = saveMain

@onready var points_label = $Panel/points2

func _input(_event: InputEvent) -> void:
	points_label.text = "points:"+str(saves.total_points)

func init():
	
	if Input.is_action_just_pressed("p") and open == false:
		open = true
		#prim = weapons.primaries
		#sec = weapons.secondaries
		$Panel.show()
		populate_shop_prim()
		populate_shop_sec()
		populate_equip()


func populate_shop_prim():
	list_buy_prim.clear()
	for i in weapons.primaries:
		if i in weapons.primaries and weapons.primaries[i]["sbought"] == false and weapons.primaries[i]["cost"] is int:
			list_buy_prim.add_item(i)
func populate_shop_sec():
	list_buy_sec.clear()
	for i in weapons.secondaries:
		if i in weapons.secondaries and weapons.secondaries[i]["sbought"] == false and weapons.secondaries[i]["cost"] is int:
			list_buy_sec.add_item(i)


func populate_equip():
	list_equip.clear()
	for i in weapons.primaries:
		if i in weapons.primaries and weapons.primaries[i]["sbought"] == true:
			list_equip.add_item(i)
	for i in weapons.secondaries:
		if i in weapons.secondaries and weapons.secondaries[i]["sbought"] == true:
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
	$Panel/weapons_shop/prim_buy/damage.text = str("damage - ", weapons.primaries[i]["sdamage"])
	$Panel/weapons_shop/prim_buy/roundsmax.text = str("mag size - ", weapons.primaries[i]["srounds_max"])
	$Panel/weapons_shop/prim_buy/mags.text = str("mags - ", weapons.primaries[i]["smags_max"])
	$Panel/weapons_shop/prim_buy/reloadtype.text = str("reload type - ", weapons.primaries[i]["sreload_type"])
	$Panel/weapons_shop/prim_buy/recoil.text = str("recoil - ", weapons.primaries[i]["srecoil"])
	$Panel/weapons_shop/prim_buy/description.text = str(weapons.primaries[i]["sdesc"])
	$Panel/weapons_shop/prim_buy/cost.text = str(weapons.primaries[i]["cost"])

	#omagah progress barsss
	$Panel/weapons_shop/prim_buy/damage/prog.value = weapons.primaries[i]["sdamage"]
	$Panel/weapons_shop/prim_buy/roundsmax/prog.value =weapons.primaries[i]["srounds_max"]
	$Panel/weapons_shop/prim_buy/recoil/prog.value =weapons.primaries[i]["srecoil"]


func _on_buy_sec_pressed():
	$Panel/weapons_shop.show()
	$Panel/weapons_shop/prim_buy.hide()
	$Panel/weapons_shop/sec_buy.show()
	$Panel/weapons_shop/equip.hide()
	$Panel/skills_shop.hide()

func _on_buy_prim_pressed():
	$Panel/weapons_shop.show()
	$Panel/weapons_shop/prim_buy.show()
	$Panel/weapons_shop/sec_buy.hide()
	$Panel/weapons_shop/equip.hide()
	$Panel/skills_shop.hide()


func _on_buy_button_shop_pressed():
	var i:String = list_buy_prim.get_item_text(inder)
	if i in weapons.primaries and saves.total_points >= weapons.primaries[i]["cost"]:
		weapons.primaries[i]["sbought"] = true
		saves.total_points -= weapons.primaries[i]["cost"]
		print(saves.total_points)
	else:
		pass
	populate_shop_prim()


func _on_buy_button_sec_pressed() -> void:
	var i:String = list_buy_sec.get_item_text(inder)
	if i in weapons.secondaries and saves.total_points >= weapons.secondaries[i]["cost"]:
		weapons.secondaries[i]["sbought"] = true
		saves.total_points -= weapons.secondaries[i]["cost"]
		print(saves.total_points)
	else:
		pass
	populate_shop_sec()

func _on_equip_prim_pressed() -> void:
	$Panel/weapons_shop.show()
	$Panel/weapons_shop/prim_buy.hide()
	$Panel/weapons_shop/sec_buy.hide()
	$Panel/weapons_shop/equip.show()
	$Panel/skills_shop.hide()
	populate_equip()


func _on_equip_pressed() -> void:
	if inder in weapons.primaries:
		weapons.current_prim = inder
		weapons.assign_weapon_rounds(1)
	elif inder in weapons.secondaries:
		weapons.current_sec = inder
		weapons.assign_weapon_rounds(2)
	#print(weapons.current_sec," ",weapons.current_prim)


func _on_itemlist_eq_item_selected(index: int) -> void:
	var i = list_equip.get_item_text(index)
	inder = i
	equip_icon.play(i)

	if i in weapons.primaries:
	#text and descr :c
		$Panel/weapons_shop/equip/damage.text = str("damage - ", weapons.primaries[i]["sdamage"])
		$Panel/weapons_shop/equip/roundsmax.text = str("mag size - ", weapons.primaries[i]["srounds_max"])
		$Panel/weapons_shop/equip/mags.text = str("mags - ", weapons.primaries[i]["smags_max"])
		$Panel/weapons_shop/equip/reloadtype.text = str("reload type - ", weapons.primaries[i]["sreload_type"])
		$Panel/weapons_shop/equip/recoil.text = str("recoil - ", weapons.primaries[i]["srecoil"])
		$Panel/weapons_shop/equip/description.text = str(weapons.primaries[i]["sdesc"])


		#omagah progress barsss
		$Panel/weapons_shop/equip/damage/prog.value = weapons.primaries[i]["sdamage"]
		$Panel/weapons_shop/equip/roundsmax/prog.value =weapons.primaries[i]["srounds_max"]
		$Panel/weapons_shop/equip/recoil/prog.value =weapons.primaries[i]["srecoil"]
	elif i in weapons.secondaries:
		$Panel/weapons_shop/equip/damage.text = str("damage - ", weapons.secondaries[i]["sdamage"])
		$Panel/weapons_shop/equip/roundsmax.text = str("mag size - ", weapons.secondaries[i]["srounds_max"])
		$Panel/weapons_shop/equip/mags.text = str("mags - ", weapons.secondaries[i]["smags_max"])
		$Panel/weapons_shop/equip/reloadtype.text = str("reload type - ", weapons.secondaries[i]["sreload_type"])
		$Panel/weapons_shop/equip/recoil.text = str("recoil - ", weapons.secondaries[i]["srecoil"])
		$Panel/weapons_shop/equip/description.text = str(weapons.secondaries[i]["sdesc"])

		#HELP OH MY GOD THIS CODE IS ($1%7$YgkdHU(WH3wd3dxCF>?XFPKvd#R#VasdDsafVGV:(acxcfsefV>jxiq:m@?q<l:3.ef,jvnklw:3IJDfvwmj,ogkn jl
		$Panel/weapons_shop/equip/damage/prog.value = weapons.secondaries[i]["sdamage"]
		$Panel/weapons_shop/equip/roundsmax/prog.value =weapons.secondaries[i]["srounds_max"]
		$Panel/weapons_shop/equip/recoil/prog.value =weapons.secondaries[i]["srecoil"]


func _on_item_list_sec_item_selected(index: int):
	var i:String = list_buy_sec.get_item_text(index)
	inder = index
	sec_icon.play(i)

	$Panel/weapons_shop/sec_buy/damage.text = str("damage - ", weapons.secondaries[i]["sdamage"])
	$Panel/weapons_shop/sec_buy/roundsmax.text = str("mag size - ", weapons.secondaries[i]["srounds_max"])
	$Panel/weapons_shop/sec_buy/mags.text = str("mags - ", weapons.secondaries[i]["smags_max"])
	$Panel/weapons_shop/sec_buy/reloadtype.text = str("reload type - ", weapons.secondaries[i]["sreload_type"])
	$Panel/weapons_shop/sec_buy/recoil.text = str("recoil - ", weapons.secondaries[i]["srecoil"])
	$Panel/weapons_shop/sec_buy/description.text = str(weapons.secondaries[i]["sdesc"])
	$Panel/weapons_shop/sec_buy/cost.text = str(weapons.secondaries[i]["cost"])

	#omagah progress barsss
	$Panel/weapons_shop/sec_buy/damage/prog.value = weapons.secondaries[i]["sdamage"]
	$Panel/weapons_shop/sec_buy/roundsmax/prog.value =weapons.secondaries[i]["srounds_max"]
	$Panel/weapons_shop/sec_buy/recoil/prog.value =weapons.secondaries[i]["srecoil"]
