extends Control
class_name PlayerMenu

@onready var tab_container: TabContainer = $TabContainer
@onready var stat_desc: Label = $TabContainer/Status/StatDesc

func _ready():
	stat_desc.text = ""

func _on_for_label_mouse_entered() -> void:
	stat_desc.text = "Fortitude.\n\nIndicate fish's resistance, both mentally and physically."

func _on_int_label_mouse_entered() -> void:
	stat_desc.text = "Intelligent.\n\nIndicate fish's smartness. Smart fish make more money with white-gill jobs and solve puzzles easier."

func _on_str_label_mouse_entered() -> void:
	stat_desc.text = "Strength.\n\nIndicate fish's physical prowess. Strong fish make more money with blue-gill jobs and attack other fishes more effective."

func _on_har_label_mouse_entered() -> void:
	stat_desc.text = "Harmony.\n\nIndicate fish's flexibility and adaptability. Harmonic fish is a charisma fish. Also it's easier for fish to blend into the environment."

func _on_yee_labe_mouse_entered() -> void:
	stat_desc.text = "Yeet.\n\nIndicate fish's quickness. Yeety fish is fast fish."
