extends Node

onready var menu = get_tree().get_root().get_node("Main/Menu")

func _ready():
	menu.show()