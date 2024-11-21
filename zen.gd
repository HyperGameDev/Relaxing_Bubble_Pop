extends Node3D
@export var stop_spawning: bool = false
@export_range(.1,3.0) var spawn_rate_maximum: float = 1.45
@export_range(0.0,20.0) var bubble_speed: float = 0.0

@onready var timer: Timer = $Timer

func _ready()->void :
	timer.timeout.connect(on_timer_timeout)

func on_timer_timeout():
	if !stop_spawning:
		var rand_vector: Vector3 = Vector3(randf_range(-20.0, 20.0), -25.0, randf_range(-15.0, 15.0))
		var bubble = load("res://bubble.tscn").instantiate()
		get_tree().get_current_scene().add_child(bubble)
		bubble.global_position = rand_vector
		bubble.constant_force.x = rand_vector.x/23
		bubble.constant_force.y = bubble_speed
		bubble.constant_force.z = -bubble_speed
		#print(bubble.constant_force.x)
		var rand_time: float = randf_range(0.0,spawn_rate_maximum)
		timer.start(rand_time)
