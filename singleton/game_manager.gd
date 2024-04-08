extends Node

var debt_money = 1000000
var interest_rate = 1.05
var day_left = 20
var current_time = 0 # from 0 to 8, 8 unit of time
var item_database_dict: Dictionary = {}

var player: Player
var player_menu: PlayerMenu
var game_ui: GameUI
var npc_interact_ui: NPCInteractUI

signal time_passed
signal inventory_changed
signal day_passed

func _ready():
	load_item_database()

func get_time_left():
	return 8 - current_time

func pass_time(time: int):
	current_time = clampi(current_time + time, 0, 8)
	emit_signal("time_passed")

func move_to_next_day():
	day_left -= 1
	current_time = 0
	emit_signal("time_passed")
	emit_signal("day_passed")

func load_item_database():
	var directory_path = "res://item/"

	# Get a list of files in the directory
	var dir = DirAccess.open(directory_path)

	# Loop through each file in the directory
	dir.list_dir_begin()
	var file_name = dir.get_next()

	while file_name != "":
		if file_name.ends_with(".tres"):
			# Load each resource file using ResourceLoader
			var resource_path = directory_path + file_name
			var resource = ResourceLoader.load(resource_path) as ItemResource
			if resource != null:
				# Do something with the loaded resource, e.g., add it to the scene
				# item_database.append(resource)
				item_database_dict[resource.item_id] = resource
			else:
				print("Failed to load resource:", resource_path)

		# Get the next file in the directory
		file_name = dir.get_next()
	dir.list_dir_end()

func open_npc_interact_ui(target_npc: NPCFish):
	npc_interact_ui.open_ui(target_npc)