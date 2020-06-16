extends KinematicBody2D
var c0 : Controller
var c1 : Controller
var kb : Controller
var controller = false
var motion
const WINDOW_HEIGHT = 600
const WINDOW_WIDTH = 1066
const SPEED = 800
var area : Area2D
var last_mouse_pos = Vector2()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	c0 = Controller.new(Controller.Device.C0)
	c1 = Controller.new(Controller.Device.C1)
	kb = Controller.new(Controller.Device.KEYBOARD)
	area = get_node("Area2D")
	

func _process(delta):
	if last_mouse_pos != get_global_mouse_position():
		position = get_global_mouse_position()
	last_mouse_pos = get_global_mouse_position()
	
	motion = Vector2.ZERO
	apply_movement(c0.get_input_axis(0) * delta)
	apply_movement(c1.get_input_axis(0) * delta)
	motion = move_and_slide(motion)
	
	if position.x < 0:
		set_position(Vector2(0, position.y))
	if position.x > WINDOW_WIDTH - 16:
		set_position(Vector2(WINDOW_WIDTH - 16, position.y))
	if position.y < 0:
		set_position(Vector2(position.x, 0))
	if position.y > WINDOW_HEIGHT - 16:
		set_position(Vector2(position.x, WINDOW_HEIGHT - 16))
		
	if c0.is_just_pressed(Controller.Button.ATTACK) || c1.is_just_pressed(Controller.Button.ATTACK) || kb.is_just_pressed(Controller.Button.ATTACK):
		if area.get_overlapping_areas():
			match area.get_overlapping_areas()[0].name:
				"Start_Game":get_tree().change_scene("World.tscn")
				"Close_Game":get_tree().quit()

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.normalized() * SPEED
