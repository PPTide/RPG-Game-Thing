extends Control

class_name PauseMenu

# Node references
var LastScreens:Array[String] = []
@onready var Pause: VBoxContainer = $Pause
@onready var Settings: VBoxContainer = $Settings
@onready var ControlsKeyboard: VBoxContainer = $ControlsKeyboard
@onready var ControlsController: VBoxContainer = $ControlsController
@onready var BackButton: Button = $BackButton
@onready var BG: Panel = $BG

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_view()
	
	# Connect button signals
	$Pause/SettingsButton.pressed.connect(_settings_button_pressed)
	$Pause/MenuButton.pressed.connect(_menu_button_pressed)
	$Pause/ContinueButton.pressed.connect(_continue_button_pressed)
	BackButton.pressed.connect(_back_button_pressed)
	
# Resets the view to the pause menu
func reset_view():
	LastScreens = []
	hide_all_children()
	Pause.show()
	BackButton.hide()

# Hides all child nodes of the PauseMenu
func hide_all_children():
	for child in self.get_children():
		child.hide()
	BG.show()
	BackButton.show()

# Handles unhandled input events
func _unhandled_input(event):
	if event.is_action_pressed("Pause"):
		# If the PauseMenu is not visible, show it and pause the game
		if !visible:
			reset_view()
			get_tree().paused = true
			visible = true
			return
		# If there are previous screens, show the last one
		if len(LastScreens) > 1:
			hide_all_children()
			self.find_child(LastScreens.pop_back()).show()
			return
		# If there is only one previous screen, reset the view
		if len(LastScreens) == 1:
			reset_view()
			return
		# Otherwise, hide the PauseMenu and unpause the game
		self.hide()
		get_tree().paused = false

# Shows the settings screen
func _settings_button_pressed():
	LastScreens.append("Pause")
	hide_all_children()
	Settings.show()
	
# Exits to the main menu
func _menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

# Hides the PauseMenu and unpauses the game
func _continue_button_pressed():
	self.hide()
	get_tree().paused = false
	
# Goes back to the previous screen
func _back_button_pressed():
	if len(LastScreens) > 1:
		hide_all_children()
		self.find_child(LastScreens.pop_back()).show()
		return
	if len(LastScreens) == 1:
		reset_view()
		return
