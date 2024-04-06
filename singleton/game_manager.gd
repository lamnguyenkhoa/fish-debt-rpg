extends Node

var debt_money = 1000000
var interest_rate = 1.05
var day_left = 20
var current_time = 0 # from 0 to 8, 8 unit of time

var player: Player
var player_menu: PlayerMenu
var game_ui: GameUI

signal time_passed

func get_time_left():
	return 8 - current_time

func pass_time(time: int):
	current_time = clampi(current_time + time, 0, 8)
	emit_signal("time_passed")