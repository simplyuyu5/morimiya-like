extends Node
@onready var parent = get_parent()

var open :bool = false


func init():
	if Input.is_action_just_pressed("p") and open == false:
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


func _on_item_list_item_gun_shop_selected(index: int) -> void:
	pass # Replace with function body.
