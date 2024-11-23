extends RigidBody3D
@export var bubble_mesh: MeshInstance3D
@export var bubble_blast: GPUParticles3D
@export_range(0.0,20.0) var bubble_speed: float = 0.1

@onready var animation: AnimationPlayer = $AnimationPlayer

const MAT_BUBBLE = preload("res://bubble.tres")
const MAT_BUBBLE_SKY = preload("res://bubble_sky.tres")

var popped: bool = false
var hacky: bool = false
var up: bool = false
var blasted: bool = false

var floating: bool = false

func _ready()->void :
	Messenger.sees_something.connect(on_sees_something)
	body_entered.connect(on_body_entered)
	
	Messenger.update_bubbles_left.emit(1)
	
func _physics_process(delta: float) -> void:
	if floating:
		apply_constant_y_force()
	if global_position.y >= -5.0:
		bubble_mesh.set_surface_override_material(0,MAT_BUBBLE_SKY)
		floating = false
	if global_position.y >= 44.0:
		if !blasted:
			blast_bubble()
			
func apply_constant_y_force():
	var constant_force = Vector3(0, Globals.constant_y_float_force, 0) 
	apply_central_force(constant_force)

func on_sees_something(something):
	if self == something:
		if !popped:
			$Particles_Pop.emitting = true
			if !hacky:
				Messenger.update_bubbles_left.emit(-1)
				Sound.audio_pop.play()
			popped = true
			await get_tree().create_timer($Particles_Pop.lifetime).timeout
			queue_free()
		bubble_mesh.visible = false
		
func blast_bubble():
	if !hacky:
		blasted = true
		bubble_mesh.visible = false
		bubble_blast.emitting = true
		
		Messenger.update_bubbles_left.emit(-1)
		await get_tree().create_timer(bubble_blast.lifetime + 1).timeout
		queue_free()

func on_body_entered(body):
	if body.is_in_group("Waterline"):
		floating = true
		constant_force.z = -bubble_speed
