# This script defines a custom control for displaying and editing input bindings.

# Exported variables
@tool
extends HBoxContainer

# Import the ControllerTextureRect class from the controller_icons module
var ControlBind = preload("res://addons/controller_icons/objects/TextureRect.gd")

@export var control:String = "Up":
	set(x):
		control = x
		if ControlName:
			ControlName.text = x
			_load_binds()

@export_enum("None (doesn't work)", "Keyboard/Mouse", "Controller") var force_type

# Node references
@onready var ControlName:Label = $ControlName
@onready var ControlBinds:HBoxContainer = $ControlBinds
@onready var Rebinging:Label = $Rebinging

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hide the "Rebinging" label and set the control name
	Rebinging.hide()
	ControlName.text = control
	_load_binds()

# Loads the input bindings for the current control
func _load_binds():
	# Remove any existing child nodes from the ControlBinds container
	for child in ControlBinds.get_children():
		ControlBinds.remove_child(child)
	
	# Get the events associated with the current control
	var events = InputMap.action_get_events(control)
	var i: int = 0
	
	# Create a new ControllerTextureRect node for each event
	for event in events:
		match event.get_class():
			"InputEventKey", "InputEventMouse", "InputEventMouseMotion", "InputEventMouseButton":
				if force_type == 2:
					continue
				var cb:ControllerTextureRect = ControlBind.new()
				cb.path = control
				cb.index = i
				cb.force_type = 1 #FIXME: No Controller support
				ControlBinds.add_child(cb)
				i += 1
			"InputEventJoypadButton", "InputEventJoypadMotion":
				if force_type == 1:
					continue
				var cb:ControllerTextureRect = ControlBind.new()
				cb.path = control
				cb.index = i
				cb.force_type = 2 #FIXME: No Controller support
				ControlBinds.add_child(cb)
				i += 1
			_:
				printerr("Ahhh weird type")

# Joins an array of strings with a specified filler string
func join(array:Array[String],filler:String) -> String:
	var rs = ""
		
	for s in array:
		rs += s+filler

	return rs

# Called when a GUI input event occurs
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Rebinging.show()

# Called when an input event occurs
func _input(event):
	if Rebinging.visible && !event is InputEventMouse:
		if InputMap.action_has_event(control, event):
			InputMap.action_erase_event(control, event)
		else:
			InputMap.action_add_event(control, event)
		_load_binds()
		State.settings.update_binds()
		ControllerIcons.refresh()
		Rebinging.hide()
