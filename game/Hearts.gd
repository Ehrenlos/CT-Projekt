extends Sprite

var icon_spacing = 16

func _draw():
	var lives = get_parent().lives
	print(lives)
	for x in range(lives):
		draw_texture(preload("res://Heart.png"), Vector2(-24 + x * icon_spacing, -64))

func _process(delta):
	rotation = -get_parent().rotation
	update()
