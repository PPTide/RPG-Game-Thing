class_name GameState extends Object

signal tutorial_changed
var tutorial_done:bool = false:
	set(x):
		tutorial_done = x
		tutorial_changed.emit()

signal sticks_changed
var sticks: int  = 0:
	set(x):
		sticks = x
		sticks_changed.emit()
