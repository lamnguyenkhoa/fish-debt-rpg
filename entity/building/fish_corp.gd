extends Interactable

func interact(_player: Player):
	print("You worked here")
	return

func get_interact_text(_player: Player) -> String:
	return "Work here"