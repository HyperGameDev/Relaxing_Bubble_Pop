extends Node3D
@export var stop_spawning: bool = false
@export_range(.1,3.0) var spawn_rate_maximum: float = 1.45
@export var bubble_spread_divisor: float = 23.0
@export var spawn_outer_x_limits: float = 21
@export var spawn_inner_x_limits: float = 10
@export var spawn_outer_z_limits: float = 15
@export var spawn_inner_z_limits: float = 0

@onready var timer: Timer = $Timer

func _ready()->void :
	timer.timeout.connect(on_timer_timeout)

func on_timer_timeout():
	if Globals.bubbles_active < 300:
			stop_spawning = false
			
	if !stop_spawning:
		var x_max = spawn_outer_x_limits
		var x_min = spawn_inner_x_limits
		var z_max = spawn_outer_z_limits
		var z_min = spawn_inner_z_limits
		var z_max_normalized = z_max/2
		var rand_z: float = randf_range(-z_max,z_min)
		var lerped_x: float
		
		if rand_z <= -7.5:
			var lerp_factor = (rand_z + z_max) / z_max_normalized
			lerped_x = lerp(weighted_randf_range(-x_max, x_max), weighted_randf_range(-x_min,x_min), lerp_factor)
		else:
			var lerp_factor = -rand_z / z_max_normalized
			lerped_x = lerp(weighted_randf_range(-x_min, x_min), weighted_randf_range(-x_max,x_max), lerp_factor)
		
		var rand_vector: Vector3 = Vector3(lerped_x,Globals.spawn_y_pos,rand_z)
		#print(rand_vector)
		var bubble = load("res://bubble.tscn").instantiate()
		get_tree().get_current_scene().add_child(bubble)
		bubble.global_position = rand_vector
		bubble.constant_force.x = rand_vector.x/bubble_spread_divisor
		#print(bubble.constant_force.x)
		
		if Globals.bubbles_active >= 300:
			stop_spawning = true
		
		var rand_time: float = randf_range(0.0,spawn_rate_maximum)
		timer.start(rand_time)

func weighted_randf_range(min_val: float, max_val: float) -> float:
	var polarity = 1 if randf() > 0.5 else -1 # randomly choose between positive and negative
	var weight = pow(randf(), 5) # Adjust the exponent to change the weight
	return polarity * (weight * (max_val - min_val) + min_val)
