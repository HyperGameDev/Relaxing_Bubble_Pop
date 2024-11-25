extends MarginContainer

@onready var control_mobile_dark: Control = %Control_Dark
@onready var control_mobile_total: Control = %Control_Total
@onready var control_mobile_count: Control = %Control_Count
@onready var control_mobile_pause: Control = %Control_Pause
@onready var control_mobile_active: Control = %Control_Active

@onready var button_mobile_menu: TouchScreenButton = %Touch_Menu

@onready var button_mobile_dark: TouchScreenButton = %Touch_Dark
@onready var button_mobile_total: TouchScreenButton = %Touch_Total
@onready var button_mobile_count: TouchScreenButton = %Touch_Count
@onready var button_mobile_pause: TouchScreenButton = %Touch_Pause
@onready var button_mobile_active: TouchScreenButton = %Touch_Active

@onready var button_mobile_buttons: VBoxContainer = %VBox_Buttons


func _ready():
	if is_mobile_device():
		visible = true
	else:
		visible = false
	button_mobile_menu.released.connect(on_mobile_menu_released)
	#button_mobile_dark.released.connect(on_mobile_dark_released)
	#button_mobile_total.released.connect(on_mobile_total_released)
	#button_mobile_count.released.connect(on_mobile_count_released)
	#button_mobile_pause.released.connect(on_mobile_pause_released)

func is_mobile_device() -> bool:
	var os_name = OS.get_name()
	var is_mobile_os = os_name == "Android" or os_name == "iOS" 
	var has_web = OS.has_feature("web_android") or OS.has_feature("web_ios")
	
	return is_mobile_os or has_web

func on_mobile_menu_released():
	button_mobile_buttons.visible = !button_mobile_buttons.visible
