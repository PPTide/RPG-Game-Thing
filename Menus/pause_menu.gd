extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	reset_view()
	
	$Pause/SettingsButton.pressed.connect(_settings_button_pressed)
	$Pause/MenuButton.pressed.connect(_menu_button_pressed)
	
func reset_view():
	hide_all_children()
	$Pause.show()

func hide_all_children():
	for child in self.get_children():
		child.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		reset_view()
		get_tree().paused = !get_tree().paused
		self.visible = !self.visible

func _settings_button_pressed():
	hide_all_children()
	$Settings.show()
	
func _menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")
