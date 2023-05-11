extends Control

@onready var sgb: Button = $HBoxContainer/VBoxContainer/StartGameButton
@onready var qgb: Button = $HBoxContainer/VBoxContainer/QuitGameButton


# Called when the node enters the scene tree for the first time.
func _ready():
	sgb.pressed.connect(_sgb_pressed)
	qgb.pressed.connect(_qgb_pressed)

func _sgb_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	
func _qgb_pressed():
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
