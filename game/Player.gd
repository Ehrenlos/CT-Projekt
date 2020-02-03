extends KinematicBody2D


var MAX_SPEED = 400
var motion = Vector2.ZERO
var controller = load("Controller.gd").new(Controller.Device.C0)

func _physics_process(delta):
	motion = Vector2.ZERO
	var axis = controller.get_input_axis(0)
	apply_movement(axis * delta)
	if controller.get_device() == Controller.Device.KEYBOARD:
		look_at(get_global_mouse_position())
	elif axis != Vector2.ZERO:
		rotation = controller.get_input_axis(1).angle()
	motion = move_and_slide(motion)

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.normalized() * MAX_SPEED
