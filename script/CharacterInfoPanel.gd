extends PanelContainer

@onready var name_label: Label = %NameLabel
@onready var str_label: Label = %StrLabel
@onready var dex_label: Label = %DexLabel
@onready var con_label: Label = %ConLabel
@onready var spd_label: Label = %SpdLabel
@onready var hp_bar: ProgressBar = %HpBar
@onready var ap_bar: ProgressBar = %ApBar
@onready var weapon_item: PanelContainer = %WeaponItem
@onready var background: TextureRect = %Background

func setup(char_data: Dictionary, weapon_data: Dictionary = {}):
	name_label.text = char_data.get("background", "Unknown")
	
	var stats = char_data.get("baseStats", {})
	str_label.text = str(stats.get("str", 0))
	dex_label.text = str(stats.get("dex", 0))
	con_label.text = str(stats.get("con", 0))
	spd_label.text = str(stats.get("speed", 0))
	
	var max_hp = stats.get("maxHp", 100)
	hp_bar.max_value = max_hp
	hp_bar.value = max_hp
	
	ap_bar.max_value = 10
	ap_bar.value = 10

	if weapon_item and weapon_item.has_method("setup"):
		weapon_item.setup(weapon_data)
