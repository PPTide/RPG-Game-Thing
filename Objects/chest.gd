extends StaticBody2D

@export var Item:Node2D

@onready var ActionNotifier:ActionNotifier = $ActionNotifier

# Called when the node enters the scene tree for the first time.
func _ready():
	ActionNotifier.ActionNotify.connect(open)


func open()->void:
	$AnimatedSprite2D.play("default")
