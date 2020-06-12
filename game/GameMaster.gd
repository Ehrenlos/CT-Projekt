extends KinematicBody2D
class_name GameMaster
var mana = 0
const MAX_MANA = 10
var progress 
var prog_timer
var pposition = Vector2()

var SPEED = 400
var motion = Vector2.ZERO
var controller
var WINDOW_HEIGHT = 600
var WINDOW_WIDTH = 1024

func _init(device=Controller.Device.KEYBOARD):
	controller = Controller.new(device)

func _ready():
	add_to_group("GameMaster")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	progress = get_parent().get_child(1)
	prog_timer = Timer.new()
	prog_timer.connect("timeout", self, "on_prog_timer_timeout")
	prog_timer.set_wait_time(0.01)
	add_child(prog_timer)
	prog_timer.start()

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
		pposition = get_parent().get_child(0).get_position()
		if pposition.distance_to(position) > 150:
			if use_mana(3):
				spawn_mob(0)

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.normalized() * SPEED

func inc_mana():
	if mana <= MAX_MANA:
		mana += 1

func use_mana(cost):
	if mana >= cost:
		mana -= cost
		return true
	else:
		return false

func on_prog_timer_timeout():
	if progress.value == 100:
		progress.value = 0
		inc_mana()
	progress.value += 1
	prog_timer.start()
	
func spawn_mob(index):
	var mob
	match index:
		0: 
			mob = preload("res://MobDing.tscn").instance()
	mob.set_position(position)
	get_parent().add_child(mob)
