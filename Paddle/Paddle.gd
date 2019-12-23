extends KinematicBody2D

func _ready():
	set_process(true)

func _process(delta):
	var mouseX = get_viewport().get_mouse_position().x
	if mouseX < 115:
		mouseX = 115
	elif mouseX > 899:
		mouseX = 899
#	elif mouseX > get_viewport_rect().size.x - 115:
#		mouseX = get_viewport_rect().size.x - 115
	position = Vector2(mouseX, position.y)