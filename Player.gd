extends CharacterBody2D

func _physics_process(delta):
	$AnimatedSprite2D.play("Idle")

	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
		$AnimatedSprite2D.play("Run_Right")
	if Input.is_action_pressed("ui_left"):
		direction.x = 1
		$AnimatedSprite2D.play("Run_Left")
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
		$AnimatedSprite2D.play("Run_Down")
	if Input.is_action_pressed("ui_up"):
		direction.y = 1
		$AnimatedSprite2D.play("Run_Up")
	
	self.move_and_collide(direction)
