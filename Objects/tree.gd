extends StaticBody2D

@onready var ActionNotifier:ActionNotifier = $ActionNotifier

# Called when the node enters the scene tree for the first time.
func _ready():
	ActionNotifier.ActionNotify.connect(open)


func open()->void:
	State.game.sticks += 1
	print("Sticks: ", State.game.sticks)
