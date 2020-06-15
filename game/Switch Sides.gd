extends Node2D

func _ready():
	$Music.play(0)
	pass

func _input(event):
	get_tree().change_scene("res://World.tscn")
