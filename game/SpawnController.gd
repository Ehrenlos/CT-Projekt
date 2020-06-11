extends Node
class_name SpawnController
var mana = 0
var MAX_MANA = 10
var progress 
var prog_timer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	progress = get_child(0)
	prog_timer = Timer.new()
	prog_timer.connect("timeout", self, "on_prog_timer_timeout")
	prog_timer.set_wait_time(0.01)
	add_child(prog_timer)
	prog_timer.start()

func inc_mana():
	if mana <= MAX_MANA:
		mana += 1

func use_mana(cost):
	if mana >= cost:
		mana -= cost
		return true
	else:
		return false

func on_prog_timer_timeout():
	if progress.value == 100:
		progress.value = 0
		inc_mana()
	progress.value += 1
	prog_timer.start()
