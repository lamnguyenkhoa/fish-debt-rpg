extends Control
class_name CompanyWork

@export var xp_per_level: Array[int] = [100] # Need at least 1

@onready var reputation_label: Label = $ReputationLabel
@onready var reputation_progress: TextureProgressBar = $ReputationProgress
@onready var progress_label: Label = $ReputationProgress/ProgressLabel

var max_reputation_level: int = 1
var current_reputation_level: int = 1
var current_xp: int = 0

func _ready() -> void:
	max_reputation_level = len(xp_per_level) + 1
	reputation_label.text = "Reputation - {0}".format([current_reputation_level])
	reputation_progress.value = (float(current_xp) / xp_per_level[current_reputation_level - 1]) * 100
	progress_label.text = "{0} / {1}".format([current_xp, xp_per_level[current_reputation_level - 1]])

func gain_xp(amount: int):
	if current_reputation_level >= max_reputation_level:
		return

	current_xp += amount
	if current_xp >= xp_per_level[current_reputation_level - 1]:
		current_reputation_level += 1
		current_xp = 0
		if current_reputation_level >= max_reputation_level:
			reputation_label.text = "Reputation - {0}".format([current_reputation_level])
			reputation_progress.value = 100
			progress_label.text = "Maxed reputation!"
			return
	
	reputation_label.text = "Reputation - {0}".format([current_reputation_level])
	reputation_progress.value = (float(current_xp) / xp_per_level[current_reputation_level - 1]) * 100
	progress_label.text = "{0} / {1}".format([current_xp, xp_per_level[current_reputation_level - 1]])
