extends KinematicBody2D
class_name PlayerCharacter

var SPEED = 400
var motion = Vector2.ZERO
var controller
var attack_ready
var attack_timer
var lives = 3
const WINDOW_HEIGHT = 600
const WINDOW_WIDTH = 927

func _init(device = Global.get_ctrl(Global.Player.P0)):
	controller = Controller.new(device)
	if device == Controller.Device.KEYBOARD:
		Input.set_custom_mouse_cursor(load("res://Cursor.png"))
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	

func _ready():
	add_to_group("Player")
	
	attack_timer = Timer.new()
	attack_timer.connect("timeout", self, "on_attack_timer_timeout")
	attack_timer.set_wait_time(0.25)
	add_child(attack_timer)
	attack_ready = true

func _physics_process(delta):
	motion = Vector2.ZERO
	apply_movement(controller.get_input_axis(0) * delta)
	if controller.get_device() == Controller.Device.KEYBOARD:
		look_at(get_global_mouse_position())
	elif controller.get_input_axis(1) != Vector2.ZERO:
		rotation = controller.get_input_axis(1).angle()
	motion = move_and_slide(motion)
	

	
	if position.x < 24:
		set_position(Vector2(24, position.y))
	if position.x > WINDOW_WIDTH - 24:
		set_position(Vector2(WINDOW_WIDTH - 24, position.y))
	if position.y < 24:
		set_position(Vector2(position.x, 24))
	if position.y > WINDOW_HEIGHT - 24:
		set_position(Vector2(position.x, WINDOW_HEIGHT - 24))
	
	if controller.is_just_pressed(Controller.Button.ATTACK) && attack_ready:
		var sword = preload("res://Sword.tscn").instance()
		sword.add_to_group("Weapon")
		add_child(sword)
		attack_ready = false
		attack_timer.start()

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.normalized() * SPEED

func on_attack_timer_timeout():
	attack_ready = true

func get_position():
	return Vector2(position.x, position.y)

func on_hit(collider):
	collider.on_hit(self)
	lives -= 1
	print("Lives:", lives)
	$Hearts.update()
	if lives <= 0:
		on_death()

func on_death():
	get_tree().change_scene("Game Over.tscn")

