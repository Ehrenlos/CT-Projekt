extends KinematicBody2D
class_name PlayerCharacter

var SPEED = 400
var motion = Vector2.ZERO
var controller

func _init(device=Controller.Device.KEYBOARD):
	controller = load("Controller.gd").new(device)

func _physics_process(delta):
	motion = Vector2.ZERO
	apply_movement(controller.get_input_axis(0) * delta)
	if controller.get_device() == Controller.Device.KEYBOARD:
		look_at(get_global_mouse_position())
	elif controller.get_input_axis(1) != Vector2.ZERO:
		rotation = controller.get_input_axis(1).angle()
	motion = move_and_slide(motion)

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.normalized() * SPEED