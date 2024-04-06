@tool
extends HBoxContainer
class_name WorkButton

@export var job_name: String = "Job"
@export var job_pay: int = 10
@export var job_time_needed: int = 1
@export var reputation_xp: int = 0
@export var company: CompanyWork

@export var need_for_stat = 0
@export var need_int_stat = 0
@export var need_str_stat = 0
@export var need_har_stat = 0
@export var need_yee_stat = 0

@onready var button: Button = $Button
@onready var label: Label = $Label

func _ready() -> void:
	button.text = job_name
	label.text = "{0}$ / {1} period(s)".format([job_pay, job_time_needed])
	if not Engine.is_editor_hint():
		GameManager.time_passed.connect(update_work_status)
		update_work_status()

func update_work_status():
	button.disabled = false
	button.text = job_name
	label.text = "{0}$ / {1} period(s)".format([job_pay * company.current_reputation_level, job_time_needed])

	# Check availability
	if job_time_needed > GameManager.get_time_left():
		button.disabled = true
	if GameManager.player != null:
		if GameManager.player.for_stat < need_for_stat:
			button.disabled = true
			button.text = "Need {0} FOR.".format([need_for_stat])
		if GameManager.player.int_stat < need_int_stat:
			button.disabled = true
			button.text = "Need {0} INT.".format([need_int_stat])
		if GameManager.player.str_stat < need_str_stat:
			button.disabled = true
			button.text = "Need {0} STR.".format([need_str_stat])
		if GameManager.player.har_stat < need_har_stat:
			button.disabled = true
			button.text = "Need {0} HAR.".format([need_har_stat])
		if GameManager.player.yee_stat < need_yee_stat:
			button.disabled = true
			button.text = "Need {0} YEE.".format([need_yee_stat])

func _on_button_pressed() -> void:
	if GameManager.player != null:
		GameManager.player.money += job_pay * company.current_reputation_level
	company.gain_xp(reputation_xp)
	GameManager.pass_time(job_time_needed)
