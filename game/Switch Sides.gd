extends Node2D

var time_off = false



func _ready():
	var timer = Timer.new()
	timer.set_wait_time(5)
	timer.connect("timeout", self, "_on_Timer_timeout")
	add_child(timer)
	timer.start()

	$Music.play(0)
	var gm_ctrl = Global.get_ctrl(Global.Player.GM)
	var p0_ctrl = Global.get_ctrl(Global.Player.P0)
	Global.set_ctrl(Global.Player.GM, p0_ctrl)
	Global.set_ctrl(Global.Player.P0, gm_ctrl)

func _input(event):
	if time_off:
		get_tree().change_scene("res://World.tscn")

func _on_Timer_timeout():
	$press_any_button.visible = true
	time_off = true
