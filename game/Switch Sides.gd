extends Node2D

func _ready():
	$Music.play(0)
	var gm_ctrl = Global.get_ctrl(Global.Player.GM)
	var p0_ctrl = Global.get_ctrl(Global.Player.P0)
	Global.set_ctrl(Global.Player.GM, p0_ctrl)
	Global.set_ctrl(Global.Player.P0, gm_ctrl)
	pass

func _input(event):
	get_tree().change_scene("res://World.tscn")
