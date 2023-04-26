extends Area2D

class_name Actionable

var interaction_active:bool = false

func action() -> void:
	interaction_active = true
	var timer: SceneTreeTimer = get_tree().create_timer(1)
	timer.timeout.connect(reset_action)

func reset_action() -> void:
	interaction_active = false
