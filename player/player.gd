extends CharacterBody2D
class_name Player

@onready var sprite: Sprite2D = $Sprite2D

const SPEED = 200

func _process(_delta):
	# Input handling
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1

	# Normalize diagonal movement
	velocity = velocity.normalized() * SPEED

	if velocity.x < 0:
		sprite.scale.x = 0.2
	if velocity.x > 0:
		sprite.scale.x = -0.2

	# Move the player
	move_and_slide()
