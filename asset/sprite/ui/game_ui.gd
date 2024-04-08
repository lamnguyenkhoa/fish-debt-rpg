extends Control
class_name GameUI

@onready var money_label: Label = $TopBanner/MoneyLabel
@onready var day_label: RichTextLabel = $TopBanner/DayLabel
@onready var time_dial: TextureProgressBar = $TopBanner/TimeDial
@onready var notification_ui: NotificationUI = $NotificationUI
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	GameManager.game_ui = self
	GameManager.time_passed.connect(update_time_dial)
	GameManager.day_passed.connect(update_day_label)
	time_dial.value = 0

func update_money_text(amount: int):
	money_label.text = "Money: {0}$".format([amount])

func update_time_dial():
	time_dial.value = GameManager.current_time

func update_day_label():
	if GameManager.day_left <= 5:
		day_label.text = "[shake]Days left: {0}[/shake]".format([GameManager.day_left])
	else:
		day_label.text = "Days left: {0}".format([GameManager.day_left])

func play_day_transition():
	anim_player.play("day_transition")