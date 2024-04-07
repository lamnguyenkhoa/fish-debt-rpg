@tool
extends HBoxContainer
class_name ServiceButton

@export var service_name: String = "Buy item"
@export var service_desc: String = "Buy item desc"
@export var service_cost: int = 10
@export var reputation_xp: int = 0
@export var company: CompanyWork

# Service given
@export var give_item_id: EnumAutoload.ItemId = EnumAutoload.ItemId.NONE
@export var give_item_amount: int = 1
@export var recover_hp: int = 0
@export var recover_sp: int = 0
@export var recover_hp_percentage: int = 0
@export var recover_sp_percentage: int = 0
@export var special_case: EnumAutoload.ServiceSpecialCase

@onready var button: Button = $Button
@onready var label: Label = $Label

func _ready() -> void:
	if service_cost > 0:
		button.text = "{0} ({1}$)".format([service_name, service_cost])
	else:
		button.text = "{0}".format([service_name])
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
	SoundManager.play_button_click_sfx()
	GameManager.player.money -= service_cost
	if give_item_id != EnumAutoload.ItemId.NONE:
		GameManager.player.acquired_item(give_item_id, give_item_amount)
	if special_case != EnumAutoload.ServiceSpecialCase.NONE:
		resolve_special_case(special_case)
	GameManager.player.recover("hp", recover_hp, false)
	GameManager.player.recover("hp", recover_hp_percentage, true)
	GameManager.player.recover("sp", recover_sp, false)
	GameManager.player.recover("sp", recover_sp_percentage, true)

func resolve_special_case(_special_case: EnumAutoload.ServiceSpecialCase):
	match _special_case:
		EnumAutoload.ServiceSpecialCase.NEXT_DAY:
			GameManager.move_to_next_day()

func play_button_hover_sfx():
	SoundManager.play_button_hover_sfx()