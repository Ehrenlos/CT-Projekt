extends Area2D

var spawn_time

func _ready():
	spawn_time = Global.time
	print(spawn_time)

func _physics_process(delta):
	if get_overlapping_bodies():
		for b in get_overlapping_bodies():
			if b.is_in_group("Player"):
				b.lives += 1
				queue_free()
				b.get_node("Hearts").update()
	if Global.time <= spawn_time - 5:
		queue_free()
