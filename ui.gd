extends CanvasLayer

@export var bubble_label_font_small: int = 105
@export var bubble_label_font_medium: int = 170
@export var bubble_label_font_large: int = 300

@onready var label_bubbles_total: Label = %"Label_Bubbles-total"
@onready var label_bubbles_popped: Label = %"Label_Bubbles-popped"
@onready var label_bubbles_active: Label = %"Label_Bubbles-active"


func _process(delta: float) -> void:
	label_bubbles_total.text = str(Globals.bubbles_total)
	label_bubbles_popped.text = str(Globals.bubbles_popped)
	label_bubbles_active.text = str(Globals.bubbles_active)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Total"):
		label_bubbles_total.visible = !label_bubbles_total.visible
		check_bubble_labels_visibility()
			
	if event.is_action_pressed("Count"):
		label_bubbles_popped.visible = !label_bubbles_popped.visible
		check_bubble_labels_visibility()
		
	if event.is_action_pressed("Active"):
		label_bubbles_active.visible = !label_bubbles_active.visible
		check_bubble_labels_visibility()

func check_bubble_labels_visibility():
	var visible_count = 0
	
	if label_bubbles_total.visible:
		visible_count += 1
	if label_bubbles_popped.visible:
		visible_count += 1
	if label_bubbles_active.visible:
		visible_count += 1
	
	if visible_count == 3:
		label_bubbles_total.add_theme_font_size_override("font_size", bubble_label_font_small)
		label_bubbles_popped.add_theme_font_size_override("font_size", bubble_label_font_small)
		label_bubbles_active.add_theme_font_size_override("font_size", bubble_label_font_small)
	elif visible_count == 2:
		label_bubbles_total.add_theme_font_size_override("font_size", bubble_label_font_medium)
		label_bubbles_popped.add_theme_font_size_override("font_size", bubble_label_font_medium)
		label_bubbles_active.add_theme_font_size_override("font_size", bubble_label_font_medium)
	else:
		label_bubbles_total.add_theme_font_size_override("font_size", bubble_label_font_large)
		label_bubbles_popped.add_theme_font_size_override("font_size", bubble_label_font_large)
		label_bubbles_active.add_theme_font_size_override("font_size", bubble_label_font_large)
