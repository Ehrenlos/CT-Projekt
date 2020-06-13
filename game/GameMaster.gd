extends KinematicBody2D
class_name GameMaster
var mana = 0
const MAX_MANA = 10
var progress 
var prog_timer
var pposition = Vector2()
var mobCosts = {STANDARD=2, RANDOM=3}

const SPEED = 800
var motion = Vector2.ZERO
var controller

const WINDOW_HEIGHT = 600
const WINDOW_WIDTH = 1066

func _init(device = Controller.Device.C0):
	controller = Controller.new(device)

func _ready():
	add_to_group("GameMaster")
	progress = get_parent().get_child(1)
	prog_timer = Timer.new()
	prog_timer.connect("timeout", self, "on_prog_timer_timeout")
	prog_timer.set_wait_time(0.01)
	add_child(prog_timer)
	prog_timer.start()

func _process(delta):
	if controller.device == Controller.Device.KEYBOARD:
		set_position(get_global_mouse_position())
	else:
		motion = Vector2.ZERO
		apply_movement(controller.get_input_axis(0) * delta)
		motion = move_and_slide(motion)
	if position.x < 16:
		set_position(Vector2(16, position.y))
	if position.x > WINDOW_WIDTH - 16:
		set_position(Vector2(WINDOW_WIDTH - 16, position.y))
	if position.y < 16:
		set_position(Vector2(position.x, 16))
	if position.y > WINDOW_HEIGHT - 16:
		set_position(Vector2(position.x, WINDOW_HEIGHT - 16))
	
	
	if controller.is_just_pressed(Controller.Button.A):
		pposition = get_parent().get_child(0).get_position()
		if pposition.distance_to(position) > 150:
			if use_mana(mobCosts.STANDARD):
				spawn_mob(0)
	if controller.is_just_pressed(Controller.Button.B):
		pposition = get_parent().get_child(0).get_position()
		if pposition.distance_to(position) > 150:
			if use_mana(mobCosts.RANDOM):
				spawn_mob(1)

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.normalized() * SPEED

func inc_mana():
	if mana < MAX_MANA*100:
		mana += 1

func use_mana(cost):
	if mana >= cost*100:
		mana -= cost*100
		return true
	else:
		return false

func on_prog_timer_timeout():
	inc_mana()
	progress.value = mana
	prog_timer.start()
	
func spawn_mob(index):
	var mob
	match index:
		0: 
			mob = preload("res://MobDing.tscn").instance()
		1: mob = preload("res://RandomMob.tscn").instance()
	mob.set_position(position)
	get_parent().add_child(mob)
