extends Node

class_name GameWorld

func _ready():
	$Music.play(0)


static func dropHeart(pos, world):
	var heart = preload("res://Heart.tscn").instance()
	heart.set_position(pos)
	world.add_child(heart)
	print("Heart dropped at:", pos)

static func addGrave(pos, world):
	var grave = preload("res://grave.tscn").instance()
	grave.set_position(pos)
	world.add_child(grave)
