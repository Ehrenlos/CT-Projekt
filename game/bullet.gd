extends KinematicBody2D
class_name bullet
var SPEED = 500
var dir = Vector2()
var Pdirection = Vector2()
var pposition = Vector2()
onready var TTL = $TTL

func _init():
	print("Spawn bullet")


func _ready():
	pposition = get_parent().get_child(0).get_position()
	dir = _give_dir()
	

func _physics_process(delta):
	
	if TTL.is_stopped():
		print("despawn bullet")
		queue_free()
	
	
	move_and_slide(dir * SPEED)
	rotation = dir.angle()
	
	
	if get_slide_count() > 0:
		var collision = get_slide_collision(get_slide_count()-1)
		if collision.collider.is_in_group("Player"):
			collision.collider.on_hit(self)
		if collision.collider.is_in_group("Weapon"):
			on_hit(collision.collider)

func _give_dir():
	return (pposition - position).normalized()

func on_hit(collider):
	die(collider)
	
func die(killer):
	if killer.is_in_group("Weapon"):
		if randi()%100<=10:
			GameWorld.dropHeart(position, get_parent())
	queue_free()
