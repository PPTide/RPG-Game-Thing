extends CharacterBody2D

var current_anim = ""
var old_direction = ""

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	#TODO: Sind Idle animationen
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
		animNoStart("Run_Right")
		old_direction = "_Right"
	elif Input.is_action_pressed("ui_left"):
		direction.x = -1
		animNoStart("Run_Left")
		old_direction = "_Left"
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1
		animNoStart("Run_Down")
		old_direction = "_Down"
	elif Input.is_action_pressed("ui_up"):
		direction.y = -1
		animNoStart("Run_Up")
		old_direction = "_Up"
	else:
		animNoStart("Idle"+old_direction)
		
		
	self.velocity = direction * 40
	
	self.move_and_slide()

func animNoStart(name):
	if current_anim != name:
		current_anim = name
		$AnimatedSprite2D.play(name)
