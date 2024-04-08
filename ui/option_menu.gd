extends Control
class_name OptionMenu

@onready var master_slider: HSlider = $AudioGroup/MasterSlider
@onready var bgm_slider: HSlider = $AudioGroup/BGMSlider
@onready var sfx_slider: HSlider = $AudioGroup/SFXSlider

var is_starting_up = true

func _ready() -> void:
	master_slider.value = SoundManager.get_master_volume() * 100
	bgm_slider.value = SoundManager.get_music_volume() * 100
	sfx_slider.value = SoundManager.get_sound_volume() * 100
	is_starting_up = false

func _on_sfx_slider_value_changed(value: float) -> void:
	if not is_starting_up:
		SoundManager.play_button_click_sfx()
	SoundManager.set_sound_volume(value / 100)

func _on_bgm_slider_value_changed(value: float) -> void:
	if not is_starting_up:
		SoundManager.play_button_click_sfx()
	SoundManager.set_music_volume(value / 100)

func _on_master_slider_value_changed(value: float) -> void:
	if not is_starting_up:
		SoundManager.play_button_click_sfx()
	SoundManager.set_master_volume(value / 100)
