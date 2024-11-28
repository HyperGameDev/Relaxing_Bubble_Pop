extends Floater

var food_timer: Timer
@export var food_lifetime: float = 10.0
@export var sink_speed: float = -6.0

var discoverable: bool = true

func _ready() -> void:
	add_to_group("Food")
	set_collision_layer_value(Globals.collision.FOOD_BUBBLE, true)
	set_collision_mask_value(Globals.collision.WATERLINE, true)
	
	body_entered.connect(on_body_entered)
	Messenger.bob_state_change.connect(on_bob_state_change)
	
	food_timer = Timer.new()
	food_timer.wait_time = food_lifetime
	add_child(food_timer)
	food_timer.start()
	
	food_timer.timeout.connect(on_food_timer_timeout)
	
func _physics_process(delta: float) -> void:
	if global_position.y <= -50:
		queue_free()
	
func on_food_timer_timeout():
	discoverable = false
	floating = false
	constant_force.y = sink_speed
