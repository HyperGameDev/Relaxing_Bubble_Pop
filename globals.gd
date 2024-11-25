extends Node

@export var float_switch_interval: float = 0.75 # Interval for each switch (3 seconds loop / 4 switches) 
@export var float_force_values: Array = [0.0, -8.5, -7.5, 0.0] # Array of force values to switch between

var constant_y_float_force: float = 0.0
var current_float_index: int = 0
var float_switch_timer: Timer

var bubbles_total: int = 0
var bubbles_popped: int = 0
var bubbles_active: int = 0

func _ready() -> void:
	set_process(true)
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	float_switch_timer = Timer.new()
	float_switch_timer.wait_time = float_switch_interval 
	float_switch_timer.connect("timeout", Callable(self, "_on_SwitchTimer_timeout"))
	add_child(float_switch_timer)
	float_switch_timer.start()
	Messenger.update_bubbles_total.connect(on_update_bubbles_total)
	Messenger.debug_arrow.connect(on_debug_arrow)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		get_tree().paused = !get_tree().paused

func on_update_bubbles_total(adjustment,was_popped):
	if adjustment < 0:
		if was_popped:
			bubbles_popped += abs(adjustment)
		else:
			bubbles_total += abs(adjustment)
			
	bubbles_total += adjustment
	bubbles_active += adjustment
	
		
	#if OS.has_feature("debug"):
		#print(bubbles_total)

func update_float_force_values(float_force_array):
	float_force_values = float_force_array.duplicate()

func _on_SwitchTimer_timeout():
	current_float_index = (current_float_index + 1) % float_force_values.size()
	constant_y_float_force = float_force_values[current_float_index]
	Messenger.float_end_loop.emit()

func on_debug_arrow(target):
	var arrow = load("res://debug_arrow.tscn").instantiate()
	get_tree().get_current_scene().add_child(arrow)
	arrow.global_position.y = target.get_owner().global_position.y + 2
	arrow.follow = target
