extends CharacterBody2D

var old_direction = "Down"

const SPEED = 40

@onready var ActionableFinder: Area2D = $Direction/ActionableFinder
@onready var Direction: Marker2D = $Direction

func _physics_process(_delta):
	var direction = Vector2.ZERO
	
	#FIXME: Directions between up/down and right/left don't work in animation
	if Input.is_action_pressed("Right"):
		direction.x = 1
		$AnimationController.play_animation("Run", "Right")
		Direction.rotation_degrees = -90
		old_direction = "Right"
	if Input.is_action_pressed("Left"):
		direction.x = -1
		$AnimationController.play_animation("Run", "Left")
		Direction.rotation_degrees = 90
		old_direction = "Left"
	if Input.is_action_pressed("Down"):
		direction.y = 1
		$AnimationController.play_animation("Run", "Down")
		Direction.rotation_degrees = 0
		old_direction = "Down"
	if Input.is_action_pressed("Up"):
		direction.y = -1
		$AnimationController.play_animation("Run", "Up")
		Direction.rotation_degrees = 180
		old_direction = "Up"
	if Input.is_action_pressed("Use"):
		var actionables = ActionableFinder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			print("actioned")
		#TODO: Play animation based on what Action
		$AnimationController.play_animation("Hit", old_direction)
	elif direction == Vector2.ZERO:
		$AnimationController.play_animation("Idle", old_direction)
		
		
		
	self.velocity = direction * SPEED
	
	self.move_and_slide()

