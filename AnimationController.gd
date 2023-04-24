extends Node

@export var default_animation = "Idle"
@export_enum("Up", "Down", "Left", "Right") var default_dir:String = "Down"

@onready var old_anim = self.find_child(default_animation)
var overAnimation
var old_dir = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	play_animation(default_animation, default_dir)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play_animation(animation:String, dir:String):
	if (old_anim.name == animation and dir == old_dir):
		return
	if overAnimation:
		#if dir == old_dir:
		#	return
		#var frame = overAnimation.frame
		#overAnimation.play(dir)
		#overAnimation.frame = frame
		#overAnimation.play()
		return
	
	old_anim.hide()
	old_anim.stop()
	
	var anim: PlayerAnimation = self.find_child(animation)
	anim.show()
	anim.play(dir)
	if !anim.repeats:
		overAnimation = anim
		anim.animation_finished.connect(reset_animation)
	old_anim = anim
	old_dir = dir

func reset_animation():
	overAnimation.animation_finished.disconnect(reset_animation)
	overAnimation = false
