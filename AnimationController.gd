extends Node

# Exported variables
@export var default_animation = "Idle"
@export_enum("Up", "Down", "Left", "Right") var default_dir:String = "Down"

# Node references
@onready var old_anim = self.find_child(default_animation)
var overAnimation
var old_dir = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	# Play the default animation
	play_animation(default_animation, default_dir)

# Plays the specified animation in the specified direction.
func play_animation(animation:String, dir:String):
	# If the animation is already playing in the specified direction, do nothing
	if (old_anim.name == animation and dir == old_dir):
		return
	
	# If there is an animation currently playing, stop it and hide it
	if overAnimation:
			return
	
	old_anim.hide()
	old_anim.stop()
	
	# Show and play the new animation
	var anim: PlayerAnimation = self.find_child(animation)
	anim.show()
	anim.play(dir)
	
	# If the new animation does not repeat, save it as the overAnimation
	if !anim.repeats:
		overAnimation = anim
		anim.animation_finished.connect(reset_animation)

	old_anim = anim
	old_dir = dir

# Resets the overAnimation when it finishes playing
func reset_animation():
	overAnimation.animation_finished.disconnect(reset_animation)
	overAnimation = false
