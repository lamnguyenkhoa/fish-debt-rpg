extends Control
class_name PlayerMenu

@onready var tab_container: TabContainer = $TabContainer
@onready var stat_desc: Label = $TabContainer/Status/StatDesc
@onready var for_label: Label = $TabContainer/Status/Statbox/ForBox/ForLabel
@onready var int_label: Label = $TabContainer/Status/Statbox/IntBox/IntLabel
@onready var str_label: Label = $TabContainer/Status/Statbox/StrBox/StrLabel
@onready var har_label: Label = $TabContainer/Status/Statbox/HarBox/HarLabel
@onready var yee_label: Label = $TabContainer/Status/Statbox/YeeBox/YeeLabel
@onready var money_label: Label = $TabContainer/Status/MoneyLabel
@onready var debt_money_label: Label = $TabContainer/Status/DebtMoneyLabel
@onready var health_bar: TextureProgressBar = $TabContainer/Status/HealthBar
@onready var stamina_bar: TextureProgressBar = $TabContainer/Status/StaminaBar
@onready var health_label: Label = $TabContainer/Status/HealthBar/Label
@onready var stamina_label: Label = $TabContainer/Status/StaminaBar/Label

var player: Player = null

func _ready():
	stat_desc.text = ""
	GameManager.player_menu = self
	close_menu()
	await get_tree().process_frame
	await get_tree().process_frame
	player = GameManager.player
	refresh_stat()

func refresh_stat():
	for_label.text = "FOR: " + str(player.for_stat)
	int_label.text = "INT: " + str(player.int_stat)
	str_label.text = "STR: " + str(player.str_stat)
	har_label.text = "HAR: " + str(player.har_stat)
	yee_label.text = "YEE: " + str(player.yee_stat)
	money_label.text = "Money: " + str(player.money) + "$"
	debt_money_label.text = "Debt money: " + str(GameManager.debt_money) + "$"

func toggle_menu():
	if visible:
		close_menu()
	else:
		open_menu()

func open_menu():
	visible = true

func close_menu():
	visible = false

func update_health_bar(current_hp, max_hp):
	health_label.text = str(current_hp) + "/" + str(max_hp)
	health_bar.max_value = max_hp
	health_bar.value = current_hp

func update_stamina_bar(current_sp, max_sp):
	stamina_label.text = str(current_sp) + "/" + str(max_sp)
	stamina_bar.max_value = max_sp
	stamina_bar.value = current_sp

func _on_for_label_mouse_entered() -> void:
	stat_desc.text = "Fortitude.\n\nIndicate fish's resistance, both mentally and physically."

func _on_int_label_mouse_entered() -> void:
	stat_desc.text = "Intelligent.\n\nIndicate fish's smartness. Smart fish make more money with white-gill jobs and solve puzzles easier."

func _on_str_label_mouse_entered() -> void:
	stat_desc.text = "Strength.\n\nIndicate fish's physical prowess. Strong fish make more money with blue-gill jobs and attack other fishes more effective."

func _on_har_label_mouse_entered() -> void:
	stat_desc.text = "Harmony.\n\nIndicate fish's flexibility and adaptability. Harmonic fish is charismatic fish. Also it's easier for fish to blend into the environment."

func _on_yee_labe_mouse_entered() -> void:
	stat_desc.text = "Yeetiness.\n\nIndicate fish's quickness. Yeety fish is fast fish."

func _on_close_button_pressed() -> void:
	close_menu()
