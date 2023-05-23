class_name GameState extends Object

var tutorial_done:bool = false

signal sticks_changed
var sticks: int  = 0:
	set(x):
		sticks = x
		sticks_changed.emit()
