extends WorldEnvironment

var dark_mode: bool = false
@onready var directional_light_1: DirectionalLight3D = %DirectionalLight3D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Dark"):
		dark_mode = !dark_mode
		if dark_mode:
			
			directional_light_1.light_energy = 1.163
			environment.sky.sky_material.set_sky_energy_multiplier(0.4)
			environment.sky.sky_material.set_sky_top_color(Color(1.0,0.342,0.315))
			environment.sky.sky_material.set_sky_horizon_color(Color(1.0,0.478,0.455))
			environment.sky.sky_material.set_ground_energy_multiplier(0.4)
			environment.sky.sky_material.set_ground_bottom_color(Color(0.176,0.247,0.38))
			environment.sky.sky_material.set_ground_horizon_color(Color(0.72,0.456,0.302))
			
		else:
			directional_light_1.light_energy = 2.188
			environment.sky.sky_material.set_sky_energy_multiplier(1.0)
			environment.sky.sky_material.set_sky_top_color(Color(0.404,0.631,0.78))
			environment.sky.sky_material.set_sky_horizon_color(Color(1.0,0.918,0.741))
			environment.sky.sky_material.set_ground_energy_multiplier(1.0)
			environment.sky.sky_material.set_ground_bottom_color(Color(0.0,0.051,0.184))
			environment.sky.sky_material.set_ground_horizon_color(Color(0.443,0.475,0.561))
			
