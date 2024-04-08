extends Interactable
class_name NPCFish

@export var fish_name: String
@export var tier: int = 1
@export var is_hostile: bool
@export var max_hp: int
@export var stats: Array[int] = [0, 0, 0, 0, 0]

@onready var name_label: Label = $NameLabel

var current_hp: int

func _ready() -> void:
	current_hp = max_hp
	name_label.text = fish_name

func interact(_player: Player):
	GameManager.open_npc_interact_ui(self)

func get_interact_text(_player: Player) -> String:
	return "Interact"

func damaged(value: int, is_percentage_max: bool=false):
	if is_percentage_max:
		current_hp = clamp(current_hp - (max_hp * (value / 100.0)), 0, max_hp)
	else:
		current_hp = clamp(current_hp - value, 0, max_hp)
