extends KinematicBody2D
class_name PlayerCharacter

var SPEED = 400
var motion = Vector2.ZERO
var controller
var attack_ready
var attack_timer

func _init(device=Controller.Device.KEYBOARD):
	controller = Controller.new(device)

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
	
	if controller.is_just_pressed(Controller.Button.ATTACK) && attack_ready:
		var sword = preload("res://Sword.tscn").instance()
		add_child(sword)
		attack_ready = false
		attack_timer.start()

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.normalized() * SPEED

func on_attack_timer_timeout():
	attack_ready = true
