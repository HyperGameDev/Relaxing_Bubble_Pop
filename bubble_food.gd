extends Floater


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Food")
	
	body_entered.connect(on_body_entered)
