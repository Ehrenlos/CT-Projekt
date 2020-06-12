extends Node2D

func _ready():
	var timer = get_node("Timer")
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.start(0.15)

func _on_Timer_timeout():
	get_parent().remove_child(self)
