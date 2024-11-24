extends RigidBody3D
@export var mesh: MeshInstance3D
@export var bubble_blast: GPUParticles3D
@export_range(0.0,20.0) var bubble_speed: float = 0.1

@onready var animation: AnimationPlayer = $AnimationPlayer

const MAT_BUBBLE = preload("res://bubble.tres")
const MAT_BUBBLE_SKY = preload("res://bubble_sky.tres")

var popped: bool = false
var hacky: bool = false
var at_end: bool = false
var blasted: bool = false

var floating: bool = false

func _ready()->void :
	Messenger.sees_something.connect(on_sees_something)
	body_entered.connect(on_body_entered)
	
	Messenger.update_bubbles_left.emit(1,true)
	
func _physics_process(_delta: float) -> void:
	if floating:
		apply_floating_y_force()
	if global_position.y >= -6.:
		if !at_end:
			at_end = true
			disappear()
		#mesh.set_surface_override_material(0,MAT_BUBBLE_SKY)
		#floating = false
	#if global_position.y >= 44.0:
		#if !blasted:
			#blast_bubble()
			
func apply_floating_y_force():
	var constant_float_force = Vector3(0, Globals.constant_y_float_force, 0) 
	apply_central_force(constant_float_force)

func on_sees_something(something):
	if self == something:
		if !popped:
			popped = true
			var tween = get_tree().create_tween()
			tween.set_ease(Tween.EASE_OUT)
			tween.tween_property(mesh, "scale", Vector3(1.15,1.15,1.15), .1)
			await tween.finished
			$Particles_Pop.emitting = true
			if !hacky:
				Messenger.update_bubbles_left.emit(-1,true)
				Sound.audio_pop.play()
			if !at_end:
				var food = load("res://bubble_food.tscn").instantiate()
				get_tree().get_current_scene().add_child(food)
				food.global_position = global_position # + Vector3(.0,2.,.0)
				food.global_rotation.y = global_rotation.y
			mesh.visible = false
			await get_tree().create_timer($Particles_Pop.lifetime).timeout
			queue_free()
		
func blast_bubble():
	if !hacky:
		blasted = true
		mesh.visible = false
		bubble_blast.emitting = true
		
		Messenger.update_bubbles_left.emit(-1,true)
		await get_tree().create_timer(bubble_blast.lifetime + 1).timeout
		queue_free()

func on_body_entered(body):
	if body.is_in_group("Waterline"):
		floating = true
		constant_force.z = -bubble_speed
		
func disappear():
	#sleeping = true
	axis_lock_linear_y = true
	constant_force.z += -bubble_speed * 3
	constant_force.y += 10
	var tween_shrink = get_tree().create_tween()
	tween_shrink.set_ease(Tween.EASE_IN)
	tween_shrink.tween_property(mesh, "scale", Vector3(0.,0.,0.), 30)
	await tween_shrink.finished
	Messenger.update_bubbles_left.emit(-1,false)
	#tween.kill()
	queue_free()
