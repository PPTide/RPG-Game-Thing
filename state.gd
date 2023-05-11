extends Node


var characterTalking:bool = false

var settings:Settings

func save_game():
	var f = FileAccess.open("user://settings.save", FileAccess.WRITE)
	#var tmp = settings._get_property_list()
	f.store_pascal_string(var_to_str(settings))

func load_game():
	if FileAccess.file_exists("user://settings.save"):
		var f = FileAccess.open("user://settings.save", FileAccess.READ)
		settings = str_to_var(f.get_pascal_string())
		settings.apply()
	else:
		settings = Settings.new()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("Saving Game")
		save_game()
		get_tree().quit() # default behavior

func _enter_tree():
	print("Loading Game")
	load_game()
