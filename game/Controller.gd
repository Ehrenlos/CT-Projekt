extends Node
class_name Controller

func _init(device=Device.KEYBOARD):
	set_device(device)

var device setget set_device, get_device #0 - 3 = c0 - c3; 4 = kb

func set_device(new_device = Device.KEYBOARD):
	device = new_device

func get_device():
	return device

enum Device {C0, C1, C2, C3, KEYBOARD}
enum Analog_Stick {LEFT, RIGHT}

func get_input_axis(stick):
	var axis = Vector2.ZERO
	var d = String(device)
	var s = String(stick)
	axis.x = Input.get_action_strength(d + s + "_right") - Input.get_action_strength(d + s + "_left")
	axis.y = Input.get_action_strength(d + s + "_down")  - Input.get_action_strength(d + s + "_up")
	return axis.normalized()
