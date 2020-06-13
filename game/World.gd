extends Node


class_name GameWorld

static func dropHeart(pos, world):
	var heart = preload("res://Heart.tscn").instance()
	heart.set_position(pos)
	world.add_child(heart)
	print("Heart dropped at:", pos)
