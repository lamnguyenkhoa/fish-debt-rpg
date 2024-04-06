extends Control
class_name GameUI

@onready var money_label: Label = $TopBanner/MoneyLabel
@onready var day_label: RichTextLabel = $TopBanner/DayLabel
@onready var time_dial: TextureProgressBar = $TopBanner/TimeDial

func _ready() -> void:
	GameManager.game_ui = self
	GameManager.time_passed.connect(update_time_dial)
	time_dial.value = 0

func update_money_text(amount: int):
	money_label.text = "Money: {0}$".format([amount])

func update_time_dial():
	time_dial.value = GameManager.current_time