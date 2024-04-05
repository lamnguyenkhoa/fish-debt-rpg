extends CharacterBody2D
class_name Player

@onready var sprite: Sprite2D = $FishSprite
@onready var interact_label: Label = $InteractLabel
@onready var interact_area: Area2D = $InteractArea

var speed: float = 200
var max_hp: int = 5 # health
var max_sp: int = 5 # stamina
var current_hp
var current_sp
var for_stat = 10
var int_stat = 10
var str_stat = 10
var har_stat = 10
var yee_stat = 10
var money = 0

var direction: Vector2 = Vector2.ZERO
var things_in_range = []

func _ready() -> void:
	GameManager.player = self
	current_hp = max_hp
	current_sp = max_sp

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_player_menu"):
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
	if Input.is_action_just_pressed("interact") and things_in_range.size() > 0:
		# You can prioritize certain types of items or implement a way for the player to cycle through them
		things_in_range[0].interact(self) # For simplicity, picking up the first item in range

	# Movement
	direction = Vector2.ZERO
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed

	if velocity.x < 0:
		sprite.scale.x = 0.2
	if velocity.x > 0:
		sprite.scale.x = -0.2

	move_and_slide()

func damaged(type: String, value: int):
	if type == "hp":
		current_hp = clamp(current_hp - value, 0, max_hp)
	else:
		current_sp = clamp(current_sp - value, 0, max_sp)

func set_interact_label(text: String):
	if text != interact_label.text:
		interact_label.text = text
