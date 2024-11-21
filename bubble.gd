extends RigidBody3D
@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D

var popped: bool = false

func _ready()->void :
	Messenger.sees_something.connect(on_sees_something)
	audio.finished.connect(on_pop)

func on_pop():
	queue_free()

func on_sees_something(something):
	if self == something:
		if Input.is_action_pressed("Grab"):
			if !popped:
				$AudioStreamPlayer3D.play()
				popped = true
			visible = false
