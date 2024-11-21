extends StaticBody3D

@export var waterline_preview: MeshInstance3D
@export var animation: AnimationPlayer

func _ready() -> void:
	add_to_group("Waterline")
	animation.play("float")
	waterline_preview.visible = false
