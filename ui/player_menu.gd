extends Control
class_name PlayerMenu

@onready var tab_container: TabContainer = $TabContainer
@onready var inventory_menu: InventoryMenu = $TabContainer/Inventory

var player: Player = null

func _ready():
	GameManager.player_menu = self
	close_menu()
	await get_tree().process_frame
	await get_tree().process_frame
	player = GameManager.player
	inventory_menu.init()

func toggle_menu():
	if visible:
		close_menu()
	else:
		open_menu()

func open_menu():
	visible = true
	inventory_menu.refresh_stat()
	inventory_menu.refresh_inventory_data()

func close_menu():
	visible = false

func _on_close_button_pressed() -> void:
	close_menu()
