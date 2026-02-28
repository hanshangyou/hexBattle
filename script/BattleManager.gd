extends Node2D

const GameData = preload("res://script/GameData.gd")

@onready var tile_map: TileMapLayer = $Hexmap/TileMapLayer
@onready var camera: Camera2D = $Camera2D
@onready var enemy_container: HBoxContainer = %EnemyContainer
@onready var player_container: HBoxContainer = %PlayerContainer

var character_scene = preload("res://scene/Character.tscn")
var info_panel_scene = preload("res://scene/CharacterInfoPanel.tscn")

var left_cells: Array[Vector2i] = []
var right_cells: Array[Vector2i] = []

func _ready():
	# Wait for the tilemap to be ready
	await get_tree().process_frame
	
	if not tile_map:
		printerr("TileMapLayer not found!")
		return
		
	init_map_zones()
	setup_camera()
	start_battle(1) # Start stage 1 by default

func init_map_zones():
	var cells = tile_map.get_used_cells()
	if cells.is_empty():
		printerr("No cells found in TileMapLayer!")
		return

	left_cells.clear()
	right_cells.clear()

	for cell in cells:
		var source_id = tile_map.get_cell_source_id(cell)
		if source_id == -1:
			continue
		var atlas_coords = tile_map.get_cell_atlas_coords(cell)
		if atlas_coords == Vector2i(-1, -1):
			continue
		if atlas_coords == Vector2i(0, 0):
			left_cells.append(cell)
		elif atlas_coords == Vector2i(2, 0):
			right_cells.append(cell)

	print("Map Zones: Blue %d cells, Red %d cells" % [left_cells.size(), right_cells.size()])

func setup_camera():
	if not camera: return
	
	var rect = tile_map.get_used_rect()
	var rect_center = rect.get_center()
	var world_center = tile_map.to_global(tile_map.map_to_local(rect_center))
	
	camera.position = world_center
	# Adjust zoom if necessary based on map size vs viewport
	# For now, default zoom is fine, or we can zoom out slightly
	# camera.zoom = Vector2(0.8, 0.8)

func start_battle(stage_id: int):
	print("Starting Battle Stage %d" % stage_id)
	
	# Get stage data
	var stage = GameData.get_stage(stage_id)
	if stage.is_empty():
		printerr("Stage %d not found!" % stage_id)
		return

	# 1. Pick 3 random players
	var players = GameData.get_random_characters(3)
	spawn_characters(players, false)

	# 2. Get enemies
	var enemy_ids = stage.get("enemies", [])
	# Convert enemy IDs to character dictionaries
	var enemies = []
	for id in enemy_ids:
		var char_data = GameData.get_character(id)
		if not char_data.is_empty():
			enemies.append(char_data)
	spawn_characters(enemies, true)

func spawn_characters(characters: Array, is_enemy: bool):
	var available_cells = right_cells.duplicate() if is_enemy else left_cells.duplicate()
	available_cells.shuffle()
	
	for char_data in characters:
		# Spawn UI Panel
		var panel = info_panel_scene.instantiate()
		
		# Set scale for panel to fit more on screen
		# Use a Control wrapper to enforce size if needed, but simple scaling might work visually
		# However, in HBoxContainer, scale property is ignored for layout but affects drawing.
		# A better way is to set custom_minimum_size on the panel instance if we want to shrink it,
		# but the contents are fixed pixel size. 
		# Let's just scale it down to 0.65 to fit 3-4 items on 412 width.
		# 195 * 0.65 = ~127. 127 * 3 = 381 < 412.
		panel.scale = Vector2(0.65, 0.65)
		# To make the container respect the scaled size, we need to wrap it in a Control
		# or set custom_minimum_size on the panel itself (but that clips content if not scaled).
		# A simple trick: wrap in a Control with desired min size.
		
		var wrapper = Control.new()
		wrapper.custom_minimum_size = Vector2(195 * 0.65, 251 * 0.65)
		wrapper.mouse_filter = Control.MOUSE_FILTER_PASS
		wrapper.add_child(panel)
		
		if is_enemy:
			enemy_container.add_child(wrapper)
		else:
			player_container.add_child(wrapper)
		
		var weapon_id = char_data.get("defaultWeaponId", "")
		var weapon_data = GameData.get_weapon(weapon_id)
		panel.setup(char_data, weapon_data)
		
		# Spawn World Character
		if available_cells.is_empty():
			printerr("Not enough spawn points for %s!" % ("enemies" if is_enemy else "players"))
			continue
			
		var cell = available_cells.pop_back()
		# map_to_local returns the center of the cell in local coordinates
		# Convert to global position to be safe regardless of node hierarchy
		var local_pos = tile_map.map_to_local(cell)
		var global_pos = tile_map.to_global(local_pos)
		
		var char_instance = character_scene.instantiate()
		# Add character to the Battle node (self), not the TileMap, so they are on top
		add_child(char_instance)
		char_instance.global_position = global_pos
		
		# Setup character data
		char_instance.setup(char_data["id"], is_enemy)
