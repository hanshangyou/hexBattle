extends PanelContainer

@onready var icon: TextureRect = %Icon
@onready var name_label: Label = %NameLabel
@onready var damage_label: Label = %DamageLabel
@onready var ap_label: Label = %ApLabel

func setup(weapon_data: Dictionary):
	name_label.text = str(weapon_data.get("name", ""))
	var dmg_min = int(weapon_data.get("damageMin", 0))
	var dmg_max = int(weapon_data.get("damageMax", 0))
	damage_label.text = "%d-%d" % [dmg_min, dmg_max]
	ap_label.text = str(weapon_data.get("apCost", 0))

	var weapon_type = str(weapon_data.get("type", "SABRE"))
	var rarity = str(weapon_data.get("rarity", "COMMON"))
	var coords = _coords_for_type(weapon_type, rarity, bool(weapon_data.get("isArmor", false)))
	_set_atlas_icon(icon, coords.x, coords.y)

func _coords_for_type(weapon_type: String, rarity: String, is_armor: bool) -> Vector2i:
	var row := 0
	var col := 0
	if is_armor or weapon_type == "ARMOR":
		row = 0
	else:
		match weapon_type:
			"SABRE":
				col = 4
			"SWORD":
				col = 0
			"SPEAR":
				col = 1
			"BOW":
				col = 2
			_:
				col = 0
	match rarity:
		"COMMON":
			row = 0
		"UNCOMMON":
			row = 1
		"RARE":
			row = 2
		"EPIC":
			row = 3
		"LEGENDARY":
			row = 4
		"ENEMY":
			row = 5
		_:
			row = 0
	return Vector2i(row, col)

func _set_atlas_icon(texture_rect: TextureRect, row: int, col: int):
	if not texture_rect.texture:
		return

	var base_texture: Texture2D = texture_rect.texture
	if base_texture is AtlasTexture:
		base_texture = (base_texture as AtlasTexture).atlas

	var cols := 8
	var rows := 6
	var cell_w := float(base_texture.get_width()) / float(cols)
	var cell_h := float(base_texture.get_height()) / float(rows)

	var atlas := AtlasTexture.new()
	atlas.atlas = base_texture
	atlas.region = Rect2(cell_w * float(col), cell_h * float(row), cell_w, cell_h)
	texture_rect.texture = atlas
