extends KinematicBody2D
class_name RandomMob

var SPEED = 300
var pdirection = Vector2() 
var pposition = Vector2()
var dir = Vector2()
var randomNr
var vectorholder = Vector2()
var wait = 0
var knockedback
var knockdir
var reduction = 4

func _init():
	print("Spawn RandomMob")

func _ready():
	pposition = get_parent().get_child(0).get_position()
	add_to_group("Mobs")



func _physics_process(delta):
	if knockedback == true:
		knockmobback()
	else:
		if wait <= 0:
			randomNr = randi()%360+1
			dir = _give_dir()
			move_and_slide(dir * SPEED)
			wait = 60
			print(randomNr)
		else:
			move_and_slide(dir * SPEED)
			wait = wait-1
	
	if get_slide_count() > 0:
		var collision = get_slide_collision(get_slide_count()-1)
		if collision.collider.is_in_group("Player"):
			collision.collider.on_hit(self)
		if collision.collider.is_in_group("Weapon"):
			on_hit(collision.collider)

func _give_dir():
	vectorholder = Vector2( sin(randomNr) , cos(randomNr) ).normalized()
	return vectorholder
	
func on_hit(collider):
	knockedback = true
	reduction = 4

func give_knockdir():
	return (position - pposition).normalized()

func knockmobback():
	knockdir = give_knockdir()
	move_and_slide(knockdir * SPEED / reduction )
	if reduction > 1 :
		reduction = reduction / 2
	else:
		knockedback = false
