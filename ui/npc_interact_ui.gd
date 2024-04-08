extends Control
class_name NPCInteractUI

@onready var npc_name_label: Label = $NPCName
@onready var tab_container: TabContainer = $TabContainer
@onready var fight_button: Button = $TabContainer/Normal/HBoxContainer/FightButton
@onready var combat_log: RichTextLabel = $TabContainer/Fight/BattleLog
@onready var player_hp_bar: TextureProgressBar = $TabContainer/Fight/PlayerHPBar
@onready var player_hp_label: Label = $TabContainer/Fight/PlayerHPBar/Label
@onready var enemy_hp_bar: TextureProgressBar = $TabContainer/Fight/EnemyHPBar
@onready var enemy_hp_label: Label = $TabContainer/Fight/EnemyHPBar/Label

var target_npc: NPCFish

func _ready():
	visible = false
	GameManager.npc_interact_ui = self

func open_ui(_target_npc: NPCFish):
	GameManager.player.is_busy = true
	visible = true
	tab_container.current_tab = 0
	target_npc = _target_npc
	npc_name_label.text = target_npc.fish_name
	if target_npc.is_hostile:
		npc_name_label.self_modulate = Color.RED
		fight_button.disabled = false
	else:
		npc_name_label.self_modulate = Color.GREEN
		fight_button.disabled = true

func close_ui():
	visible = false
	GameManager.player.is_busy = false

func _on_leave_pressed() -> void:
	close_ui()
	SoundManager.play_button_click_sfx()

func _on_fight_button_pressed() -> void:
	combat_log.text = ""
	update_healthbar()
	tab_container.current_tab = 1
	SoundManager.play_button_click_sfx()

func _on_attack_button_pressed() -> void:
	target_npc.damaged(GameManager.player.str_stat)
	combat_log.text += "You attacked the [color=red]enemy[/color] for [color=yellow]{0}[/color] damage\n".format([GameManager.player.str_stat])
	GameManager.player.damaged("hp", target_npc.stats[2])
	combat_log.text += "The [color=red]enemy[/color] attacked you for [color=yellow]{0}[/color] damage\n".format([target_npc.stats[2]])
	update_healthbar()
	combat_log.text += '- - -\n'
	SoundManager.play_button_click_sfx()

func _on_special_button_pressed() -> void:
	target_npc.damaged(GameManager.player.str_stat * 2)
	GameManager.player.damaged("sp", 20)
	combat_log.text += "You attacked the [color=red]enemy[/color] for [color=yellow]{0}[/color] damage\n".format([GameManager.player.str_stat * 2])
	GameManager.player.damaged("hp", target_npc.stats[2])
	combat_log.text += "The [color=red]enemy[/color] attacked you for [color=yellow]{0}[/color] damage\n".format([target_npc.stats[2]])
	update_healthbar()
	combat_log.text += '- - -\n'
	SoundManager.play_button_click_sfx()

func _on_defend_button_pressed() -> void:
	SoundManager.play_button_click_sfx()
	
func _on_escape_button_pressed() -> void:
	close_ui()
	SoundManager.play_button_click_sfx()

func update_healthbar():
	player_hp_bar.value = (GameManager.player.current_hp / float(GameManager.player.max_hp)) * 100
	player_hp_label.text = "{0} / {1}".format([GameManager.player.current_hp, GameManager.player.max_hp])
	enemy_hp_bar.value = (target_npc.current_hp / float(target_npc.max_hp)) * 100
	enemy_hp_label.text = "{0} / {1}".format([target_npc.current_hp, target_npc.max_hp])
