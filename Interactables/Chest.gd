extends "res://Interactables/Interactable.gd"

var hasInteracted: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func doStuff():
	if hasInteracted:
		return
	print("Chest :)")
	$AnimatedSprite2D.play("default")
	hasInteracted = true
