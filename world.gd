extends Node2D

@onready var name_label = $CanvasLayer/CenterContainer/NameLabel

func _ready():
	name_label.text = Globals.user_name
	name_label.material.set_shader_parameter("start_time", float(Time.get_ticks_msec() / 1000.0))
