extends Label
var timer
var time = 60

func _ready():
	timer = Timer.new()
	timer.connect("timeout", self, "on_timer_timeout")
	timer.set_wait_time(1)
	add_child(timer)
	timer.start()
	pass

func _process(delta):
	text = str(time)

func on_timer_timeout():
	if time <= 0:
		get_tree().change_scene("Game Over.tscn")
	else:
		time -= 1
		timer.start()
