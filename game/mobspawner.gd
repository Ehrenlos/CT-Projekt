extends KinematicBody2D
class_name mobspawner


const WINDOW_HEIGHT = 600
const WINDOW_WIDTH = 927
var SPEED = 0
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
var lives = 9

func _init():
	print("Spawn mobspawner")
	

func _ready():
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
		if collision.collider.is_in_group("Weapon"):
			on_hit(collision.collider)
		elif collision.collider.is_in_group("Player"):
			collision.collider.on_hit(self)


func give_dir():

	vectorholder = Vector2( sin(randomNr) , cos(randomNr) ).normalized()
	return vectorholder
	
func on_hit(collider):
	if collider.name == "playershot":
		collider.on_hit(self)
	if !knockedback && collider.is_in_group("Weapon"):
		
		knockedback = true
	
		reduction = 24
		if lives > 1:
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
	Sound.get_node("Spawner/Die").play(0)
	GameWorld.addGrave(position, get_parent())
	if killer.is_in_group("Weapon"):
		if randi()%100<=10:
			GameWorld.dropHeart(position, get_parent())
	queue_free()

func shoot():
	Sound.get_node("Spawner/Spawn").play(0)
	var mob
	mob = preload("res://Mobding.tscn").instance()
	mob.set_position(Vector2(position.x + 50 , position.y + 50))
	get_parent().add_child(mob)
	print("spawn")

