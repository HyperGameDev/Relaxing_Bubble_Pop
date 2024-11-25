extends Node

@export var bob_switch_interval: float = 0.75 # Interval for each switch (3 seconds loop / 4 switches) 
var bob_switch_timer: Timer

var bubbles_total: int = 0
var bubbles_popped: int = 0
var bubbles_active: int = 0

func _ready() -> void:
	set_process(true)
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	bob_switch_timer = Timer.new()
	bob_switch_timer.wait_time = bob_switch_interval 
	bob_switch_timer.connect("timeout", Callable(self, "_on_SwitchTimer_timeout"))
	add_child(bob_switch_timer)
	bob_switch_timer.start()
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

func _on_SwitchTimer_timeout():
	Messenger.bob_state_change.emit()
	#print("Globals switched bob state")

func on_debug_arrow(target):
	var arrow = load("res://debug_arrow.tscn").instantiate()
	get_tree().get_current_scene().add_child(arrow)
	arrow.global_position.y = target.get_owner().global_position.y + 2
	arrow.follow = target
