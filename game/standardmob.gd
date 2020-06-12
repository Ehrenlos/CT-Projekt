extends KinematicBody2D
class_name StandardMob

var SPEED = 200
var pdirection = Vector2() 
var pposition = Vector2()
var dir = Vector2()

func _init():
	print("Spawn mob")

func _ready():
	pposition = get_parent().get_child(0).get_position()



func _physics_process(delta):
	pposition = get_parent().get_child(0).get_position()
	dir = _give_dir()
	move_and_slide(dir * SPEED)

func _give_dir():
	return (pposition - position).normalized()

