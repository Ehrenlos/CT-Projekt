extends Node2D


var spawn_time
var time

func _ready():
	spawn_time = Global.time
	time = Global.time
	print(spawn_time)

func _process(delta):
	if Global.time <= spawn_time - 10:
		queue_free()
	elif Global.time != time:
		time = Global.time
		modulate.a -= 0.1
