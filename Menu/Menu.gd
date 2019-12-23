extends Control

func _on_Button_pressed():
	get_tree().change_scene("res://Main/Main.tscn")

func _on_Menu_visibility_changed():
	if is_visible_in_tree():
		if get_tree().get_root().get_node("Main").has_node("Ball"):
			get_tree().get_root().get_node("Main/Ball").queue_free()