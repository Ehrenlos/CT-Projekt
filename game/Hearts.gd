extends Sprite

var icon_spacing = 10

func _draw():
	var lives = get_parent().lives
	var minus = 0
	var plus = 0
	if lives%2!=0:
		plus = 5
	else:
		minus = 1
	for x in range(lives):
		draw_texture(preload("res://Heart.png"), Vector2(-icon_spacing*((lives - minus)/2) + x * icon_spacing - 16 + plus, -64))

func _process(delta):
	rotation = -get_parent().rotation
	update()
