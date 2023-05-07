@tool
extends HBoxContainer

@export var control:String = "Up":
	set(x):
		control = x
		if ControlName:
			ControlName.text = x
			ControlBind.path = x

@onready var ControlName:Label = $ControlName
@onready var ControlBind:ControllerTextureRect = $ControlBind
@onready var Rebinging:Label = $Rebinging

#FIXME: Show multiple Keybinds
func _ready():
	Rebinging.hide()
	ControlName.text = control
	#var bindsTmp = InputMap.action_get_events(control)
	#var binds:Array[String]
	#for x in bindsTmp:
	#	binds.append(x.as_text())
	ControlBind.path = control

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
			ControlBind.hide()
			Rebinging.show()

func _input(event):
	if Rebinging.visible && !event is InputEventMouse:
		print("Assign to key: ", event.as_text())
		InputMap.action_erase_events(control)
		InputMap.action_add_event(control, event)
		ControllerIcons.refresh()
		Rebinging.hide()
		ControlBind.show()
