extends KinematicBody2D
class_name StandardMob

var SPEED = 200
var pdirection = Vector2() 
var pposition = Vector2()
var dir = Vector2()

func _init():
	print("Spawn standard mob")

func _ready():
	pposition = get_parent().get_child(0).get_position()
	add_to_group("Mobs")



func _physics_process(delta):
	pposition = get_parent().get_child(0).get_position()
	dir = _give_dir()
	move_and_slide(dir * SPEED)
	rotation = dir.angle()
	
	
	if get_slide_count() > 0:
		var collision = get_slide_collision(get_slide_count()-1)
		if collision.collider.is_in_group("Weapon"):
			on_hit(collision.collider)
		elif collision.collider.is_in_group("Player"):
			collision.collider.on_hit(self)
		

func _give_dir():
	return (pposition - position).normalized()

func on_hit(collider):
	if collider.name == "playershot":
		collider.on_hit(self)
	die(collider)
	
func die(killer):
	Sound.get_node("Standardmob/Die").play(0)
	GameWorld.addGrave(position, get_parent())
	if killer.is_in_group("Weapon"):
		if randi()%100<=10:
			GameWorld.dropHeart(position, get_parent())
	queue_free()
