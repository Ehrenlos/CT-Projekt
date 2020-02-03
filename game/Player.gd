extends KinematicBody2D

var MAX_SPEED = 400
var motion = Vector2.ZERO

func _physics_process(delta):
	motion = Vector2.ZERO
	var axis = get_input_axis()
	apply_movement(axis * delta)
	motion = move_and_slide(motion)
	rotation = get_input_axis().angle()
	#look_at(get_global_mouse_position())

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	axis.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	return axis.normalized()

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.normalized() * MAX_SPEED
