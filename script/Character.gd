extends Node2D

const GameData = preload("res://script/GameData.gd")

@onready var icon_label: Label = $Icon
@onready var info_label: Label = $Info

var character_data: Dictionary
var weapon_data: Dictionary
var is_enemy: bool = false
var char_id: String

func setup(_char_id: String, _is_enemy: bool):
	char_id = _char_id
	is_enemy = _is_enemy
	
	character_data = GameData.get_character(char_id)
	var weapon_id = character_data.get("defaultWeaponId", "")
	weapon_data = GameData.get_weapon(weapon_id)
	
	call_deferred("update_visuals")

func update_visuals():
	if character_data.is_empty():
		return
		
	# Set Icon (Emoji)
	icon_label.text = character_data.get("icon", "?")
	
	# Set Color based on faction
	if is_enemy:
		# Use a reddish tint for enemies
		modulate = Color(1, 0.8, 0.8)
	else:
		# Use a bluish tint for allies
		modulate = Color(0.8, 0.8, 1)
		
	# Info
	var stats = character_data.get("baseStats", {})
	var hp = stats.get("maxHp", 100)
	info_label.text = "%s\nHP: %d" % [character_data.get("background", "Unknown"), hp]
