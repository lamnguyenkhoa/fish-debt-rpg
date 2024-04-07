extends Control
class_name InventoryMenu

@export var item_button_prefab: PackedScene

@onready var item_btn_container = $ScrollContainer/VBoxContainer
@onready var item_desc_label: RichTextLabel = $ItemDesc

var player_menu: PlayerMenu
var player: Player

func init():
	player_menu = get_parent().get_parent()
	player = player_menu.player
	refresh_inventory_data()
	item_desc_label.text = ""
	player.inventory_changed.connect(refresh_inventory_data)

func refresh_inventory_data():
	# Delete all entries
	for i in range(item_btn_container.get_child_count()):
		item_btn_container.get_child(i).queue_free()

	await get_tree().process_frame
	await get_tree().physics_frame

	# Add entries according to inventory
	for item_id in player.inventory.keys():
		if player.inventory[item_id] > 0:
			var new_item_btn = item_button_prefab.instantiate() as ItemButton
			item_btn_container.add_child(new_item_btn)
			new_item_btn.inventory_menu = self
			new_item_btn.item_data = GameManager.item_database_dict[item_id]
			new_item_btn.refresh_data()

func show_item_description(item_data: ItemResource):
	item_desc_label.text = "[font_size=24]{0}[/font_size]\n\n{1}".format([item_data.name, item_data.description])