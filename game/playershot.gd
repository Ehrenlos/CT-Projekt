extends KinematicBody2D
class_name playershot 

var SPEED = 500
var dir = Vector2()
onready var TTL2 = $TTL2

func _init():
	print("Shoot Sans")


func _ready():
	dir = _give_dir()

func _physics_process(delta):
	
	if TTL2.is_stopped():
		print("despawn Sans")
		queue_free()
	
	
	move_and_slide(dir * SPEED)
	rotation = dir.angle()
	
	
	if get_slide_count() > 0:
		var collision = get_slide_collision(get_slide_count()-1)
		if collision.collider.is_in_group("mob"):
			collision.collider.on_hit(self)
		

func _give_dir():
	return get_parent().get_child(0).rotation

func on_hit(collider):
	die(collider)
	
func die(_killer):
	queue_free()
