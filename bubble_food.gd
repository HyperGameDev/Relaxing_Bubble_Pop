extends Floater


func _ready() -> void:
	add_to_group("Food")
	set_collision_layer_value(Globals.collision.FOOD_BUBBLE, true)
	set_collision_mask_value(Globals.collision.WATERLINE, true)
	
	body_entered.connect(on_body_entered)
	Messenger.bob_state_change.connect(on_bob_state_change)
