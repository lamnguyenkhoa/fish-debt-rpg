extends Node2D

@export var main_game_scene: PackedScene

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_game_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
