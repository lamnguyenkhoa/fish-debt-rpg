@tool
extends HBoxContainer
class_name ServiceButton

@export var service_name: String = "Buy item"
@export var service_desc: String = "Buy item desc"
@export var service_cost: int = 10
@export var reputation_xp: int = 0
@export var company: CompanyWork

# Service given
@export var give_item_id: EnumAutoload.ItemID = EnumAutoload.ItemID.NONE 
@export var give_item_amount: int = 1
@export var recover_hp: int = 0
@export var recover_sp: int = 0
@export var recover_hp_percentage: int = 0
@export var recover_sp_percentage: int = 0
@export var special_case: String = ""

@onready var button: Button = $Button
@onready var label: Label = $Label

func _ready() -> void:
	button.text = "{0} ({1}$)".format([service_name, service_cost])
	label.text = service_desc
	if not Engine.is_editor_hint():
		update_service_status()
		company.ui_opened.connect(update_service_status)
		GameManager.time_passed.connect(update_service_status)
		GameManager.player.money_changed.connect(update_service_status)

func update_service_status():
	button.disabled = false
	if GameManager.player.money < service_cost:
		button.disabled = true

func _on_button_pressed():
	GameManager.player.money -= service_cost
	if give_item_id != EnumAutoload.ItemID.NONE:
		print("Buy item id ", give_item_id)
	if special_case != "":
		#TODO
		pass
	GameManager.player.recover("hp", recover_hp, false)
	GameManager.player.recover("hp", recover_hp_percentage, true)
	GameManager.player.recover("sp", recover_sp, false)
	GameManager.player.recover("sp", recover_sp_percentage, true)

	
	
