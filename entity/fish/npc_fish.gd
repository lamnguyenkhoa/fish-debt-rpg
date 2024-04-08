@tool
extends Interactable
class_name NPCFish

@export var fish_name: String
@export var tier: int = 1
@export var is_hostile: bool
@export var flip_sprite: bool
@export var max_hp: int
@export var stats: Array[int] = [0, 0, 0, 0, 0]
@export var defeat_loot: Array[EnumAutoload.ItemId]

@onready var name_label: Label = $NameLabel
@onready var fish_sprite: Sprite2D = $Fish

var current_hp: int
var dead = false
var defeat_money: int

func _ready() -> void:
	if flip_sprite:
		fish_sprite.scale.x = -fish_sprite.scale.x
	if not Engine.is_editor_hint():
		current_hp = max_hp
		name_label.text = fish_name
		randomly_set_defeat_money()
		GameManager.day_passed.connect(revive)

func interact(_player: Player):
	GameManager.open_npc_interact_ui(self)

func get_interact_text(_player: Player) -> String:
	return "Interact"

func damaged(value: int, is_percentage_max: bool=false):
	if is_percentage_max:
		current_hp = clamp(current_hp - (max_hp * (value / 100.0)), 0, max_hp)
	else:
		current_hp = clamp(current_hp - value, 0, max_hp)
	if current_hp <= 0:
		death()

func death():
	GameManager.player.money += defeat_money
	for item_id in defeat_loot:
		GameManager.player.acquired_item(item_id, 1)
	dead = true
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED

func revive():
	randomly_set_defeat_money()
	current_hp = max_hp
	dead = false
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT

func randomly_set_defeat_money():
	match tier:
		1:
			defeat_money = randi_range(300, 1000)
		2:
			defeat_money = randi_range(5000, 20000)
		3:
			defeat_money = randi_range(50000, 90000)
		_:
			defeat_money = randi_range(100, 500)