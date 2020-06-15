extends Node2D
var timer
var time = 5

func _ready():
	Global.set_time(time)
	timer = Timer.new()
	timer.connect("timeout", self, "on_timer_timeout")
	timer.set_wait_time(1)
	add_child(timer)
	timer.start()
	pass

func _process(delta):
	$Label.text = str(time)

func on_timer_timeout():
	Global.set_time(time)
	if time <= 0:
		Global.inc_speed()
		var gm_ctrl = Global.get_ctrl(Global.Player.GM)
		var p0_ctrl = Global.get_ctrl(Global.Player.P0)
		Global.set_ctrl(Global.Player.GM, p0_ctrl)
		Global.set_ctrl(Global.Player.P0, gm_ctrl)
		get_tree().change_scene("World.tscn")
	else:
		time -= 1
		timer.start()
