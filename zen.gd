extends Node3D
@onready var timer: Timer = $Timer

func _ready()->void :
	timer.timeout.connect(on_timer_timeout)

func on_timer_timeout():
	var rand_vector: Vector3 = Vector3(randf_range(-12.0, 12.0), 18.0, randf_range(-5.0, 5.0))
	var bubble = load("res://bubble.tscn").instantiate()
	get_tree().get_current_scene().add_child(bubble)
	bubble.global_position = rand_vector
	var rand_time: float = randf_range(0.0,1.0)
	timer.start(rand_time)
	print(rand_time)
