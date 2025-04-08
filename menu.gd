extends CanvasLayer

@onready var text_edit = $CenterContainer/VBoxContainer/TextEdit

func _on_button_pressed():
	Globals.user_name = text_edit.text
	get_tree().change_scene_to_file("res://world.tscn")
