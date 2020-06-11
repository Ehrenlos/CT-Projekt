extends KinematicBody2D
class_name GameMaster

var SPEED = 400
var motion = Vector2.ZERO
var controller
var WINDOW_HEIGHT = 600
var WINDOW_WIDTH = 1024

func _init(device=Controller.Device.KEYBOARD):
	controller = Controller.new(device)

func _ready():
	add_to_group("GameMaster")

func _physics_process(delta):
	if controller.device == Controller.Device.KEYBOARD:
		set_position(get_global_mouse_position())
	else:
		motion = Vector2.ZERO
		apply_movement(controller.get_input_axis(0) * delta)
		motion = move_and_slide(motion)
	if position.x < 0:
		set_position(Vector2(0, position.y))
	if position.x > WINDOW_WIDTH - 16:
		set_position(Vector2(WINDOW_WIDTH - 16, position.y))
	if position.y < 0:
		set_position(Vector2(position.x, 0))
	if position.y > WINDOW_HEIGHT - 16:
		set_position(Vector2(position.x, WINDOW_HEIGHT - 16))
	
	
	if controller.is_just_pressed(Controller.Button.ATTACK):
		pass

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.normalized() * SPEED

