extends HBoxContainer
class_name ItemButton

@onready var button: Button = $Button
@onready var label: Label = $Label

var item_data: ItemResource
var inventory_menu: InventoryMenu

func refresh_data():
	if item_data == null:
		return
	button.text = item_data.name
	label.text = "x" + str(GameManager.player.inventory[item_data.item_id])

func _on_button_mouse_entered() -> void:
	if inventory_menu == null or item_data == null:
		return
	inventory_menu.show_item_description(item_data)
	SoundManager.play_button_hover_sfx()

func _on_button_pressed() -> void:
	SoundManager.play_button_click_sfx()

	if item_data.type == EnumAutoload.ItemType.CONSUMABLE:
		GameManager.player.lost_item(item_data.item_id, 1)

func resolve_item_effect(_item_data: ItemResource):
	GameManager.player.recover("hp", _item_data.recover_hp, false)
	GameManager.player.recover("hp", _item_data.recover_hp_percentage, true)
	GameManager.player.recover("sp", _item_data.recover_sp, false)
	GameManager.player.recover("sp", _item_data.recover_sp_percentage, true)
	if _item_data.special_case != "":
		#TODO
		return
