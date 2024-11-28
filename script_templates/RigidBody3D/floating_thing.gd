extends Floater

func _ready() -> void:
	add_to_group("Food")
	body_entered.connect(on_body_entered)
	set_collision_layer_value(Globals.collision.WATERLINE, true)
