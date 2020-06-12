extends Node
class_name Controller

enum Device {C0, C1, C2, C3, KEYBOARD}
enum Analog_Stick {LEFT, RIGHT}
const Button = {L="L1", R="R1", ZL="L2", ZR="R2", ATTACK="R1"}

func _init(init_device=Device.KEYBOARD):
	set_device(init_device)

var device setget set_device, get_device #0 - 3 = c0 - c3; 4 = kb

func set_device(new_device = Device.KEYBOARD):
	device = new_device

func get_device():
	return device

func get_input_axis(stick):
	var axis = Vector2.ZERO
	var d = String(device)
	var s = String(stick)
	axis.x = Input.get_action_strength(d + s + "_right") - Input.get_action_strength(d + s + "_left")
	axis.y = Input.get_action_strength(d + s + "_down")  - Input.get_action_strength(d + s + "_up")
	return axis.normalized()

func is_pressed(button):
	return Input.is_action_pressed(String(device) + "_" + String(button));

func is_just_pressed(button):
	 return Input.is_action_just_pressed(String(device) + "_" + String(button));

func is_just_released(button):
	 return Input.is_action_just_released(String(device) + "_" + String(button));
