extends Interactable
class_name CompanyBuilding

@export var interact_text: String
@export var open_work_ui: CompanyWork

func interact(_player: Player):
	open_work_ui.visible = true
	GameManager.player.in_work = true
	GameManager.player_menu.close_menu()

func get_interact_text(_player: Player) -> String:
	return interact_text
