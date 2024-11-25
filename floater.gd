extends RigidBody3D

class_name Floater


@export var mesh_1: MeshInstance3D
@export var mesh_2: MeshInstance3D
@export var mesh_3: MeshInstance3D
@export_range(0.0,20.0) var floating_speed: float = 0.1
var floating: bool = false
var at_end: bool = false
	
func _physics_process(_delta: float) -> void:
	if floating:
		apply_floating_y_force()
	if global_position.y >= -6.:
		if !at_end:
			at_end = true
			disappear()
			
func apply_floating_y_force():
	var constant_float_force = Vector3(0, Globals.constant_y_float_force, 0) 
	apply_central_force(constant_float_force)
	
func on_body_entered(body: Node):
	if body.is_in_group("Waterline"):
		floating = true
		constant_force.z = -floating_speed
	
func disappear():
	#sleeping = true
	axis_lock_linear_y = true
	constant_force.z += -floating_speed * 3
	constant_force.y += 10
	shrink_mesh(mesh_2,false)
	shrink_mesh(mesh_3,false)
	await shrink_mesh(mesh_1,true).finished
	Messenger.update_bubbles_total.emit(-1,false)
	#tween.kill()
	queue_free()

func shrink_mesh(mesh,is_await):
	var tween_shrink = get_tree().create_tween()
	tween_shrink.set_ease(Tween.EASE_IN)
	tween_shrink.tween_property(mesh, "scale", Vector3(0.,0.,0.), 30)
	
	if is_await:
		return tween_shrink
