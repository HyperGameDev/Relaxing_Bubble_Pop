extends Floater

var food_timer: Timer
var discoverable_timer: Timer
@export var food_lifetime: float = 10.0
@export var discoverable_interval: float = 3.0
@export var sink_speed: float = -6.0

var discoverable: bool = true

func _ready() -> void:
	add_to_group("Food")
	set_collision_layer_value(Globals.collision.FOOD_BUBBLE, true)
	set_collision_mask_value(Globals.collision.WATERLINE, true)
	
	body_entered.connect(on_body_entered)
	Messenger.bob_state_change.connect(on_bob_state_change)
	
	discoverable_timer = Timer.new()
	discoverable_timer.wait_time = discoverable_interval
	add_child(discoverable_timer)
	discoverable_timer.start()
	
	food_timer = Timer.new()
	food_timer.wait_time = food_lifetime
	add_child(food_timer)
	food_timer.start()
	
	food_timer.timeout.connect(on_food_timer_timeout)
	discoverable_timer.timeout.connect(on_discoverable_timeout)
	
func _physics_process(delta: float) -> void:
	if global_position.y <= -50:
		queue_free()
	
func on_food_timer_timeout():
	discoverable = false
	floating = false
	constant_force.y = sink_speed

func on_discoverable_timeout():
	if discoverable:
		discoverable = false
		
		var fish_y_spawn: Vector3 = Vector3(0.,Globals.spawn_y_pos,0.)
		
		var fish = load("res://fish.tscn").instantiate()
		get_tree().get_current_scene().add_child(fish)
		fish.global_position = global_position + fish_y_spawn
