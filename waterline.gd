extends StaticBody3D

@onready var waterline_mesh: MeshInstance3D = $Waterline_Mesh
@export var waterline_preview: MeshInstance3D
@export var animation_collision: AnimationPlayer
@onready var animation_mesh: AnimationPlayer = $Waterline_Mesh/AnimationPlayer


func _ready() -> void:
	add_to_group("Waterline")
	animation_mesh.play("water_sway")
	waterline_preview.visible = false
