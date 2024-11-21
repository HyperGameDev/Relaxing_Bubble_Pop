extends RigidBody3D
@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D
@export var bubble_mesh: MeshInstance3D
@export var bubble_blast: GPUParticles3D
var popped: bool = false
var hacky: bool = false
var up: bool = false

func _ready()->void :
	Messenger.sees_something.connect(on_sees_something)
	audio.finished.connect(on_pop)
	#body_entered.connect(on_body_entered)
	
func _physics_process(delta: float) -> void:
	if global_position.y >= -4.9:
		#if !up:
			#bubble_mesh.scale = bubble_mesh.scale * 3
			#up = true
		bubble_mesh.get_surface_override_material(0).disable_fog = true
	if global_position.y >= 40.0:
		blast_bubble()

func on_pop():
	await get_tree().create_timer($Particles_Pop.lifetime).timeout
	queue_free()

func on_sees_something(something):
	if self == something:
		if !popped:
			$Particles_Pop.emitting = true
			if !hacky:
				$AudioStreamPlayer3D.play()
			popped = true
		bubble_mesh.visible = false
		
func blast_bubble():
	if !hacky:
		bubble_mesh.visible = false
		bubble_blast.emitting = true
		await get_tree().create_timer(bubble_blast.lifetime + 1).timeout
		queue_free()
