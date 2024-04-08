extends Control
class_name StatusMenu

@onready var stat_desc: Label = $StatDesc
@onready var for_label: Label = $Statbox/ForBox/ForLabel
@onready var int_label: Label = $Statbox/IntBox/IntLabel
@onready var str_label: Label = $Statbox/StrBox/StrLabel
@onready var har_label: Label = $Statbox/HarBox/HarLabel
@onready var yee_label: Label = $Statbox/YeeBox/YeeLabel
@onready var money_label: Label = $MoneyLabel
@onready var debt_money_label: Label = $DebtMoneyLabel
@onready var health_bar: TextureProgressBar = $HealthBar
@onready var stamina_bar: TextureProgressBar = $StaminaBar
@onready var health_label: Label = $HealthBar/Label
@onready var stamina_label: Label = $StaminaBar/Label

var player_menu: PlayerMenu

func init():
	stat_desc.text = ""
	player_menu = get_parent().get_parent()
	refresh_stat()

func refresh_stat():
	for_label.text = "FOR: " + str(player_menu.player.for_stat)
	int_label.text = "INT: " + str(player_menu.player.int_stat)
	str_label.text = "STR: " + str(player_menu.player.str_stat)
	har_label.text = "HAR: " + str(player_menu.player.har_stat)
	yee_label.text = "YEE: " + str(player_menu.player.yee_stat)
	money_label.text = "Money: " + str(player_menu.player.money) + "$"
	debt_money_label.text = "Debt money: " + str(GameManager.debt_money) + "$"

func update_health_bar(current_hp, max_hp):
	health_label.text = str(current_hp) + "/" + str(max_hp)
	health_bar.max_value = max_hp
	health_bar.value = current_hp

func update_stamina_bar(current_sp, max_sp):
	stamina_label.text = str(current_sp) + "/" + str(max_sp)
	stamina_bar.max_value = max_sp
	stamina_bar.value = current_sp

func _on_for_label_mouse_entered() -> void:
	stat_desc.text = "Fortitude.\n\nIndicate fish's resistance, both mentally and physically. Increase max health and stamina"

func _on_int_label_mouse_entered() -> void:
	stat_desc.text = "Intelligent.\n\nIndicate fish's smartness. Smart fish can make more money with white-gill jobs and solve puzzles easier."

func _on_str_label_mouse_entered() -> void:
	stat_desc.text = "Strength.\n\nIndicate fish's physical prowess. Strong fish can make more money with blue-gill jobs and attack other fishes more effective."

func _on_har_label_mouse_entered() -> void:
	stat_desc.text = "Harmony.\n\nIndicate fish's flexibility and adaptability. Harmonic fish is charismatic fish. Also it's easier for fish to blend into the environment."

func _on_yee_label_mouse_entered() -> void:
	stat_desc.text = "Yeetiness.\n\nIndicate fish's quickness. Yeety fish is fast fish. Increase movement speed and escape chance."
