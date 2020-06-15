extends Label
var timer
var time = 10

func _ready():
	Global.set_time(time)
	timer = Timer.new()
	timer.connect("timeout", self, "on_timer_timeout")
	timer.set_wait_time(1)
	add_child(timer)
	timer.start()
	pass

func _process(delta):
	text = str(time)

func on_timer_timeout():
	Global.set_time(time)
	if time <= 0:
		get_tree().change_scene("Switch Sides.tscn")
	else:
		time -= 1
		timer.start()
