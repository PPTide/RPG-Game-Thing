extends Control

class_name PauseMenu

var LastScreens:Array[String] = []

@onready var Pause: VBoxContainer = $Pause
@onready var Settings: VBoxContainer = $Settings
@onready var ControlsKeyboard: VBoxContainer = $ControlsKeyboard
@onready var ControlsController: VBoxContainer = $ControlsController

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_view()
	
	$Pause/SettingsButton.pressed.connect(_settings_button_pressed)
	$Pause/MenuButton.pressed.connect(_menu_button_pressed)
	$Pause/ContinueButton.pressed.connect(_continue_button_pressed)
	
func reset_view():
	hide_all_children()
	$Pause.show()

func hide_all_children():
	for child in self.get_children():
		child.hide()
	$BG.show()

func _unhandled_input(event):
	if event.is_action_pressed("Pause"):
		if !visible:
			reset_view()
			get_tree().paused = true
			visible = true
			return
		if len(LastScreens) > 0:
			hide_all_children()
			self.find_child(LastScreens.pop_back()).show()
			return
		self.hide()
		get_tree().paused = false

func _settings_button_pressed():
	LastScreens.append("Pause")
	hide_all_children()
	$Settings.show()
	
func _menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

func _continue_button_pressed():
	if len(LastScreens) > 0:
		hide_all_children()
		self.find_child(LastScreens.pop_back()).show()
		return
	self.hide()
	get_tree().paused = false
	
