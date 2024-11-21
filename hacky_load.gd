extends Node3D

@export var particles_blast: GPUParticles3D
@export var particles_pop: GPUParticles3D

func _ready() -> void:
	particles_blast.emitting = true
	particles_pop.emitting = true
