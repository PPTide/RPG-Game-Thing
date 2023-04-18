extends CharacterBody2D

var old_direction = "Down"

func _physics_process(_delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_accept"):
		$AnimationController.play_animation("Hit", old_direction)
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
		$AnimationController.play_animation("Run", "Right")
		old_direction = "Right"
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		$AnimationController.play_animation("Run", "Left")
		old_direction = "Left"
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
		$AnimationController.play_animation("Run", "Down")
		old_direction = "Down"
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
		$AnimationController.play_animation("Run", "Up")
		old_direction = "Up"
	if direction == Vector2.ZERO:
		$AnimationController.play_animation("Idle", old_direction)
		
		
		
	self.velocity = direction * 40
	
	self.move_and_slide()

