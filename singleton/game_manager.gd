extends Node

var debt_money = 1000000
var interest_rate = 1.05
var day_left = 20
var timephase = 0 # 8 is end

var player: Player
var player_menu: PlayerMenu

signal time_passed

func get_time_left():
	return 1000000
	return 8 - timephase

func pass_time(time: int):
	timephase = clampi(timephase + time, 0, 8)
	emit_signal("time_passed")