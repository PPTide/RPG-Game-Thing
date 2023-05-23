extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	State.game.sticks_changed.connect(_update_sticks)
	_update_sticks()


func _update_sticks():
	$Amount.text = str(State.game.sticks)
