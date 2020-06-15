extends Node

var time = 0
var SPEED = 1

enum Player {GM, P0, P1, P2, P3}

var GM_CTRL = Controller.Device.C1
var P0_CTRL = Controller.Device.C0

func set_ctrl(player, ctrl):
	match player:
		Player.GM: GM_CTRL=ctrl
		Player.P0: P0_CTRL=ctrl

func get_ctrl(player):
	match player:
		Player.GM: return GM_CTRL
		Player.P0: return P0_CTRL

func set_time(t):
	time = t

func get_time(t):
	return time

func inc_speed():
	SPEED *= 1.2
