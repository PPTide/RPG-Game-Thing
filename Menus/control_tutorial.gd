extends PanelContainer

func _ready():
	State.game.tutorial_changed.connect(_tutorial_changed)
	_tutorial_changed()
	
func _tutorial_changed():
	if State.game.tutorial_done:
		hide()
	else:
		show()
