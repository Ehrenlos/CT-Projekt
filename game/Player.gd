extends KinematicBody2D

var MAX_SPEED = 400
var ACCELERATION = 1
var motion = Vector2.ZERO

func _physics_process(delta):
	motion = Vector2.ZERO
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		motion = Vector2.ZERO
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	axis.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	return axis.normalized()

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.normalized() * MAX_SPEED
