extends KinematicBody2D
class_name ShootingMob


const WINDOW_HEIGHT = 600
const WINDOW_WIDTH = 927
var SPEED = 200
var pdirection = Vector2() 
var pposition = Vector2()
var dir = Vector2()
var randomNr
var vectorholder = Vector2()
var wait = 0
var knockedback
var knockdir
onready var attack_cooldown = $attack_cooldown


var reduction = 6
var lives = 2

func _init():
	print("Spawn RandomMob")
	

func _ready():
	pposition = get_parent().get_child(0).get_position()
	add_to_group("Mobs")
	attack_cooldown.start()
	


func _physics_process(delta):
	
	if attack_cooldown.is_stopped():
		shoot()
		attack_cooldown.start()
	
	if position.x < 16:
		set_position(Vector2(16, position.y))
		dir = -give_dir()
	if position.x > WINDOW_WIDTH - 16:
		set_position(Vector2(WINDOW_WIDTH - 16, position.y))
		dir = -give_dir()
	if position.y < 16:
		set_position(Vector2(position.x, 16))
		dir = -give_dir()
	if position.y > WINDOW_HEIGHT - 16:
		set_position(Vector2(position.x, WINDOW_HEIGHT - 16))
		dir = -give_dir()

	if knockedback == true:
		knockmobback()
	else:
		if wait <= 0:
			randomNr = randi()%360+1

			dir = give_dir()
			move_and_slide(dir * SPEED)
			wait = 60
			#print(randomNr)
		else:
			move_and_slide(dir * SPEED)
			wait = wait-1
	
	if get_slide_count() > 0:
		var collision = get_slide_collision(get_slide_count()-1)
		if collision.collider.is_in_group("Player"):
			collision.collider.on_hit(self)
		if collision.collider.is_in_group("Weapon"):
			on_hit(collision.collider)


func give_dir():

	vectorholder = Vector2( sin(randomNr) , cos(randomNr) ).normalized()
	return vectorholder
	
func on_hit(collider):

	if collider.name == "playershot":
		collider.on_hit(self)

	if !knockedback:
		knockedback = true
	
		reduction = 24
		if lives > 1:

			Sound.get_node("Shooting mob/Block").play()
      
			lives -= 1
		else:
			die(collider)


func give_knockdir():
	return (position - pposition).normalized()

func knockmobback():
	knockdir = give_knockdir()

	move_and_slide(knockdir * SPEED * reduction )

	if reduction > 1 :
		reduction = reduction / 2
	else:
		knockedback = false

func die(killer):

	Sound.get_node("Shooting mob/Die").play()
	GameWorld.addGrave(position, get_parent())

	if killer.is_in_group("Weapon"):
		if randi()%100<=10:
			GameWorld.dropHeart(position, get_parent())
	queue_free()

func shoot():
	
	var bullet
	bullet = preload("res://bullet.tscn").instance()
	bullet.set_position(position)
	get_parent().add_child(bullet)

	Sound.get_node("Shooting mob/Shoot").play()

	print("shoot")

