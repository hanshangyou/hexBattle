extends PanelContainer

@onready var name_label: Label = %NameLabel
@onready var str_label: Label = %StrLabel
@onready var dex_label: Label = %DexLabel
@onready var con_label: Label = %ConLabel
@onready var spd_label: Label = %SpdLabel
@onready var hp_bar: ProgressBar = %HpBar
@onready var ap_bar: ProgressBar = %ApBar
@onready var weapon_icon: TextureRect = %WeaponIcon
@onready var armor_icon: TextureRect = %ArmorIcon
@onready var background: TextureRect = %Background

func setup(char_data: Dictionary, weapon_data: Dictionary = {}):
	# Name
	name_label.text = char_data.get("background", "Unknown")
	
	# Stats
	var stats = char_data.get("baseStats", {})
	str_label.text = str(stats.get("str", 0))
	dex_label.text = str(stats.get("dex", 0))
	con_label.text = str(stats.get("con", 0))
	spd_label.text = str(stats.get("speed", 0))
	
	# Bars
	var max_hp = stats.get("maxHp", 100)
	hp_bar.max_value = max_hp
	hp_bar.value = max_hp # Default to full
	
	# AP
	ap_bar.max_value = 10
	ap_bar.value = 10
	
	# Update Weapon Icon based on type
	# The weapon icon sheet is 1024x1024, 4x4 grid -> each cell is 256x256
	var weapon_type = weapon_data.get("type", "SABRE")
	var cell_x = 0
	var cell_y = 0
	
	match weapon_type:
		"SABRE":
			cell_x = 0
			cell_y = 0
		"SWORD":
			cell_x = 0
			cell_y = 2
		"SPEAR":
			cell_x = 1
			cell_y = 0
		"BOW":
			cell_x = 1
			cell_y = 3
		_:
			cell_x = 0
			cell_y = 0 # Default to sabre if unknown
			
	set_atlas_icon(weapon_icon, cell_x, cell_y)
	
	# Armor Icon (Fixed at 0, 1)
	set_atlas_icon(armor_icon, 0, 1)

func set_atlas_icon(texture_rect: TextureRect, x: int, y: int):
	if not texture_rect.texture:
		return
		
	# Create an AtlasTexture on the fly if it's not one already, 
	# or just assume the base texture is the full sheet and we wrap it in AtlasTexture
	# But TextureRect expects a simple texture. 
	# Better approach: The TextureRect in scene has the full image. 
	# We can replace it with an AtlasTexture using the same image.
	
	var atlas = AtlasTexture.new()
	atlas.atlas = texture_rect.texture
	# 1024 / 4 = 256
	# User specified (row, col) coordinates for 4x4 grid
	atlas.region = Rect2(y * 256, x * 256, 256, 256)
	
	texture_rect.texture = atlas
