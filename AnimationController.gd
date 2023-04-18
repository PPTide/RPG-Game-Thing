extends Node

@export var default_animation = "Idle"
@export var default_dir = "Down"

@onready var old_anim = self.find_child(default_animation)
var old_dir = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	play_animation(default_animation, default_dir)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_animation(animation, dir):
	if old_anim.name == animation and dir == old_dir:
		return
	
	print("playing animation ", animation, " in direction ", dir)
	
	old_anim.hide()
	old_anim.stop()
	
	var anim = self.find_child(animation)
	anim.show()
	anim.play(dir)
	old_anim = anim
	old_dir = dir
