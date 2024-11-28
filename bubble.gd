extends Floater

@export var bubble_blast: GPUParticles3D

@onready var animation: AnimationPlayer = $AnimationPlayer

const MAT_BUBBLE = preload("res://bubble.tres")
const MAT_BUBBLE_SKY = preload("res://bubble_sky.tres")

var popped: bool = false
var hacky: bool = false
var blasted: bool = false

func _ready()->void :
	add_to_group("Bubble")
	set_collision_layer_value(Globals.collision.BUBBLE, true)
	set_collision_mask_value(Globals.collision.WATERLINE, true)
	body_entered.connect(on_body_entered)
	Messenger.sees_something.connect(on_sees_something)
	Messenger.update_bubbles_total.emit(1,true)
	Messenger.bob_state_change.connect(on_bob_state_change)

func on_sees_something(something):
	if self == something:
		if !popped:
			popped = true
			var tween = get_tree().create_tween()
			tween.set_ease(Tween.EASE_OUT)
			tween.tween_property(mesh_1, "scale", Vector3(1.15,1.15,1.15), .1)
			await tween.finished
			$Particles_Pop.emitting = true
			if !hacky:
				Messenger.update_bubbles_total.emit(-1,true)
				Sound.audio_pop.play()
			if !at_end:
				var food = load("res://bubble_food.tscn").instantiate()
				get_tree().get_current_scene().add_child(food)
				food.global_position = global_position # + Vector3(.0,2.,.0)
				food.global_rotation.y = global_rotation.y
			mesh_1.visible = false
			await get_tree().create_timer($Particles_Pop.lifetime).timeout
			queue_free()
