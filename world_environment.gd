extends WorldEnvironment

@export_category("Sun Settings")
@export var sun_color: Color = Color(0.904,0.705,0.154):
	set(new_color):
		sun_color = new_color
		%DirectionalLight3D.set_color(sun_color)
@export_range(0.0, 16.0) var sun_energy = 2.188:
	set(new_energy):
		sun_energy = new_energy
		%DirectionalLight3D.light_energy = new_energy
		
		
		
@export_category("Sky Settings")
@export var sky_top_color: Color = Color(0.404,0.631,0.78):
	set(new_color):
		sky_top_color = new_color
		environment.sky.sky_material.set_sky_top_color(sky_top_color)
		
@export var sky_horizon_color: Color = Color(1.0,0.74,0.905):
	set(new_color):
		sky_horizon_color = new_color
		environment.sky.sky_material.set_sky_horizon_color(sky_horizon_color)
		
@export_range(0,4,.0001) var sky_color_curve: float = .0652:
	set(new_curve):
		sky_color_curve = new_curve
		environment.sky.sky_material.set_sky_curve(sky_color_curve)
		
@export_range(0,64,.0001) var sky_energy: float = 1.0:
	set(new_energy):
		sky_energy = new_energy
		environment.sky.sky_material.set_sky_energy_multiplier(sky_energy)
		

@export_category("Fog Settings")
@export var fog_light_color: Color = Color(0.492,0.595,0.654):
	set(new_color):
		fog_light_color = new_color
		environment.fog_light_color = fog_light_color
		
		
@export_category("Ground Settings")
@export var ground_bottom_color: Color = Color(0.0,0.051,0.184):
	set(new_color):
		ground_bottom_color = new_color
		environment.sky.sky_material.set_ground_bottom_color(ground_bottom_color)
		
@export var ground_horizon_color: Color = Color(0.72,0.456,0.302):
	set(new_color):
		ground_horizon_color = new_color
		environment.sky.sky_material.set_ground_horizon_color(ground_horizon_color)
		
@export_range(0,4,.0001) var ground_color_curve: float = .0485:
	set(new_curve):
		ground_color_curve = new_curve
		environment.sky.sky_material.set_ground_curve(ground_color_curve)
		
@export_range(0,64,.0001) var ground_energy: float = 1.0:
	set(new_energy):
		ground_energy = new_energy
		environment.sky.sky_material.set_ground_energy_multiplier(ground_energy)

var dark_mode: bool = false
@onready var directional_light_1: DirectionalLight3D = %DirectionalLight3D

func _ready() -> void:
	make_daytime()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Dark"):
		dark_mode = !dark_mode
		if dark_mode:
			make_nighttime()
			
		else:
			make_daytime()

func make_nighttime():
	directional_light_1.light_energy = 1.163
	environment.sky.sky_material.set_sky_energy_multiplier(0.4)
	environment.sky.sky_material.set_sky_top_color(Color(1.0,0.342,0.315))
	environment.sky.sky_material.set_sky_horizon_color(Color(1.0,0.478,0.455))
	
	environment.fog_light_color = Color(.67,0.327,0.455)
	environment.sky.sky_material.set_ground_energy_multiplier(0.4)
	environment.sky.sky_material.set_ground_bottom_color(Color(0.176,0.247,0.38))
	environment.sky.sky_material.set_ground_horizon_color(Color(0.72,0.456,0.302))
			
func make_daytime():
	pass
	directional_light_1.light_energy = sun_energy
	environment.sky.sky_material.set_sky_energy_multiplier(sky_energy)
	environment.sky.sky_material.set_sky_top_color(sky_top_color)
	environment.sky.sky_material.set_sky_horizon_color(sky_horizon_color)
	environment.sky.sky_material.set_sky_curve(sky_color_curve)
	
	environment.fog_light_color = fog_light_color
	environment.sky.sky_material.set_ground_energy_multiplier(ground_energy)
	environment.sky.sky_material.set_ground_bottom_color(ground_bottom_color)
	environment.sky.sky_material.set_ground_horizon_color(ground_horizon_color)
	environment.sky.sky_material.set_ground_curve(ground_color_curve)
