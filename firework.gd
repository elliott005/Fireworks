extends Node2D

@onready var stars = $Stars
@onready var polygon_2d = $Stars/Polygon2D
@onready var timer = $Timer
@onready var star_timer = $StarTimer

var rotation_speed = deg_to_rad(90)
var exploded = false
var speed_x = 0.0
var speed_y = -100.0
var speed_x_acceleration = 1.0
var speed_y_decay = 1.0
var star_speed = 250.0
var star_down_speed = 0.0
var star_down_acceleration = 100.0

func _ready():
	timer.start(timer.wait_time + randf_range(-1.0, 1.0))
	speed_x += randf_range(-50.0, 50.0)
	speed_y += randf_range(-10.0, 10.0)

func _process(delta):
	if not exploded:
		speed_x += speed_x_acceleration * delta * sign(speed_x)
		speed_y += speed_y_decay * delta
		stars.position += Vector2(speed_x, speed_y) * delta
		polygon_2d.rotate(delta * rotation_speed)
	else:
		var screen_size = DisplayServer.window_get_size()
		star_down_speed += star_down_acceleration * delta
		for child: Polygon2D in stars.get_children():
			var dir = (child.global_position - stars.global_position).normalized()
			child.position += dir * star_speed * delta
			child.position.y += star_down_speed * delta
			child.rotate(delta * rotation_speed)
			if child.global_position.y > screen_size.y:
				child.queue_free()

func _on_timer_timeout():
	exploded = true
	star_timer.start()
	stars.scale = Vector2(1, 1) * 0.2
	polygon_2d.position += Vector2(randi_range(-100, 100), randi_range(-100, 100))
	for i in range(randi_range(8, 10)):
		var new_poly: Polygon2D = polygon_2d.duplicate()
		new_poly.position += Vector2(randi_range(-100, 100), randi_range(-100, 100))
		stars.add_child(new_poly)


func _on_star_timer_timeout():
	if stars.get_child_count() > 0:
		stars.get_child(randi_range(0, stars.get_child_count() - 1)).queue_free()
		star_timer.start(randf_range(0.05, 0.5))
