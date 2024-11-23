extends MeshInstance3D

var follow: Marker3D

func _process(delta: float) -> void:
	global_position.x = follow.global_position.x
	global_position.z = follow.global_position.z
