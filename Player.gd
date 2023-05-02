extends CharacterBody2D

var old_direction = "Down"

@onready var actionable_finder: Area2D = $Direction/ActionableFinder
@onready var Direction: Marker2D = $Direction

func _physics_process(_delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
		$AnimationController.play_animation("Run", "Right")
		Direction.rotation_degrees = -90
		old_direction = "Right"
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		$AnimationController.play_animation("Run", "Left")
		Direction.rotation_degrees = 90
		old_direction = "Left"
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
		$AnimationController.play_animation("Run", "Down")
		Direction.rotation_degrees = 0
		old_direction = "Down"
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
		$AnimationController.play_animation("Run", "Up")
		Direction.rotation_degrees = 180
		old_direction = "Up"
	if Input.is_action_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			print("actioned")
		$AnimationController.play_animation("Hit", old_direction)
	elif direction == Vector2.ZERO:
		$AnimationController.play_animation("Idle", old_direction)
		
		
		
	self.velocity = direction * 40
	
	self.move_and_slide()

