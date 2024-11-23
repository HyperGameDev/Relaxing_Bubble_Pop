extends CanvasLayer

@export var bubble_label_font_small: int = 170
@export var bubble_label_font_large: int = 300

@onready var label_bubbles_left: Label = %"Label_Bubbles-left"
@onready var label_bubbles_popped: Label = %"Label_Bubbles-popped"


func _process(delta: float) -> void:
	label_bubbles_left.text = str(Globals.bubbles_left)
	label_bubbles_popped.text = str(Globals.bubbles_popped)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left"):
		label_bubbles_left.visible = !label_bubbles_left.visible
		check_bubble_labels_visibility()
			
	if event.is_action_pressed("Count"):
		label_bubbles_popped.visible = !label_bubbles_popped.visible
		check_bubble_labels_visibility()

func check_bubble_labels_visibility():
	if label_bubbles_left.visible and label_bubbles_popped.visible:
		label_bubbles_left.add_theme_font_size_override("font_size",bubble_label_font_small)
		label_bubbles_popped.add_theme_font_size_override("font_size",bubble_label_font_small)
	else:
		label_bubbles_left.add_theme_font_size_override("font_size",bubble_label_font_large)
		label_bubbles_popped.add_theme_font_size_override("font_size",bubble_label_font_large)
