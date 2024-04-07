extends CharacterBody2D
class_name Player

@onready var sprite: Sprite2D = $FishSprite
@onready var interact_label: Label = $InteractLabel
@onready var interact_area: Area2D = $InteractArea

const BASE_MOVESPEED = 200
const BASE_HEALTH = 50
const BASE_STAMINA = 50

var max_hp: int = BASE_HEALTH:
	set(value):
		max_hp = value
		player_menu.update_health_bar(current_hp, value)
var max_sp: int = BASE_STAMINA:
	set(value):
		max_sp = value
		player_menu.update_stamina_bar(current_sp, value)
var current_hp: int = BASE_HEALTH:
	set(value):
		current_hp = value
		player_menu.update_health_bar(value, max_hp)
var current_sp: int = BASE_STAMINA:
	set(value):
		current_sp = value
		player_menu.update_stamina_bar(value, max_sp)
var for_stat = 10 # Each point increase health and stamina by 5
var int_stat = 99
var str_stat = 10
var har_stat = 10
var yee_stat = 10 # Each point increase movespeed by 2%
var money: int = 0:
	set(value):
		if value < 0:
			value = 0
		money = value
		GameManager.game_ui.update_money_text(value)
		GameManager.player_menu.refresh_stat()

var player_menu: PlayerMenu = null
var direction: Vector2 = Vector2.ZERO
var things_in_range = []
var in_work = false

func _ready() -> void:
	GameManager.player = self
	await get_tree().process_frame
	await get_tree().process_frame
	player_menu = GameManager.player_menu
	recalculate_stat()
	current_hp = max_hp
	current_sp = max_sp

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_player_menu") and not in_work:
		GameManager.player_menu.toggle_menu()

func _physics_process(_delta):
	# Clear previous items in range
	things_in_range.clear()
	# Check for nearby items
	var bodies = interact_area.get_overlapping_bodies()
	for body in bodies:
		if body is Interactable:
			things_in_range.append(body)
	if things_in_range.size() > 0:
		set_interact_label(things_in_range[0].get_interact_text(self))
	else:
		set_interact_label("")
	# Handle pickup input
	if Input.is_action_just_pressed("interact") and things_in_range.size() > 0 and not in_work:
		# You can prioritize certain types of items or implement a way for the player to cycle through them
		things_in_range[0].interact(self) # For simplicity, picking up the first item in range
	# Movement
	direction = Vector2.ZERO
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if not in_work:
		velocity = direction * BASE_MOVESPEED * (1 + yee_stat / 50.0)
	else:
		velocity = Vector2.ZERO

	if velocity.x < 0:
		sprite.scale.x = 0.2
	if velocity.x > 0:
		sprite.scale.x = -0.2

	move_and_slide()

func recalculate_stat():
	max_hp = BASE_HEALTH + for_stat * 5
	max_sp = BASE_STAMINA + for_stat * 5

func damaged(type: String, value: int):
	if type == "hp":
		current_hp = clamp(current_hp - value, 0, max_hp)
	else:
		current_sp = clamp(current_sp - value, 0, max_sp)

func set_interact_label(text: String):
	if text != interact_label.text:
		interact_label.text = text
