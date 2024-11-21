extends StaticBody3D

@export var upperatmos_preview: MeshInstance3D

func _ready() -> void:
	add_to_group("Upperatmos")
	upperatmos_preview.visible = false
