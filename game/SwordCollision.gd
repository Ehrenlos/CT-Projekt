extends Area2D

func _physics_process(delta):
	if get_overlapping_bodies().size() > 1:
		get_overlapping_bodies().pop_front()
		for b in get_overlapping_bodies():
			if b.is_in_group("Mobs"):
				b.on_hit(get_parent())
