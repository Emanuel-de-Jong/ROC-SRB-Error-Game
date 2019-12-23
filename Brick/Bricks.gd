extends Node2D

onready var brickScene = preload("res://Brick/Brick.tscn")
var brickImages = [preload("res://Brick/Java.png"), preload("res://Brick/Sulawesi.png"), preload("res://Brick/Sumatra.png"), preload("res://Brick/Timor.png")]
var brickX = 66
var brickY = 120
var color = Color(0, 0, 0)
var group = ""
onready var menu = get_tree().get_root().get_node("Main/Menu")

func _ready():
	randomize()
	for i in range(3):
		if i == 0:
			color = Color(1, 0.5, 0.5)
			group = "Red"
		elif i == 1:
			color = Color(0.5, 1, 0.5)
			group = "Green"
		elif i == 2:
			color = Color(0.5, 0.5, 1)
			group = "Blue"
		for j in range(8):
			var brick = brickScene.instance()
			brick.get_node("Sprite").set_texture(brickImages[randi()%len(brickImages)])
			brick.modulate = color
			brick.position = Vector2(brickX, brickY)
			brick.add_to_group(group)
			add_child(brick)
			
			brickX += 126
		brickX = 66
		brickY += 76

func check_if_won():
	if get_child_count() == 1:
		menu.get_node("Label").text = "you won!"
		menu.get_node("Button").text = "Try Again"
		menu.get_node("Filter").modulate = Color(1, 1, 0, 0.6)
		menu.show()
		return true