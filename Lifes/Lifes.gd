extends Node2D

export var startLifeCount = 3
var lifeCount = startLifeCount
onready var menu = get_tree().get_root().get_node("Main/Menu")
var ballImage = load("res://Ball/Ball.png")
var x = 52
var y = 45

func _ready():
	for i in range(startLifeCount):
		i += 1
		
		var life = Sprite.new()
		life.name = "life" + str(i)
		life.set_texture(ballImage)
		life.position = Vector2(x, y)
		life.scale = Vector2(0.25, 0.25)
		
		add_child(life)
		
		x += 78

func hide_life():
	var nodeToHide = get_node("life" + str(lifeCount))
	nodeToHide.hide()
	
	lifeCount -= 1
	
	if lifeCount <= 0:
		menu.get_node("Label").text = "you Lost!"
		menu.get_node("Button").text = "Try Again"
		menu.get_node("Filter").modulate = Color(0.1, 0.1, 0.1, 0.6)
		menu.show()
		return false
	else:
		return true