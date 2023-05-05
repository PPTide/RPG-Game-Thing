extends HBoxContainer

@export var control:String = "Up"

@onready var ControlName:Label = $ControlName
@onready var ControlBind:ControllerTextureRect = $ControlBind

#FIXME: Help here
func _ready():
	ControlName.text = control
	var bindsTmp = InputMap.action_get_events(control)
	var binds:Array[String]
	for x in bindsTmp:
		binds.append(x.as_text())
	ControlBind.path = control

func join(array:Array[String],filler:String) -> String:
	var rs = ""
		
	for s in array:
		rs += s+filler

	#rs.erase( rs.length()-1, 1)
	return rs
