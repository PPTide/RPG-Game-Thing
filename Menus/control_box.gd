@tool
extends HBoxContainer

@export var control:String = "Up":
	set(x):
		control = x
		if ControlName:
			ControlName.text = x
			_load_binds()
			
@export_enum("None (doesn't work)", "Keyboard/Mouse", "Controller") var force_type

@onready var ControlName:Label = $ControlName
@onready var ControlBinds:HBoxContainer = $ControlBinds
@onready var Rebinging:Label = $Rebinging

var ControlBind = preload("res://addons/controller_icons/objects/TextureRect.gd")

#FIXME: Show multiple Keybinds
func _ready():
	Rebinging.hide()
	ControlName.text = control
	#var bindsTmp = InputMap.action_get_events(control)
	#var binds:Array[String]
	#for x in bindsTmp:
	#	binds.append(x.as_text())
	_load_binds()
	
func _load_binds():
	for child in ControlBinds.get_children():
		ControlBinds.remove_child(child)
	var events = InputMap.action_get_events(control)
	var i: int = 0
	for event in events:
		match event.get_class():
			"InputEventKey", "InputEventMouse", "InputEventMouseMotion", "InputEventMouseButton":
				if force_type == 2:
					continue
				print("Add child %d for %s" % [i, control])
				var cb:ControllerTextureRect = ControlBind.new()
				cb.path = control
				cb.index = i
				cb.force_type = 1 #FIXME: No Controller support
				ControlBinds.add_child(cb)
				i += 1
			"InputEventJoypadButton", "InputEventJoypadMotion":
				if force_type == 1:
					continue
				print("Add child %d for %s" % [i, control])
				var cb:ControllerTextureRect = ControlBind.new()
				cb.path = control
				cb.index = i
				cb.force_type = 2 #FIXME: No Controller support
				ControlBinds.add_child(cb)
				i += 1
			_:
				printerr("Ahhh weird type")

func join(array:Array[String],filler:String) -> String:
	var rs = ""
		
	for s in array:
		rs += s+filler

	#rs.erase( rs.length()-1, 1)
	return rs

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#print("I've been clicked D:")
			#FIXME: Find another solution
			#ControlBinds.hide()
			Rebinging.show()

func _input(event):
	if Rebinging.visible && !event is InputEventMouse:
		#print("Assign to key: ", event.as_text())
		#InputMap.action_erase_events(control)
		#InputMap.action_add_event(control, event)
		
		if InputMap.action_has_event(control, event):
			InputMap.action_erase_event(control, event)
		else:
			InputMap.action_add_event(control, event)
		_load_binds()
		ControllerIcons.refresh()
		Rebinging.hide()
		#ControlBinds.show()
